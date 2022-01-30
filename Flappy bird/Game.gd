extends Node2D


onready var scorelabel = $CanvasLayer/ScoreLabel
onready var label = $CanvasLayer/Label
onready var player = $FlappyBird

var SAVE_FILE_PATH = "user://savedata.save"

var score = 0 setget set_score
var highscore = 0

func _ready():
	#$AnimationPlayer.play("CountDown")
	#$FlappyBird.gravity = 0
	#$FlappyBird.jump_force = 0
	#yield(get_tree().create_timer(4),"timeout")
	label.hide()
	$FlappyBird.gravity = 4
	$FlappyBird.jump_force = 136
	load_highscore()
	$CanvasLayer/HighscoreLabel.text = "Best: " + str(highscore)
		
func set_score(new_score):
	score = new_score #this is setter rule
	scorelabel.text = "score " + str(score)


func game_over():
	if score > highscore:
		highscore = score
		save_highscore()
	$Walls.call_deferred("_physics_process", false)
	yield(get_tree().create_timer(2),"timeout")
	scorelabel.set_position(Vector2(160,80))
	
	
		
func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH,File.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH,File.READ)
		highscore = save_data.get_var()
		save_data.close()
	


func _on_FlappyBird_died():
	game_over()
