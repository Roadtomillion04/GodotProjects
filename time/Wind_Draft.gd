extends Area2D


func _on_Wind_Draft_body_entered(body):
	if body.name =="Player":
		   get_node("../../Player").Wind_draft = true


func _on_Wind_Draft_body_exited(body):
	if body.name =="Player":
		   get_node("../../Player").Wind_draft = false
