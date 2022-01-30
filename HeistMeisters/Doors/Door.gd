extends Area2D

#I used Audiostreamplayer2D because we dont want hear door sound anywhere,Now its sounds near=high ,far=less 

var can_click

func _ready():
	can_click = false


func _on_Door_body_entered(body):
	if body.collision_layer == 1:
		can_click = true
		PlayerHint.get_node("Control/Label").show()
		PlayerHint.get_node("Control/Label").text = "Open"
		
	else:
		open()

func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		PlayerHint.get_node("Control/Label").hide()


func _on_Door_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		open() 

func open():
	$AnimationPlayer.play("Door_movement")
