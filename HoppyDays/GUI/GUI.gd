extends CanvasLayer

onready var lifecount = $Control/TextureRect/HBoxContainer/LifeCount
onready var coincount = $Control/TextureRect/HBoxContainer/CoinCount

func _ready():
	lifecount.text = "3"
	coincount.text = "0"

func update_GUI(lives,coins):
	lifecount.text = str(lives)
	coincount.text = str(coins)
