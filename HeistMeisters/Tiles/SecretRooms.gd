extends TileMap

onready var tween = $Tween
onready var collision_shape = get_node("Area2D/CollisionShape2D")

#We added collision shape in level scene for customization

func _ready():
	assert(collision_shape != null) # assert looks for false if it's false it terminates the program

func _on_Area2D_body_entered(_body):
	
	collision_shape.call_deferred("disabled", true) #call deferred calls the "property"
	
	tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 
	1, Tween.TRANS_SINE,Tween.EASE_OUT) #last 1 is alpha from 1 to 0
 
	tween.start()
	


func _on_Tween_tween_completed(_object, _key):
	queue_free()
