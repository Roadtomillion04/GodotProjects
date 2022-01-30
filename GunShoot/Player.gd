extends KinematicBody2D

onready var Bullet = preload("res://Bullet.tscn")
var bulletspeed = 500

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Space"):
		fire()
	
func fire():
	var bullet = Bullet.instance()
	bullet.rotation_degrees = rotation_degrees
	bullet.apply_impulse(Vector2(),Vector2(bulletspeed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet)
	bullet.global_position = global_position
