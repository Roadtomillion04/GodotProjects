extends Particles2D

onready var animated_sprite = get_parent().get_node("AnimatedSprite")

var frame_texture:Texture

func _physics_process(_delta):
	frame_texture = animated_sprite.get_sprite_frames().get_frame(animated_sprite.animation, animated_sprite.get_frame())

	texture = frame_texture
