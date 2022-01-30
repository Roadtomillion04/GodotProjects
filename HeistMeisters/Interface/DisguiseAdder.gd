extends Area2D



func _on_DisguiseAdder_body_entered(body):
	body.add_disguise()
	queue_free()
