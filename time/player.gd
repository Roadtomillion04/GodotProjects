extends KinematicBody2D

var max_speed = 90
const acceleration = 600
const friction = 300
var state = MOVE
var roll_vector = Vector2.RIGHT
var statsforplayer = StatsForWorldPlayer 
var Bullet = preload("res://Projectile.tscn")
var bulletspeed = 500

enum {
	MOVE,
	ROLL,
	ATTACK,
	SHOOT
}

onready var swordhitbox = $SwordHitPosition/SwordHitBox
onready var animationPlayer =  $AnimationPlayer
onready var animationTree = $AnimationTree
onready var hurtbox = $HurtBox
onready var animationState = animationTree.get("parameters/playback")
var velocity = Vector2.ZERO
onready var ray = $RayCast2D
#var screen_size

func _ready():
	animationTree.active = true
	swordhitbox.knockback_vector = roll_vector
	statsforplayer.connect("died",self,"on_Player_died")
	#screen_size = get_viewport_rect().size
		
	
func _physics_process(delta):#delta calculates every single frame used for smooth performance
	match state:
	#match similar to if else too
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state(delta)
			
		ATTACK:
			attack_state(delta)
		
		SHOOT:
			fire_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordhitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationTree.set("parameters/Bullet/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed,acceleration*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)#friction*delta for skity movement
		animationState.travel("Idle")
	
	move()
		
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	elif Input.is_action_just_pressed("Roll"):
		state = ROLL
	
	elif Input.is_action_just_pressed("shoot"):
		state = SHOOT
		fire()
		

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_animation_finished():
	state = MOVE
	
func roll_state(delta):
	velocity = roll_vector * 125
	animationState.travel("Roll")
	move()
	
func roll_state_finished():
	state = MOVE
	
func fire_state(delta):
	animationState.travel("Bullet")
	
func fire_state_finished():
	state = MOVE
	
func move():#function is a piece of code can be used anywhere
	velocity = move_and_slide(velocity,Vector2.UP)
func _unhandled_input(event):
	if Input.is_action_just_pressed("shoot") and ray.is_colliding():
		fire()

func on_Player_died():
	get_tree().change_scene("res://Game_overScreen.tscn")
	queue_free()


func _on_HurtBox_area_entered(_area):
  statsforplayer.health -= 1
  hurtbox.create_hit_effect()
  hurtbox.start_invincibility(1)
 
 
func fire():
	var bullet = Bullet.instance()
	bullet.rotation_degrees = rotation_degrees
	bullet.apply_central_impulse(Vector2(bulletspeed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet)
	bullet.global_position = $Position2D.global_position


