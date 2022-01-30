extends Node2D

const SPEED = 800

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position

func _process(delta):
	position.y += SPEED * delta #Remember:we should mutliply things with delta when move and slide not used! or it not work
	on_colloiding()

func on_colloiding():
	var colloider = $Area2D.get_overlapping_bodies() #inteact with bodies tileset is also a static body we created in platforms
	for object in colloider:
		if object.name == "Player":
			get_tree().call_group("Gamestate","hurt") #if u use else object gonna be keep colliding with player forever
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
