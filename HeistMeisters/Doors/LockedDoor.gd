extends "res://Doors/Door.gd"

#Tip - on Inheriting scenes save it first and then edit it

func _ready():
	$Label.rect_rotation = -rotation_degrees #so that it changes its roatation automatically if we rotate computer! 


signal reset

func _on_Door_input_event(_viewport, _event, _shape_idx):  #this will overwrite existing script 
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/NumPad.popup_centered()  # Now this does different popups right centre 

func _on_Door_body_exited(body): 
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/NumPad.hide()
		emit_signal("reset")
		PlayerHint.get_node("Control/Label").hide()


func _on_Door_body_entered(body): #Just to make sure no breakpoint Error!
	if body.collision_layer == 1:
		can_click = true
		PlayerHint.get_node("Control/Label").show()
		PlayerHint.get_node("Control/Label").text = "Examine"
		
	#else:
		#open()


func _on_NumPad_combination_correct():
	$AnimationPlayer.play("Door_open")
	$Timer.start()


func _on_Timer_timeout():
	queue_free()

#Don"t Forget to connect signal when new lockedDoor and Computers added!
func _on_Computer_combination(numbers,lock_group): #No matter what name it is only value matters for arguments!
	#if group_no == lock_group:
		$CanvasLayer/NumPad.combination = numbers
		$Label.text = lock_group #It will update automatically by signal as Computer's Inspector value



