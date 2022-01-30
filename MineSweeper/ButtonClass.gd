extends Control

onready var button = get_node("TextureButton")
onready var label = get_node("Label")

var is_mine = false
var is_mine_candidate = false
var button_pos = Vector2(0, 0)
var disable_left_click = false
var disable_right_click = false


func _ready():
	pass


func _on_TextureButton_pressed():
	if Input.is_action_just_pressed("left click") and not disable_left_click:
		left_click_action()
	if Input.is_action_just_pressed("right click") and not disable_right_click:
		right_click_action()

func left_click_action():
	disable_right_click = true
	if is_mine:
		get_parent().get_parent().show_mines()
		button.modulate = 'd33131'
		
	else:
		var mine_count = get_parent().get_parent().display_mines_around(button_pos, button)
 
		show_count(mine_count)

func show_count(count):
	label.text = str(count)

func right_click_action():
		if not disable_left_click:
			button.modulate = '252d6c'
			disable_left_click = true
		else: # if true
			button.modulate = 'ffffff'
			disable_left_click = false
