extends Control




func _on_Start_button_pressed():
	get_tree().change_scene("res://Node2D.tscn")


func _on_Quit_button_pressed():
	get_tree().quit()
