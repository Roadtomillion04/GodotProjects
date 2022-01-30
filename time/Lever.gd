extends Node2D

export var state = "0"

func _ready():
	if state == "0":
		$Sprite.flip_v = false
	else :
		$Sprite.flip_v = true

func _process(_delta):
	if $Area2D.overlaps_body($"../../../Player") and Input.is_action_just_pressed("use"):
		if state == "0":
			state = "1"
		else :
			state = "0"
		LeverandGates.LeverChanged()
		
	 
	
	if state == "0":
		$Sprite.flip_v = false
	else :
		$Sprite.flip_v = true	

