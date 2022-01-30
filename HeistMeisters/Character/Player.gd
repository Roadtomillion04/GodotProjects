extends "res://Character/CharacterTemplate.gd"

var motion = Vector2()
var velocity_multiplier = 1

var disguised = false

export var disguise_slowdown = 0.25
export var disguise_duration = 5
export var number_of_disguises = 3

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const PLAYER_LIGHT = "res://GFX/PNG/Hitman 1/hitman1_stand.png"

const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_157.png"
const BOX_LIGHT = "res://GFX/PNG/Tiles/tile_157.png"

const PLAYER_OCCLUDER = "res://Character/HumanOccluder.tres"
const BOX_OCCLUDER = "res://Character/BoxOccluder.tres"


func _ready():
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)#pass arguments after method
	$Timer.wait_time = disguise_duration # 5 sec
	reveal() #set to reveal mode

func _physics_process(_delta):
	update_movements()
	
	move_and_slide(motion * velocity_multiplier) #anything by 1 itself
	
	if disguised:#We are calculating every frame So put under _process
		$DisguiseTimerLabel.text = str($Timer.time_left).pad_decimals(2) #Now only 2 decimals are shown
		 #Label.text needs to be in str as Timer is float
		$DisguiseTimerLabel.rect_rotation = - rotation_degrees #Now Label.text wont rotate as it subracts from its
			 #own roation and set it to 0
func update_movements():
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED,0,MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED,-MAX_SPEED,0) 
	else:
		motion.y = lerp(motion.y,0,FRICTION) #lerp(linear interpolate) = (from,to,weigh time)
	
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED,0,MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED,-MAX_SPEED,0)
	else:
		motion.x = lerp(motion.x,0,FRICTION)

func _input(_event):
	if Input.is_action_just_pressed("toggle_NightVison_mode"):
		get_tree().call_group("Interface","cycle_vision_mode")# func is called in string method
		#$Torch.enabled = !$Torch.enabled #Become whatever you not,Both will swap everytime pressed, I guess
		#$Torch.enabled != $Torch.enabled are not same because we setting here not equal 
	
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()
	
#	if Input.is_action_just_pressed("kill"):
#		get_tree().paused = true
#		pause_mode = Node.PAUSE_MODE_PROCESS
	
	
func toggle_disguise():
	if disguised:
		reveal()
		
	elif number_of_disguises > 0:
		disguise()
	
#I've connected Timer here directly because any I'm gonna call this again!
func reveal():
	$Sprite.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER) 
	$Light2D.texture = load(PLAYER_LIGHT) #To highlight the player in dark mode
	$DisguiseTimerLabel.hide()
	
	velocity_multiplier = 1 #Usual speed
	
	disguised = false
	collision_layer = 1 #We have to assign by value,Check layer 1 for value 
	
func disguise():	
	$Sprite.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER) #To set correct oocluder in Box mode or it may look wierd in shadows
	$Light2D.texture = load(BOX_LIGHT)
	$DisguiseTimerLabel.show()
	
	velocity_multiplier = disguise_slowdown #To slowdown the speed when disguised
	number_of_disguises -= 1
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)#Calling here will
	#autmatically update the ItemList
	
	disguised = true
	collision_layer = 16 #Check layer 5 for value
	$Timer.start()

# calling groups!
func collect_briefcase(): #it's a Simple inventory system now
	var loot = Node.new()
	loot.set_name("Briefcase") #set_name is Node's property
	add_child(loot)
	get_tree().call_group("Loot", "collect_loot")

func add_disguise():
	number_of_disguises += 1
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)


func collect_knife():
	var object = Node.new()
	object.set_name("Knife")
	add_child(object)
	get_tree().call_group("Loot", "collect_knife")


func _on_pauseMenu_pressed(): #I don't want player to move in freeze mode while pausing
	pause_mode = Node.PAUSE_MODE_INHERIT






