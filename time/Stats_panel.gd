extends Panel


onready var hplabel = $StatsContainer/HP
onready var aplabel = $StatsContainer/AP
onready var mplabel = $StatsContainer/MP


func _on_Player_stats_hp_changed(value):
	hplabel.text = "HP\n"+str(value) + '/25'
	  


func _on_Player_stats_ap_changed(value):
	aplabel.text = "AP\n"+str(value)


func _on_Player_stats_mp_changed(value):
	mplabel.text = "MP\n"+ str(value) + '/50'
