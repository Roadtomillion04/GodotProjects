extends "res://Character/NPC's/PlayerDetection.gd"

#Remember the torch should places be outside of lightOcculder or it wont work!

onready var navigation = get_tree().get_root().find_node("Navigation2D",true,false)
onready var desitinations = navigation.get_node("Destinations")

var motion = Vector2()
var possible_destinations
var path 

export var min_distance_to_destination = 1 #1 pixel
export var walk_speed = 0.5 #To give player feel faster

func _ready():
	randomize()
	possible_destinations = desitinations.get_children()
	make_path()

func _physics_process(_delta):
	navigate() # No need to put move_and_slide here,as move() comes under navigate()  comes under _process()
	
func navigate(): #distance_to returns distance between postion and to(path)
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > min_distance_to_destination:
		move()
	
	else:  # on 1 pixel gap do update_path()
		update_path()	
		
func move():
	look_at(path[0])
	motion = (path[0] - position).normalized() * (MAX_SPEED *walk_speed)#normalized - TO prevent moving faster diagonally
	
	if is_on_wall():
		path.remove(0)
		make_path()
		
	
	move_and_slide(motion)		

func update_path():
	if path.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	
	else: # This is very imp step, Now we are removing existing path and when timeout triggers we make_path()
		path.remove(0)
	
func make_path():	# Now new destination gives only one postion2D from list
	var new_destination = possible_destinations[randi() % possible_destinations.size() -1]#array starts from 0
	path = navigation.get_simple_path(position, new_destination.position, false)# SO it creates only one value Array
									  #From      #to                       #setting false to avoid stuck

func _on_Timer_timeout(): #Gaurd waits 3 sec
	make_path()


func _on_Area2D_body_entered(body):
	if body.collision_layer == 1:
		if body.has_node("Knife"):
			queue_free()
