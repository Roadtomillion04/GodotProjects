extends Node

const BattleUnits = preload("res://BattleUnits.tres")
onready var textboxpanel = $UI/Textbox_panel
onready var text = $UI/Textbox_panel/Textbox

export(Array, PackedScene) var enemies = []

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition
onready var container= $UI/BattleContainer


func _ready():
	randomize()# it randomizes seed dont forget it
	create_new_enemy()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	nextRoomButton.hide()
	battleActionButtons.hide()
	if enemy != null:
		enemy.connect("died", self, "_on_Enemy_died")
	if playerStats != null:
		playerStats.connect("game_over",self,"_on_player_died")
		#connect(       emited signal , target , to func path        )

func start_enemy_turn():
	battleActionButtons.hide()
	textboxpanel.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()		
		yield(enemy, "end_turn")
		#yield waits for animation to complete before satrting next
	start_player_turn()

func start_player_turn():
	container.show()
	battleActionButtons.hide()
	textboxpanel.show()
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		battleActionButtons.hide()
		playerStats.ap = playerStats.max_ap
		yield(playerStats, "end_turn")
		start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()#shuffles array
	var Enemy = enemies.front()#picks first shuufled array
	var enemy = Enemy.instance()#instances shuffles enemy scene via script
	enemyPosition.add_child(enemy)#adds child to position2d 
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
		nextRoomButton.show()
		container.hide()
		battleActionButtons.hide()
		text.text = '        You win'
		
func _on_enemy_dead():
	container.hide()
	battleActionButtons.hide()
	
func _on_player_died():
	battleActionButtons.hide()
	text.text = '    game over'

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("Fade effect")
	yield(animationPlayer, "animation_finished")
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	container.show()
	battleActionButtons.hide()
	create_new_enemy()

func _on_SkillsButton_pressed():
	container.hide()
	battleActionButtons.show()




func _on_Run_button_pressed():
	 queue_free()
