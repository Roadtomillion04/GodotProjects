extends Area2D

var direction:int = 0

func _ready():
	$Investment_UI/Investment_UI.hide()

func _process(_delta):
	$AnimatedSprite.frame = direction


func facedown():
	direction = 0
func faceup():
	direction = 3
func faceleft():
	direction = 1
func faceright():
	direction = 2
	

func investment_popup():
	get_tree().call_group("GUI", "_on_invest_mode")
	$Investment_UI/Investment_UI.show()
	
	
