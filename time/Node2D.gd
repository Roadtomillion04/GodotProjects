extends Node2D


func _ready():
	if Global.player_pos:
		get_node("PlayerYsort/Player").global_position = Global.player_pos   

# setting player pos to autoload? :(
