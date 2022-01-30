extends Button

export(Array,PackedScene) var randomlvl = []


func _on_RandomLevelGenerator_pressed():
	randomize()
	randomlvl.shuffle()
	var Randomlvl = randomlvl.front()
	get_tree().change_scene_to(Randomlvl)
