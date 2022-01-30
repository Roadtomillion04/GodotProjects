extends Area2D

onready var hintlabel = get_node("../../CanvasLayer/HintLabel")

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	hintlabel.hide()
	for body in bodies:
		if body.name == "Player":
			hintlabel.show()
			hintlabel.text = " E"	
			if Input.is_action_pressed("use"):
				get_tree().change_scene("res://world 2.tscn")
				queue_free()
	
