extends Area2D

onready var player = get_node("../Player")
onready var timer = get_node("../PowerUpDurabilty_Timer")

func _physics_process(_delta):
	position += Vector2(-4.5,0)



	



func _on_SplitPowerup_area_entered(_area):
	timer.start()
	player.setfiresplit = true
	hide()
