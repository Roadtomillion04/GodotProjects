extends KinematicBody2D

onready var animated_sprite = get_node("AnimatedSprite")


var velocity: Vector2 = Vector2.ZERO
var move_speed = 200
var direction


func _physics_process(delta):
	move(delta)


func move(delta):
	if velocity == Vector2.ZERO:
		if Input.is_action_just_pressed("down"):
			velocity = Vector2.DOWN
			animated_sprite.play("down")

		if Input.is_action_just_pressed("left"):
			velocity = Vector2.LEFT
			animated_sprite.play("left")

		if Input.is_action_just_pressed("right"):
			velocity = Vector2.RIGHT
			animated_sprite.play("right")

		if Input.is_action_just_pressed("up"):
			velocity = Vector2.UP
			animated_sprite.play("up")

	var collider = move_and_collide(velocity * move_speed * delta)
	
	if collider:
		velocity = Vector2.ZERO
