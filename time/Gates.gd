extends Node2D

export var code = "0"
var codeFromlevers = ""
var levers = []


func _ready():
	levers = get_node("Levers").get_children()
	LeverandGates.connect("LeverChanged",self,"CheckCode")
	
	
func CheckCode():
	var codeFromLevers = ""
	for lever in levers:
		codeFromLevers += lever.state
		
	if code ==	codeFromLevers:
		$"StaticBody2D/CollisionShape2D".disabled = true
		$"Sprite2".visible = false
	else:
		$"StaticBody2D/CollisionShape2D".disabled = false		
		$"Sprite2".visible = true
	
	

