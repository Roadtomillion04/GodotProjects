extends KinematicBody2D

var motion = Vector2.ZERO

const SPEED = 2000  #we not gonna change this value in runtime
const GRAVITY = 150
const UP = Vector2(0,-1)
const JUMPSPEED = 2500
const GAME_LIMIT = 3500
const BOOST_MULTIPLIER = 1.5

signal animate

func _physics_process(delta): #delta is time in sec between frames
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion,UP)#only then fall rate not change anytime

func apply_gravity():
	if position.y > GAME_LIMIT:
		get_tree().call_group("Gamestate","end_game")
		
	if is_on_floor() and motion.y >0:
		motion.y = 0
	elif is_on_ceiling():	#to stop bunny from floating in ceiling
		motion.y = 1 #push down by one pixels
	else:
		motion.y += GRAVITY

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y = -JUMPSPEED
		$JumpSFX.play()
	
func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
		
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
			
	else :
		motion.x = 0

func animate():
	emit_signal("animate",motion)

func hurt():
	position.y -= 1
	yield(get_tree(),"idle_frame")
	motion.y = -JUMPSPEED
	$PainSFX.play()

func boost():
	position.y -= 1
	yield(get_tree(),"idle_frame")
	motion.y = -JUMPSPEED * BOOST_MULTIPLIER

func PlayerChoice1():
	$PlayerAnimation1.show()
	
	

func PlayerChoice2():
	$PlayerAnimation2.show()
	

func _process(_delta):
	PlayerChoice1()
	PlayerChoice2()
