extends KinematicBody2D

var velocity:Vector2 = Vector2()
var speed:int = 175
var screen_size
var bulletspeed:int = 1250
var firebullets :bool= true
var setfiresplit:bool = false
var canfire:bool = true
var firerate:float = 0.5
var upgrade0:bool = true
var upgrade1:bool = false
var upgrade2:bool = false
var upgrade3:bool = false
var upgrade4:bool = false


var set_upgrade2:bool = false
var set_upgrade3:bool = false


onready var Bullet = preload("res://Projectile.tscn")
onready var Rocket = preload("res://RocketProjectile.tscn")
onready var powerups = get_node("../Powerups")
onready var timer = get_node("../Powerups/PowerUpDurabilty_Timer")
onready var reloadlabel = get_node("../CanvasLayer/ReloadLabel")
onready var firingpositions = $FiringPositions
onready var firedelaytimer = $FireDelayTimer

func _ready():
	firedelaytimer.start()
	screen_size = get_viewport_rect().size
	reloadlabel.connect("reload",self,"_on_ReloadLabel_reload")
	
func _physics_process(delta):
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1 
		
	elif Input.is_action_pressed("down"):
		velocity.y += 1
		
	else:
		velocity = Vector2.ZERO
		
	velocity = velocity.normalized() * speed	
	velocity = move_and_slide(velocity)
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if firedelaytimer.is_stopped():#retuns true when wait time is 0 So automated bullets will fire forever
		if upgrade0==true and setfiresplit == false:
			fire0()
		if upgrade1 == true :
			fire()
			set_upgrade2 = true
		if upgrade2 == true:
			fire2()
			set_upgrade3 = true
		if upgrade3 == true:
			fire3()
			
func fire0():
	if upgrade0 == true:
		firedelaytimer.start(firerate)
		var bullet0 = Bullet.instance()
		bullet0.apply_impulse(Vector2(),Vector2(bulletspeed,0))
		get_tree().get_root().call_deferred("add_child",bullet0)
		bullet0.global_position = $POs.global_position


func fire():
	for positions in firingpositions.get_children():#positions is just refrence
		firedelaytimer.start(firerate)#avoid giving direct values becoz we can change variable anywhere like in boosters
		reloadlabel.bullets -= 1
		var bullet = Bullet.instance()
		bullet.apply_impulse(Vector2(),Vector2(bulletspeed,0))
		get_tree().get_root().call_deferred("add_child",bullet)
		bullet.global_position = positions.global_position
		
func fire2():#2 split
	for positions in firingpositions.get_children():
		firedelaytimer.start(firerate)
		var bullet2 = Bullet.instance()
		bullet2.apply_impulse(Vector2(),Vector2(bulletspeed,-100))
		get_tree().get_root().call_deferred("add_child",bullet2)
		bullet2.global_position = positions.global_position

func fire3():#3 split
	for positions in firingpositions.get_children():
		firedelaytimer.start(firerate)
		var bullet3 = Bullet.instance()
		bullet3.apply_impulse(Vector2(),Vector2(bulletspeed,100))
		get_tree().get_root().call_deferred("add_child",bullet3)
		bullet3.global_position = positions.global_position
	
func fire_rocket():
	for positions in firingpositions.get_children():
		firedelaytimer.start(firerate)
		reloadlabel.bullets -= 1
		var rocket = Rocket.instance()
		rocket.apply_impulse(Vector2(),Vector2(bulletspeed,0))
		get_tree().get_root().call_deferred("add_child",rocket)
		rocket.global_position = positions.global_position	



func _on_PlayerCollison_area_entered(_area):
		queue_free()


func _on_PowerUpDurabilty_Timer_timeout():#Dont forgot this or variables wont update back to its original value
	firebullets = true
	firerate = 0.5
	print("ab")


func _on_ReloadLabel_reload():
	canfire = false
		#remerber:set in process
		#if Input.is_action_just_pressed("reload"):#remeber always use Input.actions in process function
		#yield(get_tree().create_timer(2),"timeout")
		#canfire = true
		#reloadlabel.bullets = reloadlabel.max_bulets
		#emit_signal("updatelabel",reloadlabel.bullets)
