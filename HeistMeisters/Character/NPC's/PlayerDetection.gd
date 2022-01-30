extends "res://Character/CharacterTemplate.gd"

#Fov - field of view
const FOV_TOLERANCE = 19 #we divide the total light Y axis texture of 400, 20 by 20
const PLAYER_DETECTION_LIMIT = 640 #640 pixels x-wide check in Light Texture

const RED = Color(1,0.25,0.25)
const WHITE = Color(1,1,1)

var Player

func _ready():							#nodename,usually true,Child of this node - so false
	Player = get_node("/root").find_node("Player",true,false) #/root is a hidden top scene

func _process(_delta):
	if Player_in_FOV() and Player_in_LOS() :
		$Torch.color = RED
		get_tree().call_group("SuspicionMeter", "player_seen")
	else:
		$Torch.color = WHITE
		
	
func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	#abs will be true for + and -
	# angle to - Returns the angle to the given vector, in radians.
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE): #converts degree in radians
		return true
	else:
		return false

func Player_in_LOS(): #LOS - line of sight
	var space = get_world_2d().direct_space_state #getworld2d gets the enire 2d render and directSpacestate takes only physics influence engine
	var LOS_obstacle = space.intersect_ray(global_position,Player.global_position,[self],collision_mask)
											 #From           #To                #exclude  checks our set uped collosions
										   
	if not LOS_obstacle: #its just error checking if game messed up with no collisons
		return false
																  #self
	var distance_to_player = Player.global_position.distance_to(global_position)
	 #distance_to returns distance between postion and to(path)
	var Player_in_Range = distance_to_player <  PLAYER_DETECTION_LIMIT	
	
	if LOS_obstacle.collider == Player and Player_in_Range: # we are now checking only player colliding body
		return true
	else: #like tilemaps so player can hide behind walls!
		return false
	


