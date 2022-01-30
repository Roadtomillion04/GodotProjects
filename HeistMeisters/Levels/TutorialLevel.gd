extends Node2D

#Don't forget to set area2D collision layer off or it triggers itself causing strange tweens

func _ready():
	#yield(get_tree(),"idle_frame") #yield waits now for 1 frame and then starts tween!
	update_objective_pointer_positions(0) #Like arrays get_child idx starts with 0


func update_objective_pointer_positions(objective_number):
	var pointer = $ObjectivePointer #get_child can be used as arrays
	var place = $ObjectivePositions.get_child(objective_number) # get_child takes index arguements!
	var objective_messages = $ObjectiveMessages.get_child(objective_number)# Make use existing objective_no!
	
	# Remember Tween is used only when we don't know the start and end value
	$Tween.interpolate_property(pointer, "position", pointer.position,  #object, "property", From
	place.position, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT) #To, duration, effect you choose, effect)
	$Tween.start()
	
	$TutorialGUI/Control/NinePatchRect/Label.text = objective_messages.text #look at template message script
	$TutorialGUI/AnimationPlayer.play("message_change")
	
	$AudioStreamPlayer.play()
	
func _on_DoorObjective_body_entered(_body): 
	#Make sure to set position2D correctly with respect to ObjectiveMarkers!
	update_objective_pointer_positions(1)
	$ObjectiveMarkers/DoorObjective.queue_free()
	
	# I'm doing queue_free to avoid repetation of poping messages and objective position if player goes back!
func _on_NightVisionObjective_body_entered(_body):
	get_tree().call_group("Interface", "NIGHTVISION_mode")
	update_objective_pointer_positions(2)
	$ObjectiveMarkers/NightVisionObjective.queue_free()

func _on_BriefcaseObjective_body_entered(_body):
	update_objective_pointer_positions(3)
	$ObjectiveMarkers/BriefcaseObjective.queue_free()

func _on_LockedDoorObjective_body_entered(_body):
	update_objective_pointer_positions(4)
	$ObjectiveMarkers/LockedDoorObjective.queue_free()

func _on_ComputerObjective_body_entered(_body):
	update_objective_pointer_positions(5)
	$ObjectiveMarkers/ComputerObjective.queue_free()
	
	
	
	
