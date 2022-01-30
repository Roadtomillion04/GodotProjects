extends Control

onready var tween = $Tween
onready var label = $Label

signal start_game

func _process(delta):
	if Input.is_action_pressed("Space"):
		emit_signal("start_game")
		label.hide()
