extends KinematicBody2D

func _process(_delta):
	if $RayCast2D.is_colliding():
		get_tree().call_group("PlayerHead", "fall")
		queue_free()
