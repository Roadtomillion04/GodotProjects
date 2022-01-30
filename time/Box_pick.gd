extends RigidBody2D

var picked = false

func _physics_process(delta):
	if picked==true:
		self.position = get_node("../Player/Position2D").global_position
		sleeping=true
	else:
		sleeping=false


func _input(event):
	if Input.is_action_just_pressed("use"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and picked == false:
				picked = true
	elif Input.is_action_just_pressed("R") and picked==true:
		picked = false
				
		

