extends KinematicBody2D

onready var raycast = $RayCast2D # we can't collide with collision shapes as it is grid based movement, so we implemented ray cast to check is_colliding()

var grid_size = 16 #Depends upon Sprite size
var is_moving = false # Only used for updating label


var store_pos:Array = []
var inputs: Dictionary = { #First we are setting all our inputs in dictionary
	
	"up": Vector2.UP, # it is inbuilt in godot so moves up by 1 pixel maybe
	"down": Vector2.DOWN, #down
	"right": Vector2.RIGHT, #right
	"left": Vector2.LEFT # left
	
}

func _unhandled_input(event): 
	for direction in inputs: # for every keys in dictionary
		if event.is_action_pressed(direction): # when button press matches a key in dicitionary 
			if not $Tween.is_active():
				move(direction) # move don't forget to pass value of key to specify which vector2 direction

func move(direction):
	var vector_pos = inputs[direction] * grid_size 
	raycast.cast_to = vector_pos # we update the cast_to as our movement direction
	raycast.force_raycast_update() # just to make sure updating properly
	
	$Tween.interpolate_property( # remeber to set position + vector_pos ad final value, or it will take you to origin!
		self, "position", position, position + vector_pos, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	
	if not raycast.is_colliding(): # if not cast_to cilliding move
		store_pos.append(position) #put it above here it will store added position down below!
		position += vector_pos # current position + specific direction depends upon our button press * grid size or it will move by 1 pixel!
		$Tween.start() # we dom't want tween effect with walls!
		is_moving = true # we don't want moves +1 with walls

		
	else :
		var check_box = raycast.get_collider() # gets ray cast colliding object
		if check_box.is_in_group("Box"):
			if check_box.move(direction): # Same as == true as we are returnig true or false there!
				store_pos.append(position)
				position += vector_pos # again we can move 
				$Tween.start() # we dom't want tween effect with walls!
				is_moving = true # we don't want moves +1 with walls


func _input(event):
	if event.is_action_pressed("undo"):
		if store_pos.size() > 0:
			var pos = position #saving before modified for tweening
			position = store_pos.pop_back()
			$Tween.interpolate_property(self, "position", pos, position, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			$Tween.start()


