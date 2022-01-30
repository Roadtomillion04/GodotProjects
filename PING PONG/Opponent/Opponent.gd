extends KinematicBody2D

var speed = 400
var ball

func _ready():
	ball = get_node("../Ball")

func _physics_process(delta):
	
	move_and_slide(Vector2(0, get_ball_direction()) * speed)

func get_ball_direction(): #Increase the value of 25 does make AI looks lazy, Try playing with values
	if abs(ball.position.y - position.y) > 25:# When 25 pixels greater do this stuff I guess
		if ball.position.y > position.y: return 1
		else: return -1
	
	else: return 0
