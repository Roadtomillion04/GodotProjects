extends Area2D

onready var scorelabel = get_tree().current_scene

	


func _on_ScoreDetect_body_entered(body):
	if body.name == "FlappyBird":
		scorelabel.score += 1
