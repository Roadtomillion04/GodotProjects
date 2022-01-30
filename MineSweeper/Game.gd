extends Control

export var GRID_SIZE: int = 6

var CELL_COUNT = GRID_SIZE * GRID_SIZE
var MINE_COUNT = int(CELL_COUNT / 4)
var CLICKABLE_CELLS = CELL_COUNT - MINE_COUNT
export var total_lives: int = int(MINE_COUNT / 3)

onready var grid = get_node("GridContainer")
onready var cell_count_label = $Info/Cell_count
onready var lives_left_label = $Info/lives_left
onready var message_box = $AcceptDialog

const BUTTON_SCENE = preload("res://ButtonClass.tscn")

var picked_cells
var all_cells: Array = []
var cell_opened = false


func _ready():
	randomize()

	for row in range(6):
		for col in range(6):
			var btn = BUTTON_SCENE.instance()
			btn.button_pos.x = row
			btn.button_pos.y = col 
			
			all_cells.append(btn)
			
			grid.add_child(btn)
			

	all_cells.shuffle() # slice includes end
	picked_cells = all_cells.slice(1, 9)
	print(picked_cells)

	for cell_inst in picked_cells:
		cell_inst.is_mine = true

	cell_count_label.text = "cells left: " + str(CLICKABLE_CELLS)
	lives_left_label.text = "lives left: " + str(total_lives)

func get_cell_by_axis(pos: Vector2):
	for cell in all_cells:
		if cell.button_pos.x == pos.x and cell.button_pos.y == pos.y:
			return cell
	return null

func display_mines_around(button_pos, button):
	
	if not cell_opened:
		CLICKABLE_CELLS -= 1
		cell_count_label.text = "cells left: " + str(CLICKABLE_CELLS)	
		cell_opened = true
	cell_opened = false
	button.set("button_mask", BUTTON_MASK_RIGHT)
	
	# win condition
	if CLICKABLE_CELLS == 0:
		cell_count_label.text = "YOU WIN!!!"
		message_box.popup_centered()
		message_box.dialog_text = 'Restart?'
	
	var surrounded_cells = []
	
	for i in range(-1, 2):
		for j in range(-1, 2):
			if get_cell_by_axis(Vector2(button_pos.x + i, button_pos.y + j)) != null: # null filter
				surrounded_cells.append(get_cell_by_axis( Vector2(button_pos.x + i, button_pos.y + j)))


	var counter = 0
	for cell_obj in surrounded_cells:
		if cell_obj.is_mine:
			counter += 1
		
	return counter



func show_mines():
	total_lives -= 1
	lives_left_label.text = "lives left: " + str(total_lives)

	# lose condition
	if total_lives < 0:
		lives_left_label.text = "YOU LOST :("
		message_box.popup_centered()
		message_box.dialog_text = 'Restart?'
		

func _on_AcceptDialog_confirmed():
	get_tree().reload_current_scene()
