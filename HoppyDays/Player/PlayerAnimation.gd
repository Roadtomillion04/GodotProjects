extends AnimatedSprite

#using this method will not crash the game even if animatedsprite is deleted
#we should code the way game not crash any way! this is good pracices

func _ready():
	pass

func _on_Player_animate(motion):
	if motion.y < 0:
		play("jump")  #using self is not elegant
	
	elif motion.x > 0:
		play("walk")
		flip_h = false
		
	elif motion.x < 0:
		play("walk")
		flip_h = true
		
	else :
		play("idle")	

