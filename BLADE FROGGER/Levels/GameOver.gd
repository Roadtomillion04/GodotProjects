extends Control


func _process(_delta):
	$CenterContainer/VBoxContainer/ScoreLabel.text = "Score " + str(Global.score)
	
	if Input.is_action_just_pressed("Restart"):
		Global.score = 0
		var _chnge = get_tree().change_scene("res://Levels/TemplateLevel.tscn")
		#Storing a var with _ debuggs warnings!

	$CenterContainer/VBoxContainer/HighScoreLabel.text = "High Score " + str(Global.high_score)



