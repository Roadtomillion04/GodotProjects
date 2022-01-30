extends Sprite

func _ready():
	modulate.a = lerp(modulate.a,0,0.1)
	if (modulate.a < 0.01):
		queue_free()
