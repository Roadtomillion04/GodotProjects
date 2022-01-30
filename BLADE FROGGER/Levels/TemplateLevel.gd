extends Node

const SAVE_FILE_PATH = "user://save_data.save"
const CAR = preload("res://Cars/Car.tscn")


func _ready():
	load_highscore()
	$CanvasLayer/Label2.text = "best " + str(Global.high_score)
	var a = 1
	print(a)


#First we are creating a arguemrnt
func spawn_cars(start_pos):# Then we use acces node and use get_child(It takes only index)
	var starting_positions = $CarStartPositions.get_child(start_pos)
	var car = CAR.instance()
	car.position = starting_positions.position #Don't forget to change here
	$Cars.add_child(car)
	
	#Don't forget to set start_pos in string as we are adding!
	var timer_node_name = "CarSpawnTimers/SpawnCars" + str(start_pos)#This works as get_child above
	get_node(timer_node_name).wait_time = rand_range(1.4, 2.3) 


func _on_SpawnCars1_timeout(): spawn_cars(0) #call the index here!
func _on_SpawnCars2_timeout(): spawn_cars(1)
func _on_SpawnCars3_timeout(): spawn_cars(2)
func _on_SpawnCars4_timeout(): spawn_cars(3)
func _on_SpawnCars5_timeout(): spawn_cars(4)


func _on_Exit_player_entered():
	Global.score += 1
	$Player.position = $PlayerPosition.position
	$CanvasLayer/Label.text = "Score " + str(Global.score)

func game_over():
	if Global.score > Global.high_score:
		Global.high_score = Global.score
		save_highscore()
	
	
	#var _err = get_tree().change_scene("res://Levels/GameOver.tscn")#Storing a var with _ debuggs warnings!


func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(Global.high_score)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		Global.high_score = save_data.get_var()
		save_data.close()


#func checkpoint_reached():
#	save_position()
#
#
#func save_position():
#	var save_data = File.new()
#	save_data.open(SAVE_FILE_PATH, File.WRITE)
#	save_data.store_var($Player.position)
#	save_data.close()
#	print(save_data)
#
#
#func load_position():
#	var save_data = File.new()
#	if save_data.file_exists(SAVE_FILE_PATH):
#		save_data.open(SAVE_FILE_PATH, File.READ)
#		$Player.position = save_data.get_var()
#		save_data.close()
#



func _process(_delta):
	if Input.is_action_just_pressed("Restart"):
		$Player.position = $Player.store_pos()
