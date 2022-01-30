extends StaticBody2D

export var rock_speed = 400

func _physics_process(delta):
	position.x -= rock_speed * delta
