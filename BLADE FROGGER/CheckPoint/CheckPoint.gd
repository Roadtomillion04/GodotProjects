extends Area2D



func _on_CheckPoint_body_entered(_body):
	get_tree().call_group("Main", "checkpoint_reached")
