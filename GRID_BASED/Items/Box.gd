extends KinematicBody2D

onready var raycast = $RayCast2D # we can't collide with collision shapes as it is grid based movement, so we implemented ray cast to check is_colliding() with walls
onready var player = get_tree().current_scene.get_node("Player")

var grid_size = 16 #Depends upon Sprite size
var store_pos: Array = []
var inputs: Dictionary = {
	
	"up": Vector2.UP, # it is inbuilt in godot so moves up by 1 pixel maybe
	"down": Vector2.DOWN, 
	"right": Vector2.RIGHT, 
	"left": Vector2.LEFT 
	
}

# Excatly same script as player
func move(direction):
	var vector_pos = inputs[direction] * grid_size # I think as we move that direction it will move again
	raycast.cast_to = vector_pos
	raycast.force_raycast_update() # change this is too as we don't want our box to go over walls! 
	if not raycast.is_colliding():
		store_pos.append(position)
		position += vector_pos
		return true # This true or false is used to check in player script
	else:
		return false

func _input(event):
	if event.is_action_pressed(" undo"):
		if store_pos.size() > 0:
			position = store_pos.pop_back()

