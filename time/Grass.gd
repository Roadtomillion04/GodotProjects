extends Node2D

func create_grass_death_effect():
	#if Input.is_action_just_pressed("attack"):
		var Grassdeatheffect = load("res://GrassDeathEffect.tscn")
		var grassdeatcheffect = Grassdeatheffect.instance()#instancing loaded scene via code
		get_parent().add_child(grassdeatcheffect)
		grassdeatcheffect.global_position = global_position


func _on_HurtBox_area_entered(_area):
	create_grass_death_effect()
	queue_free()
