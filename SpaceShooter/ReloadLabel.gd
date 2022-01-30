extends Label

var max_bulets = 10
var bullets = max_bulets setget set_bullets

onready var player = get_node("../../Player")
signal reload

func set_bullets(new):
	bullets = clamp(new,0,max_bulets)
	if self != null:
		text = str(bullets) + "/10"
	if bullets <= 0:
		emit_signal("reload")

func _ready():
	player.connect("updatelabel",self,"set_bullets")
