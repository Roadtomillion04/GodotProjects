extends AnimatedSprite

func _ready():
	self.frame = 0# remember this
	self.playing = true
	


func _on_HurtEffectForCharcters_animation_finished():
	queue_free()
