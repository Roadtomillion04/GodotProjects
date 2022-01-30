extends ColorRect

signal player_entered

func _on_Area2D_body_entered(_body):
	emit_signal("player_entered")
	$AudioStreamPlayer.stream = load("res://Blade Frogger Assets/Audio/win.ogg")
	$AudioStreamPlayer.play()
	
