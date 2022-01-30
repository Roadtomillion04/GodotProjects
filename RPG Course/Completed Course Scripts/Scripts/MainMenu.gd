extends Control

onready var settings_menu = $Settings


func _on_Quit_pressed():
	$Accept.play()
	get_tree().quit()


func _on_Options_pressed():
	$Accept.play()
	settings_menu.visible = true


func _on_Play_pressed():
	$Accept.play()
	get_tree().change_scene("res://Scenes/World.tscn")
