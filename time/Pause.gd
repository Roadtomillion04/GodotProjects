extends CanvasLayer
#Pause_button

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("Pause"):
		get_tree().paused = !get_tree().paused


