extends "res://Action_button.gd"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	var enemy = BattleUnits.Enemy
	if playerStats.mp >= 15:
		playerStats.ap -= 2
		playerStats.mp -= 15
		playerStats.hp -= 0
