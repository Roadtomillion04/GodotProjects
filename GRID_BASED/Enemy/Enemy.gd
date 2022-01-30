extends KinematicBody2D

onready var raycast = $RayCast2D # we can't collide with collision shapes as it is grid based movement, so we implemented ray cast to check is_colliding() with walls

var grid_size = 16 #Depends upon Sprite size

var inputs: Dictionary = {
	
	0: Vector2.UP, # it is inbuilt in godot so moves up by 1 pixel maybe
	1: Vector2.DOWN, 
	2: Vector2.RIGHT, 
	3: Vector2.LEFT 
	
}

func _ready():
	randomize()


func move(direction):
	var vector_pos = direction * grid_size 
	raycast.cast_to = vector_pos
	raycast.force_raycast_update() 
	
	if not raycast.is_colliding():
		position += vector_pos

	else:
		var collider = raycast.get_collider()
		if collider.is_in_group("Player"):
			get_tree().quit()


func _on_PathTimer_timeout():
	var pick_direction
	pick_direction = inputs[randi() % inputs.size()]
	move(pick_direction)
	print(pick_direction)
