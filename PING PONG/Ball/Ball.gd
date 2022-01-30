extends KinematicBody2D

var speed = 600
var velocity = Vector2()# We determined velocity to use it in multiple func not as like player


func _ready():#First we are setting -1 and 1 in array then we are using randi() to call index 0 or 1, 0 picks -1 and 1 picks 1
	randomize()
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.8, 0.8][randi() % 2]



func _physics_process(delta):# delta is for game consistency
	var collision_object = move_and_collide(velocity * speed * delta) #move_and_collide() doesen't automatically multiplies delta as move_and_slide()!
	if collision_object:#returns true or false
		velocity = velocity.bounce(collision_object.normal)# It's similar to reflection in physics normal divides incident and reflection equally!
		
		$AudioStreamPlayer.play()
		
func stop_ball():
	speed = 0

func start_ball():
	speed = 600
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.8, 0.8][randi() % 2]
