extends KinematicBody2D

var velocity = Vector2.ZERO
var player = null
const speed = 50
var acceleration = 300
var friction = 200
var knockback = Vector2.ZERO

onready var player_detect = $Player_detect
onready var batanimation = $AnimatedSprite
onready var enemysoftcollision = $SoftEnemyCollision
onready var batstats = $StatsForWorldCharacters
onready var hurtbox = $HurtBox
onready var bathplabel =  $BatHpLabel
onready var scorelabel = get_node("../../CanvasLayer/ScoreLabel")

func _ready():
	pass
	
func _process(delta):
	knockback = knockback.move_toward(Vector2.ZERO,friction *delta)
	knockback = move_and_slide(knockback)	
	
enum{
	
	IDLE,
	WANDER,
	CHASE
}
	
var state = CHASE

func _physics_process(delta):#confusing part
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO,friction*delta)
			seek_player()
			
		WANDER:
			pass
		CHASE:
			player = player_detect.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction*speed,acceleration*delta)
			else:
				state = IDLE
			batanimation.flip_h = velocity.x < 0
			
	if enemysoftcollision.is_coliding():
		velocity *= enemysoftcollision.push_vector() *delta *100#higher this value less likely to overlap
	
	velocity = move_and_slide(velocity)
			

func seek_player():
	if player_detect.can_see_player():
		state = CHASE

func _create_death_effect():
	var EnemyDeathEffect = load("res://EnemyDeathEffect.tscn")
	var enemydeatheffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemydeatheffect)
	enemydeatheffect.global_position = global_position


func _on_HurtBox_area_entered(area):
	knockback = area.knockback_vector * 150
	batstats.health -= 1
	bathplabel.displayhp -= 1
	batstats.connect("died",self,"_on_bat_died")
	#from where we are connecting.connect
	if area.name == "BulletHitBox":
		batstats.health -= 1
		bathplabel.displayhp -= 1

func _on_bat_died():
	_create_death_effect()
	scorelabel.score += 1
	queue_free()
	
	


