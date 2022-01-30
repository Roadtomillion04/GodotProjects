extends Control


var selected = false

func _ready():
	pass

func _physics_process(_delta):
	_on_Choice1_pressed()
	_on_Choice2_pressed()
	
	
func _on_Choice1_pressed():
	if not selected:
		get_tree().call_group("PlayerChoice","PlayerChoice1")
		selected = true

func _on_Choice2_pressed():
	if not selected:
		get_tree().call_group("PlayerChoice","PlayerChoice2")
		selected = true


func _on_Button_pressed():
	if selected:
		get_tree().change_scene("res://Level/Level.tscn")
		hide()
