extends KinematicBody2D

var speed = 600
var velocity = Vector2.ZERO

var player

func _ready():
	player = get_node("../Player")

func _physics_process(delta):
	position.x = player.position.x
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y -= 1
		
	var collider = move_and_collide(velocity * speed * delta)
	if collider:
		velocity = velocity.bounce(collider.normal)
