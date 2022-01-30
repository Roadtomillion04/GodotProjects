extends Node

export var max_health = 5


onready var health = max_health setget set_health
onready var Explosion = preload("res://Explosion.tscn")
onready var Enemyrock = get_parent()

#signal died
signal health_changed(new_health)

func set_health(new_health):
	health = new_health
	emit_signal("health_changed",health)
	if health <= 0:
		_create_explosive_effect()

func _create_explosive_effect():
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = Enemyrock.global_position
	queue_free()
