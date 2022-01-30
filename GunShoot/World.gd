extends Node


onready var Enemy = preload("res://Enemy.tscn")


func _on_Timer_timeout():
	$EnemyPath/EnemySpawmLoaction.offset = randi()
	
	var enemy = Enemy.instance()
	add_child(enemy)
	
	var direction = $EnemyPath/EnemySpawmLoaction.rotation
	
	enemy.position = $EnemyPath/EnemySpawmLoaction.position	
	
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction	 
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
