extends Timer

export (Array,PackedScene) var Pickpowerups = []

onready var Powerups = preload("res://Powerups.tscn")

func _ready():
	randomize()
	

func respwan_powerups():
	Pickpowerups.shuffle()
	var pickpowerup = Pickpowerups.front()
	var powerups = pickpowerup.instance()
	powerups.position = Vector2(1100,rand_range(30,500))
	get_parent().call_deferred("add_child",powerups)


func _on_PowerUpRespawn_Timer_timeout():
	respwan_powerups()
