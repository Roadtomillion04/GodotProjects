extends KinematicBody2D

var gravity = 4
var jump_force = 136

onready var scorelabel = $"../CanvasLayer/ScoreLabel"
var motion = Vector2.ZERO

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_just_pressed("Space"):
		 motion.y = -jump_force
	
	motion = move_and_slide(motion)



func _on_VisibilityNotifier2D_screen_exited():
	get_tree().reload_current_scene()

signal died

func _on_Area2D_body_entered(body):
	if body.name == "Walls":
		hide()
		emit_signal("died")
		
		
		


