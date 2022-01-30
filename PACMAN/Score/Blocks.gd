extends Area2D



func _on_Blocks_body_entered(_body):
	queue_free()
