extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export(int) var hp = 25 setget set_hp
export(int) var damage = 0

onready var enemysprite = $Sprite
onready var hpLabel = $Panel/HBoxContainer/HPLabel
onready var animationPlayer = $AnimationPlayer
var rng = RandomNumberGenerator.new()
const ENEMYMOVES = ["deal_damage","heal_hp"]
var pickmove := []


signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	hp = clamp(new_hp, 0, hp)#clamp(max,min,changing value)
	if hpLabel != null:
		hpLabel.text = str(hp) + '/25'


func _ready():
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null

func attack() -> void:
	if self.hp > 0:
		if pickmove.empty():
			yield(get_tree().create_timer(0.4), "timeout")
			pickmove = ENEMYMOVES.duplicate()
			pickmove.shuffle()
		randomize()
		var action = pickmove.pop_front()
		call(action)
		animationPlayer.play("Attack")
		yield(animationPlayer, "animation_finished")
		emit_signal("end_turn")


func deal_damage():
	rng.randomize()
	damage = rng.randi_range(4,10)
	BattleUnits.PlayerStats.hp -= damage


func heal_hp():
	rng.randomize()
	self.hp += rng.randi_range(5,10)


func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		animationPlayer.play("die")
		yield(animationPlayer,"animation_finished")
		queue_free()
	else:
		animationPlayer.play("Shake")

func is_dead():
	return hp <= 0
	
