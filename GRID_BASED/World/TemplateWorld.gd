extends Node2D

var game_over = false

export var currentlevel:int = 1
const save_path = "user://savedata.save"

var game_width = 1280
var game_height = 720
var cell_size = 16

func _ready():
	pass#load_bestmoves()
	#$CanvasLayer/BestLabel.text = "best: " + str(Global.best)
	#print(Global.best)
	
#	for x in game_width/cell_size: # this fills the enire screen with tilemap
#		for y in game_height/cell_size:
#			$Wall.set_cell(x, y, 1)
	

func _process(_delta):
	check_game_states()
	#set_moves(Global.moves)
	check_moves() # for saving
	

func set_moves(new_moves): # just not to forget this method
	#Global.moves = new_moves # Actually don't needed just for future reference, Are u game dev now Nirmal?
	if $Player.is_moving : # This is only for updating label nothing else
		#Global.level += 1
		#$CanvasLayer/MovesLabel.text = "moves: " + str(Global.moves)
		$Player.is_moving = false # so set it to false here

func check_game_states():
	
	if not game_over:
		var spots = $Spots.get_child_count() # child count returns how many childs in total number 
		for child in $Spots.get_children():# And we get children to access occupied variable
			if child.occupied == true: #if spot is occupied 
				spots -= 1 # total no. - 1 

		if spots == 0: # when there is no child count left that means all spots occupied
			$CanvasLayer/AcceptDialog.popup_centered()
			$Player.set_process_unhandled_input(false)
			game_over = true

func _on_AcceptDialog_confirmed():
	var _err = get_tree().reload_current_scene()

func check_moves():
	pass#if Global.moves > Global.best:
		#Global.best = Global.moves
		#save_bestmoves()


func save_bestmoves():
	var save_data = File.new()
	save_data.open(save_path, File.WRITE)
	save_data.store_var(Global.best)
	save_data.close()


func load_bestmoves():
	var save_data = File.new()
	if save_data.file_exists(save_path):
		save_data.open(save_path, File.READ)
		Global.best = save_data.get_var()
		save_data.close()


