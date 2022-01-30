extends RigidBody2D

var direction = Vector2.LEFT
var speed = 1000

func _process(delta):
	translate(direction*speed*delta)

