extends KinematicBody2D

var velocity = Vector2()
export var speed = 100
var facing_direction
var can_attack = false

onready var AttackPivot = $AttackPivot
onready var weapon_hitbox = $AttackPivot/WeaponHitbox
onready var InteractionBox = $InteractArea/InteractionBox
onready var InteractArea = $InteractArea

const Projectile = preload("res://Player/Projectile.tscn")


func _ready():
	weapon_hitbox.disabled = true
	InteractionBox.disabled = true

func _process(delta):
	Interact()
	move()
	attack()
	move_and_slide(velocity)

func move():
	velocity = Vector2.ZERO #Adding here when no Input pressed updates to 0
	velocity = velocity.normalized() * speed
	
	if not can_attack:
		# Remeber to put elif, Only then animatedSprite plays correctly
		if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT"):
			velocity.x = -speed
			AttackPivot.rotation_degrees = 90
			AttackPivot.position = Vector2(0,0)
			InteractArea.rotation_degrees = 90
			InteractArea.position = Vector2(0,0)
			$AnimatedSprite.play("left")
			facing_direction = "Left"
		
		elif Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
			velocity.x = speed
			AttackPivot.rotation_degrees = 270
			AttackPivot.position = Vector2(0,5)
			InteractArea.rotation_degrees = 270
			InteractArea.position = Vector2(0,5)
			$AnimatedSprite.play("right")
			facing_direction = "Right"
		
		elif Input.is_action_pressed("UP") and not Input.is_action_pressed("DOWN"):
			velocity.y = -speed
			AttackPivot.rotation_degrees = 180
			AttackPivot.position = Vector2(0,5)
			InteractArea.rotation_degrees = 180
			InteractArea.position = Vector2(0,5)
			$AnimatedSprite.play("up")
			facing_direction = "Up"
		
		elif Input.is_action_pressed("DOWN") and not Input.is_action_pressed("UP"):
			velocity.y = speed
			AttackPivot.rotation_degrees = 0
			AttackPivot.position = Vector2(0,0)
			InteractArea.rotation_degrees = 0
			InteractArea.position = Vector2(0,0)
			$AnimatedSprite.play("down")
			facing_direction = "Down"
		
		else: #Do not set playing = false or it wont play at all!
			idle()

func attack():
	if Input.is_action_just_pressed("attack"):
		can_attack = true
		
		if facing_direction == "Down":
			$AnimatedSprite.play("attack_down")
			weapon_hitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			weapon_hitbox.disabled = true
			can_attack = false

		if facing_direction == "Up":
			$AnimatedSprite.play("attack_up")
			weapon_hitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			weapon_hitbox.disabled = true
			can_attack = false
	
		if facing_direction == "Left":
			$AnimatedSprite.play("attack_left")
			weapon_hitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			weapon_hitbox.disabled = true
			can_attack = false

		if facing_direction == "Right":
			$AnimatedSprite.play("attack_right")
			weapon_hitbox.disabled = false
			yield(get_tree().create_timer(0.4),"timeout")
			weapon_hitbox.disabled = true
			can_attack = false
			
		var position_spawn = $Position.global_position
		create_projectile(position_spawn)

func idle(): #I know this is not a good code, Soon I should fix it
	if can_attack == false and facing_direction == "Left":
		$AnimatedSprite.play("left")
		$AnimatedSprite.frame = 1
		
	elif can_attack == false and facing_direction == "Right":
		$AnimatedSprite.play("right")
		$AnimatedSprite.frame = 1
		
	elif can_attack == false and facing_direction == "Up":
		$AnimatedSprite.play("up")
		$AnimatedSprite.frame = 1
		
	elif can_attack == false and facing_direction == "Down":
		$AnimatedSprite.play("down")
		$AnimatedSprite.frame = 1

func Interact():
	if Input.is_action_pressed("interact"):
		InteractionBox.disabled = false
		yield(get_tree().create_timer(0.2),"timeout")
		InteractionBox.disabled = true


func _on_InteractArea_area_entered(area):
	get_tree().call_group("NPC", "investment_popup")
	if area.is_in_group("NPC"):
		if facing_direction == "Left":
			area.faceright()

		elif facing_direction == "Right":
			area.faceleft()

		elif facing_direction == "Up":
			area.facedown()

		elif facing_direction == "Down":
			area.faceup()


func create_projectile(pos):
	var projectile = Projectile.instance()
	projectile.set_position(pos)
	get_parent().add_child(projectile)
	if facing_direction == "Left":
		get_parent().get_node("Projectile").motion = Vector2(-500, 0)
		
	if facing_direction == "Right":
		get_parent().get_node("Projectile").motion = Vector2(500, 0)
		
	if facing_direction == "Up":
		get_parent().get_node("Projectile").motion = Vector2(0, -500)
		
	if facing_direction == "Down":
		get_parent().get_node("Projectile").motion = Vector2(0, 500)
	return projectile


func Hurt(dmg):
	PlayerStats.Stats.CurrentHealth -= dmg
	#$Hurt.play()
	print(PlayerStats.Stats.CurrentHealth)


















