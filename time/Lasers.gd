extends Area2D
	
func laseron():
	$Timer.start()

func _on_Timer_timeout():
	$lasern.visible = false

func _on_Timer_ready():
	$lasern.visible = true
	

