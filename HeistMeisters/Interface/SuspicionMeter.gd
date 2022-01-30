extends TextureProgress

export var step_multiplier = 2

func _ready():
	value = 0

func _process(_delta): # we are subing value everyframe
	value -= step 

func player_seen(): #We have used only properties No variables
	value += step * step_multiplier
	
	if value == max_value:
		end_game()

func end_game():
	pass
