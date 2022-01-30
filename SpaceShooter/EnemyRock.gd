extends StaticBody2D

export(Array,Texture) var RockTypes = []

onready var Explosion = preload("res://Explosion.tscn")
onready var scorelabel = get_node("../CanvasLayer/ScoreLabel")


func _ready():
	randomize()
	RockTypes.shuffle()
	var rocktypes = RockTypes.front()
	$Sprite.texture = rocktypes


func _physics_process(_delta):
	randomize()
	position += Vector2(-4.5,0)
		

func _create_explosive_effect():
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	queue_free()


func _on_EnemyRockCollision_area_entered(area):
	if area.name == "ProjectileCollision":
		pass
	else:
		queue_free()
