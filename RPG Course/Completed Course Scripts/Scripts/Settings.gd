extends Control

export (NodePath) var Resolution_Choice
onready var Resolution = get_node(Resolution_Choice)

var Res_options = ["1920x1080", "1280x720", "640x480"]
onready var Res_Selected = $TabContainer/Display/ResolutionOptions

var cpu_mode: bool = false

func _ready():
	Resolution.add_item("Change Resolution")
	Resolution.set_item_disabled(0, true)
	add_resolutions()

func add_resolutions():
	for item in Res_options:
		Resolution.add_item(item)


func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_SFXVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)


func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_CheckButton_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_ResolutionOptions_item_selected(index):
	if Res_Selected.get_item_text(index) == "1920x1080":
		OS.set_window_size(Vector2(1920,1080))
		OS.set_window_position(Vector2(0, 0))
		
	if Res_Selected.get_item_text(index) == "1280x720":
		OS.set_window_size(Vector2(1280, 720))
		OS.set_window_position(Vector2(0, 0))
	
	if Res_Selected.get_item_text(index) == "640x480":
		OS.set_window_size(Vector2(640, 480))
		OS.set_window_position(Vector2(0, 0))
	
func _on_CPUButton_pressed():
	cpu_mode = not cpu_mode
	OS.set_low_processor_usage_mode(cpu_mode)
	
	
	
	
	
	
	




func _on_Button_pressed():
	self.hide()
