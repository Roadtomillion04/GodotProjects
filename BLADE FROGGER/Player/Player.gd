extends KinematicBody2D

var save_pos : Array

const speed = 200

func _process(_delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("left"):
		velocity.x -= 1 # or we cold do velocity.x = -speed
	if Input.is_action_pressed("right"):# use elif's for non-diagonal movement(4-way)
		velocity.x += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	
	
	#This is correct way to multiply normalized
	var _mve = move_and_slide(velocity.normalized() * speed)#Both are same
	#Storing a var with _ debuggs warnings!
	
	$PlayerAnimation.player_animation(velocity)

func _input(event):
	if event.is_action_pressed("save_pos"):
		store_pos()
		print("pos saved")

func store_pos():
	save_pos.append(position)
	position = save_pos.pop_back()
	return position
