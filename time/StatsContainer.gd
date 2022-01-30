extends HBoxContainer

onready var hplabel = $StastsContainer/HP
onready var aplabel = $StastsContainer/AP
onready var mplabel = $StastsContainer/MP


func _on_Player_stats_hp_changed(hp):#this argument is just reference we can name it as our wish
	hplabel.text = "HP\n"+str(hp)
	  


func _on_Player_stats_ap_changed(ap):
	aplabel.text = "AP\n"+str(ap)


func _on_Player_stats_mp_changed(value):
	mplabel.text = "MP\n"+str(value)

#arguments are variables but can be only used in functions
# in setter rule there must be one argument
