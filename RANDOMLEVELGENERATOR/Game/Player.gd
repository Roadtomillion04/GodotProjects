extends KinematicBody2D

var speed = 600

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if Input.is_action_pressed("down"):
		velocity.y += 1

	if Input.is_action_pressed("left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
		
	move_and_slide(velocity.normalized() * speed)
