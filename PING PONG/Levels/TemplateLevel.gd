extends Node

var player_score = 0
var opponent_score = 0

func _ready():
	$StartLabel.hide()

func _process(delta):
	$PlayerScore.text = str(player_score)
	$OpponentScore.text = str(opponent_score)


func _on_VisibilityNotifier2D_screen_exited():
	score_achieved()


func _on_CountDownTimer_timeout():
	$StartLabel.hide()
	get_tree().call_group("Ball", "start_ball")
	$Player.set_physics_process(true)


func score_achieved():
	
	if $Ball.position.x < 0:
		opponent_score += 1
	elif $Ball.position.x > 0:
		player_score += 1
	
	$AudioStreamPlayer.stream = load("res://Assets/ping_pong_8bit_plop.ogg")
	$AudioStreamPlayer.play()
	
	$Ball.position = Vector2(512, 300)
	$CountDownTimer.start()
	
	$StartLabel.show()
	
	get_tree().call_group("Ball", "stop_ball")

	$Player.position.x = 35
	$Player.position.y = 300
	$Opponent.position.x = 1024 - 35
	$Opponent.position.y = 300
	
	$Player.set_physics_process(false)
