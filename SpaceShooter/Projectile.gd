extends RigidBody2D


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_ProjectileCollision_area_entered(_area):
	queue_free()