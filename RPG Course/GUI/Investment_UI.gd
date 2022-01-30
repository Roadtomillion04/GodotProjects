extends Control


func _on_invest_mode():
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = true

func _on_BackButton_pressed():
	get_tree().paused = false
	hide()
