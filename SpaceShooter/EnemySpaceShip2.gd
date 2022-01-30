extends Area2D

var firerate:float = 0.5
var bulletspeed:int = 1250
var velocity = Vector2.ZERO

onready var target = get_node("../Player")
onready var Explosion = preload("res://Explosion.tscn")
onready var shootimer = $ShootTimer
onready var Bullet = preload("res://EnemyBullets.tscn")

func _ready():
	set_physics_process(true)


func _physics_process(_delta):
	position += Vector2(-1.5,0)
		
func _process(_delta):
	pass
	

func shoot1():
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	var dir = (get_node("../Player").global_position - global_position).normalized()
	bullet.direction = dir

func _create_explosive_effect():
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	queue_free()




func _on_ShootTimer_timeout():
	shoot1()
