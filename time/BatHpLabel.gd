extends Label

var displayhp = 10 setget set_hp

func set_hp(new_hp):
	displayhp = new_hp
	if self != null:
		text = str(displayhp)+"/10"
