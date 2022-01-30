extends Node2D

#we have created common script that every level can use it!

#single responsibility principle

var lives = 5
var coins = 0
var target_coins_to_get_life = 10

func _ready():
	add_to_group("Gamestate") #groups is a broadcast thing
	update_GUI()

func hurt():
	lives -= 1
	$Player.hurt()
	update_GUI()
	if lives < 0:
		end_game()

func update_GUI():
	get_tree().call_group("GUI", "update_GUI",lives,coins)
	
func coin_up():
	coins += 1
	update_GUI()
	var targetCoins = (coins % target_coins_to_get_life) == 0 #10/10 remainder 0 so every 10 coins we get a life
	if targetCoins:
		life_up()
	
func life_up():
	lives += 1	
	update_GUI()
	
func end_game(): 
	get_tree().change_scene("res://Level/GameOver.tscn")
	
func win_game():
	get_tree().change_scene("res://Level/WinScreen.tscn")
