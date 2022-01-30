extends AnimatedSprite

#I've did this so game wont crash even if this node deleted in player node 

func player_animation(velocity): #Don't forget to call and pass func(aruguments) in player
	if velocity.y > 0:
		play("walk_down")
	
	elif velocity.y < 0: # use elif as we changing
		play("walk_up")

	elif velocity.x != 0:
		play("walk_side")
		flip_h = velocity.x > 0 #As we have one animation facing left,It autmatically returns true or false 
		
	else:
		stop()
		frame = 0 #stand animation
