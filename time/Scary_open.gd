extends Area2D
onready var animationPlayer =  $"../AnimationPlayer"



func _on_Scary_open_body_entered(body):
	if body.name == "Player":
		animationPlayer.play("Open")
# :o
