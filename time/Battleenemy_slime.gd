extends "res://Battle_enemy.gd"


func set_hp(new_hp):
	hp = new_hp
	hp = clamp(new_hp, 0, hp)
	if hpLabel != null:
		hpLabel.text = str(hp) + '/35'
