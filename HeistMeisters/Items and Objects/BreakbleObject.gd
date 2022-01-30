extends Area2D

var can_break = false
var can_spawn_item = false

onready var item_scene = preload("res://Interface/DisguiseAdder.tscn")

func _ready():
	randomize()
	set_item_spawn_rate() # Don't Forget to call in _ready() as it needs to be execute first to set true or false


func _process(_delta): #As input is an in-game calling event Always set it in _process() !
	if can_break and Input.is_action_just_pressed("kill"): 
		queue_free()  
		spawn_item()

func _on_BreakbleObject_body_entered(body):
	if body.has_node("Knife"): #Checks player having Knife node as child 
		can_break = true
		PlayerHint.get_node("Control/Label").show()
		PlayerHint.get_node("Control/Label").text = "Q"	


func _on_BreakbleObject_body_exited(_body):
	can_break = false
	PlayerHint.get_node("Control/Label").hide()


func spawn_item():
	if can_spawn_item:
		var item = item_scene.instance()
		get_parent().add_child(item)
		item.global_position = global_position
		can_spawn_item = false

func set_item_spawn_rate():
	if randi() % 4 == 0: # Now only 25% crates can provide items
		can_spawn_item = true


