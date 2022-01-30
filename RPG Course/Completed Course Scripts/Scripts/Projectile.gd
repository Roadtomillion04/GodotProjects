extends Node2D


var motion = Vector2(0, 0)
var speed = 200
onready var player = get_tree().current_scene.get_node("Player")
var target = Vector2()


func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target = get_global_mouse_position()
		return_to_player()
	
	#translate(motion * delta)

func return_to_player():
	motion = position.direction_to(target.position) * speed
	

func _on_Timer_timeout():
	return_to_player()
	


func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		pass
	if body.is_in_group("Enemy"):
		var calc = ((PlayerStats.Stats.MagicAttack - BatStats.MagicDefense) + 5 ) * 2
		if calc > 0:
			body.hurt(calc)
			queue_free()
		else:
			body.hurt(1)
			queue_free()
	else:
		queue_free()	
