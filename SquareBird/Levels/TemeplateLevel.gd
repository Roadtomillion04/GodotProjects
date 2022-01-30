extends Node

var tile_speed = 200

func _physics_process(delta):
	$TileMap.position.x -= tile_speed * delta 
