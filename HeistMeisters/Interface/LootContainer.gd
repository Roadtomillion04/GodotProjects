extends NinePatchRect

# We could add directly for one item in ItemList
#If used correctly we can use ItemList as Simple Inventry display System!

func _ready():
	hide()

func collect_loot():
	show()
	$VBoxContainer/ItemList.icon_scale = 0.35
	$VBoxContainer/ItemList.add_icon_item(load("res://GFX/Loot/suitcase.png"), false)#Selectable = false

func collect_knife():
	show()
	$VBoxContainer/ItemList.icon_scale = 1
	$VBoxContainer/ItemList.add_icon_item(load("res://GFX/PNG/Tiles/Knife.png"), false)#Selectable = false
