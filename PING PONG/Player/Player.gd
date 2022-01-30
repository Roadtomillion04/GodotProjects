extends KinematicBody2D

var speed = 400

func _physics_process(_delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		velocity.y -= 1
	if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		velocity.y += 1
		
	var _err = move_and_slide(velocity * speed)#use var _ to debug warning
