extends ItemList

#Tip - we can also use Item list for hearts(life) 

func update_disguises(disguises_left):
	clear()
	for disguises in range(disguises_left):                    #selectable - here we not needed but it can work as button
		add_icon_item(load("res://GFX/PNG/Tiles/tile_157.png"), false)
		#Don't forget to add column in properties or it item displays in rows!
