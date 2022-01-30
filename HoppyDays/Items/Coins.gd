extends Node2D

var taken = false

func _on_Area2D_body_entered(_body):
	if not taken:  #we are doing this to prevent getting multiple coins till node get freed
		taken = true
		$AnimationPlayer.play("Vanish")
		$AudioStreamPlayer.play()
		get_tree().call_group("Gamestate","coin_up")

func coin_vanish():
	queue_free()
