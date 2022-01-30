extends Node2D

onready var canvaslayer = get_tree().current_scene
var start = true
var speed = -1.5

func _physics_process(delta):
		position += Vector2(-1.5,0)
		


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

	#if canvaslayer.score > 25:
		#position += Vector2(-0.25,0)
		#if canvaslayer.score > 50:
			#position += Vector2(-0.3,0)
