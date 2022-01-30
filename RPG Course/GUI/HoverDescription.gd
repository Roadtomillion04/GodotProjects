extends Node

export (String, MULTILINE) var description = ""



func _on_HoverDescription_mouse_entered():
	var textbox = get_tree().current_scene.get_node("Investment_UI/VBoxContainer/HBoxContainer/TextboxPanel/TextboxLabel")
	if textbox != null:
		textbox.text = description
		print("boo")


func _on_HoverDescription_mouse_exited():
	var textbox = get_tree().current_scene.find_node("Investment_UI/VBoxContainer/HBoxContainer/TextboxPanel/TextboxLabel")
	if textbox != null:
		textbox.text = ""
		print("bla")
