extends "res://Action_button.gd"


const Slash = preload("res://Slash.tscn")

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null:
		if playerStats.mp >= 5:
			create_slash(enemy.global_position)# creates slash in enemy position
			yield(get_tree().create_timer(0.1),"timeout")
			enemy.take_damage(10)
			playerStats.mp -= 5
			playerStats.ap -= 1
		else:
			playerStats.ap -= 1
			playerStats.mp += 5

func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
	
#create_slash  (position) is an argument which is a var but can be used only in function
# whwn reusing this function we used assign value to arguement
