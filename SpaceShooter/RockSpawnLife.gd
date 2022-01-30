extends Timer

onready var rockrespawntimer = get_node("../RockRespawn_Timer")
onready var spaceshiprespawntimer = get_node("../EnemySpaceship_spawn")
onready var animationplayer = get_node("../AnimationPlayer")
onready var label = get_node("../CanvasLayer/Label")

func _ready():
	start()
	label.hide()

func _on_RockSpawnLife_timeout():
	rockrespawntimer.queue_free()
	print("timeout")
	yield(get_tree().create_timer(4.5),"timeout")
	label.show()
	animationplayer.play("wave")
	spaceshiprespawntimer.start()
