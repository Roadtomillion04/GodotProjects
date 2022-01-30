extends "res://Action_button.gd"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.mp >= 10:
			playerStats.hp += 5
			playerStats.mp -= 10
			playerStats.ap -= 1
