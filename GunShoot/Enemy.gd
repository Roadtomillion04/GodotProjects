extends RigidBody2D

var motion = Vector2()
export var min_speed = 150
export var max_speed = 250

func _on_Area2D_body_entered(body):
	if body.name == "Bullet":
		queue_free()
		
		
func _physics_process(delta):
	var player = get_parent().get_node("Player")
	position += (player.position - global_position)/100 #higher this value less in speed
	look_at(player.position)
	
	#motion = move_and_slide(motion)#dont multiply anything here





func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("died")
