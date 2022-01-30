extends Area2D
#levelcomplete
export (String, FILE , "*.tscn") var next_scene
export (Vector2) var spawn_pos


func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(next_scene)
			Global.player_pos = spawn_pos
	
	
func _on_Door_area_entered(_area: Area2D) -> void:#idk what it is
	if next_scene:
		get_node("/root/Global").player_pos = spawn_pos


