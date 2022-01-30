extends Area2D

#Son't forget to set mask to player,So only player can interact

func _on_Briefcase_body_entered(body):
	body.collect_briefcase() #Triggers this func() in player's script
	queue_free()
