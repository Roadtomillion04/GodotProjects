extends Node2D

onready var tilemap = get_node("TileMap")
onready var level_size = tilemap.get_used_rect().size
onready var score_container = get_node("ScoreBlocks")

const BLOCKS: PackedScene = preload("res://Score/Blocks.tscn")

const TILE_SIZE: float = 16.0
const GROUND_TILE_INDEX: int = 1

func _ready():
	for x in level_size.x:
		for y in level_size.y:
			var middle_pos = Vector2(x * TILE_SIZE + TILE_SIZE/2, y * TILE_SIZE + TILE_SIZE/2)

			if tilemap.get_cellv(Vector2(x, y)) == GROUND_TILE_INDEX: #gets cell by vector
				var blocks = BLOCKS.instance()
				score_container.add_child(blocks)
				blocks.position = middle_pos
