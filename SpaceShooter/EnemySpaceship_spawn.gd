extends Timer



onready var Enemyspaceshp= preload("res://EnemySpaceShip2.tscn")

func _ready():
	self.stop()

func enemyrock_resetter():
	var enemyspaceship = Enemyspaceshp.instance()
	enemyspaceship.position = Vector2(1100,rand_range(10,590))
	get_parent().call_deferred("add_child",enemyspaceship)


func _on_EnemySpaceship_spawn_timeout():
	enemyrock_resetter()
