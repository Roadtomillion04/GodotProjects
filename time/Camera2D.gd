extends Camera2D

onready var player = find_node("../YSort/Player")
onready var topleft = $Limits/TopLeft
onready var bottomright = $Limits/BottomRight

func _ready():
	limit_top = topleft.position.y
	limit_left = topleft.position.x
	limit_right = bottomright.position.x
	limit_bottom = bottomright.position.y
	


#func  _process(delta):
	#position.x = player.position.x
	#position.y = player.position.y
