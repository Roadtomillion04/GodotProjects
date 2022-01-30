extends Control

func _ready():
	hide()


func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		show() #I don't want player to move in freeze mode while pausing
		get_tree().call_group("Player", "_on_pauseMenu_pressed")
		get_tree().paused = true


func _on_UnpauseButton_pressed():
	BackgroundMusic.stream = load("res://SFX/Music/StealthintheWoods.ogg")
	BackgroundMusic.play()
	get_tree().paused = false
	hide()



func _on_QuitButton_pressed():
	get_tree().paused = false
	get_tree().quit()


func _on_RestartButton_pressed():
	hide()
	get_tree().paused = false
	get_tree().reload_current_scene()
