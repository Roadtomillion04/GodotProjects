extends Control

export (String, MULTILINE) var description =''  # multiline string

func _on_Hover_description_mouse_entered():
	var main = get_tree().current_scene
	var textbox = main.find_node("Textbox")
	if textbox != null:
		textbox.text = description


func _on_Hover_description_mouse_exited():
	var main = get_tree().current_scene
	var textbox = main.find_node("Textbox")
	if textbox != null:
		textbox.text = ''
	
