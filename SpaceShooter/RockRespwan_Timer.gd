extends Timer


onready var Enemyrock = preload("res://EnemyRock.tscn")

func _on_Timer_timeout():
	enemyrock_resetter()


func enemyrock_resetter():
	var enemyrock = Enemyrock.instance()
	enemyrock.position = Vector2(1100,rand_range(10,590))
	get_parent().call_deferred("add_child",enemyrock)

