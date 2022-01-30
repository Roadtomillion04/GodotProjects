extends CanvasModulate

const DARK = Color("111111") #remeber C is in caps! or it call property
const NIGHTVISION = Color("06ff27")

var cooldown_over = false

func _ready():
	color = DARK


func _process(_delta):
	if color == NIGHTVISION:
		get_tree().call_group("VisionCooldown", "update_visioncooldown")
	
	if cooldown_over:
		DARK_mode()
		cooldown_over = false

func cycle_vision_mode():
	if color == DARK:
		NIGHTVISION_mode() #It's easy to refer const 
	else:
		DARK_mode()

func NIGHTVISION_mode():
	if $Timer.is_stopped():
		color = NIGHTVISION
		$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
		$AudioStreamPlayer2D.play()
		$Timer.start()
		get_tree().call_group("lights", "hide")# Built-in func so no specific extendend script needed!
		get_tree().call_group("labels", "show")
 
func DARK_mode():
	if $Timer.is_stopped():
		color = DARK
		$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
		$AudioStreamPlayer2D.play()
		$Timer.start()
		get_tree().call_group("lights", "show")
		get_tree().call_group("labels", "hide")

func _on_Timer_timeout():
	pass


func change_to_DARK_mode():
	if not cooldown_over:
		cooldown_over = true










