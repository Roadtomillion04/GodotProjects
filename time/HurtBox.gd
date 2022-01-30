extends Area2D

var invincible = false setget set_invincible
onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value): #value is just refrennce we can give any arguement here
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
		
func create_hit_effect():	
	var HurtEffect = load("res://HurtEffectForCharcters.tscn")
	var hurteffect = HurtEffect.instance()#instancing loaded scene via code
	get_parent().add_child(hurteffect)
	hurteffect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false
#we need to use self. when accessing setget outside its own function


func _on_HurtBox_invincibility_started():
	set_deferred("monitoring",false)


func _on_HurtBox_invincibility_ended():
	monitoring = true
