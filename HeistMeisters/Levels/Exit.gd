extends ColorRect

# Make Sure to Remove layer and set Mask to player!

func _on_Area2D_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().change_scene("res://Interface/Lobby.tscn")
