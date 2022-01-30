extends Area2D

const CAR_LIST = ["Grey1", "Grey2", "Yellow1", "Yellow2"]
var car_speed = 250
var direction = 1

#This is a brialliant idea,as we changing direction to -1 (- * - = +)
func _ready():
	randomize()
	var pick_car = CAR_LIST[randi() % CAR_LIST.size()]#Now we pick random car, usind size is more flexible
	$AnimatedSprite.animation = pick_car
	car_speed = rand_range(220, 300)
	
	if position.x < 0:
		direction = -1
		$AnimatedSprite.flip_h = true
	else:
		direction = 1


func _process(delta):#multiply delta in positions to run game consistencly
	position.x -= car_speed * delta * direction


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Car_body_entered(_body):
	get_tree().call_group("Main", "game_over")
