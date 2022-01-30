extends Area2D

var occupied = false

func _on_Goal_body_entered(body):
	if body.is_in_group("Box"):
		occupied = true


func _on_Goal_body_exited(_body): # Or once occupied with one Box player can cheat the sytem!
	occupied = false
