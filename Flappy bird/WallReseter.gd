extends Area2D

var Wall = preload("res://Walls.tscn")

func _wall_reseter():
	var walls = Wall.instance()
	walls.position = Vector2(600,rand_range(40,120))
	get_parent().call_deferred("add_child",walls)
	



func _on_WallReseter_area_entered(area):
		_wall_reseter()
	



