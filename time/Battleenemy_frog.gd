extends "res://Battle_enemy.gd"


func deal_damage():
	rng.randomize()
	damage = rng.randi_range(10,20)
	BattleUnits.PlayerStats.hp -= damage
	
func set_hp(new_hp):
	hp = new_hp
	hp = clamp(new_hp, 0, hp)
	if hpLabel != null:
		hpLabel.text = str(hp) + '/50'
