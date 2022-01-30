extends Area2D



onready var player = get_node("../Player")
onready var timer = get_node("../PowerUpDurabilty_Timer")

func _physics_process(_delta):
	position += Vector2(-4.5,0)



func _on_Powerups_area_entered(_area):
	timer.start()
	player.upgrade0 = false
	player.upgrade1 = true
	hide()
	if player.set_upgrade2 == true:
		player.upgrade2 = true
	if player.set_upgrade3 == true:
		player.upgrade3 = true

