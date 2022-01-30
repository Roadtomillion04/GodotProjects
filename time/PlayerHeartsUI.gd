extends Control

onready var hplabel = $HpLabel
onready var uireset = preload("res://UIreset.tres")
onready var heartstohealplayer = get_node("../../HeartsToHealPlayer")

var hearts = 5 setget set_hearts
var max_hearts = hearts

func set_hearts(new_hearts):#setter must have one arguement
	hearts = clamp(new_hearts,0,hearts)
	if hplabel !=null:
		hplabel.text =str(hearts)+"/5"
	
	
func _ready():
	self.hearts = StatsForWorldPlayer.health#we need to use self. when accessing setget outside its own function
	StatsForWorldPlayer.connect("health_changed",self,"set_hearts")
	heartstohealplayer.connect("heart_collected",self,"_on_heart_collected")

	
func _on_heart_collected():
	hearts += 1
	StatsForWorldPlayer.set_health(hearts)
	if hplabel !=null:
		hplabel.text =str(hearts)+"/5"

