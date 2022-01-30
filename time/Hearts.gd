extends Area2D

signal heart_collected

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()#we can use body_entered signals too but avoiding coupling is better
	for body in bodies:
		if body.name == "Player":
			emit_signal("heart_collected")
			queue_free()
			
	
