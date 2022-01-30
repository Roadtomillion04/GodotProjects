extends RigidBody2D


func _physics_process(delta):
	if Input.is_action_pressed("Tap"):
		var BLOCK = load("res://Player/PlayerBody.tscn")
		var block = BLOCK.instance()
		block.position = $Position2D.position
		add_child(block)
		position.y -= 320 * delta
		$Position2D.position.y += 32


func fall():
	if not is_in_group("Obstacles") and not $RayCast2D.is_colliding():
		position.y += 32
		$Position2D.position.y -= 32
