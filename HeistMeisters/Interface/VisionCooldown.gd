extends TextureProgress

export var step_multiplier = 2

func _ready():
	value = max_value
	
	
func _process(_delta):
	#value += step  #To know my Error's
	
	pass#check_value()  #It hurt my eyes!
	
func update_visioncooldown():
	value -= step * step_multiplier 
	
func check_value():
	if value == min_value:
		get_tree().call_group("Interface", "change_to_DARK_mode")
		
	value += step 
