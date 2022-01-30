extends Node2D

var can_click = false

var combination
export var combination_length = 4 # To update difficulty for different lockdoors
export var lock_group = "unset"   # To inform Player which computer connects which lockedDoor!

signal combination

func _ready():
	generate_combination() # Here we canno't call groups or generate combination() in LockDoors
	emit_signal("combination",combination,lock_group)
	$Label.rect_rotation = -rotation_degrees #so that it changes its roatation automatically if we rotate computer! 
	$Label.text = lock_group # we've set lock group = 1 in Inspector, 
	#For next lock door we can update it in Inspector
	
	
func generate_combination(): #Dont forget to call in _ready() This needs to be executed when game starts
	combination = CombinationGenerator.generate_combination(combination_length) #as it is singleton 
  #we can access it in any script!
	set_popup_text()

func set_popup_text():
	$CanvasLayer/ComputerPopup.set_text(combination)


func _on_Area2D_body_entered(_body):
	can_click = true
	$Light2D.enabled = true
	PlayerHint.get_node("Control/Label").show()
	PlayerHint.get_node("Control/Label").text = "Examine"

func _on_Area2D_body_exited(_body):
	can_click = false
	$CanvasLayer/ComputerPopup.hide()
	$Light2D.enabled = false
	PlayerHint.get_node("Control/Label").hide()



func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()










