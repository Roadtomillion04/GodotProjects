extends Node2D

const PLAYER = preload("res://Game/Player.tscn")

var borders = Rect2(1, 1, 38, 21)

onready var tilemap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(500)
	
	var player = PLAYER.instance()
	add_child(player)
	player.position = map.front() * 32
	
	walker.queue_free()
	for location in map:
		tilemap.set_cellv(location, -1)
	tilemap.update_bitmask_region(borders.position, borders.end)

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
