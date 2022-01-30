extends "res://Action_button.gd"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.ap == 3:
			playerStats.mp = playerStats.max_mp
			playerStats.ap -= 3
