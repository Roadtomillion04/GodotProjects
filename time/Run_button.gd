extends "res://Action_button.gd"

export (String, FILE , "*.tscn") var next_scene
export (Vector2) var spawn_pos
 
func _on_pressed():
	get_tree().change_scene(next_scene)
	Global.player_pos = spawn_pos
	

