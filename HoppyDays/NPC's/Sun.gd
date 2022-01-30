extends Node2D

onready var raycast = $Sprite/RayCast2D

var timeout = false

func _process(_delta):#every frame
	if raycast.is_colliding():
		fire()

func fire():
	if not timeout:
		raycast.add_child(load("res://Hazards/Lighting.tscn").instance())
		$Sprite/Timer.start()
		timeout = true
		

#lighting will eject per second
func _on_Timer_timeout():
	timeout = false
