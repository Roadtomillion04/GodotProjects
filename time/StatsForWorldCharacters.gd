extends Node

export var max_health = 0
onready var health = max_health setget set_health

signal died
signal health_changed(new_health)

func set_health(new_health):
	health = new_health
	emit_signal("health_changed",health)
	if health <= 0:
		emit_signal("died")	
