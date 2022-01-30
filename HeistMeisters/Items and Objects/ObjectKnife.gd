extends Area2D



func _on_ObjectKnife_body_entered(body):
	body.collect_knife()
	queue_free()
