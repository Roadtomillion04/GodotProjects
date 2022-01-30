extends Popup

var combination:Array 
var guess:Array

onready var display = $VBoxContainer/DisplayContainer/Label
onready var light = $VBoxContainer/ButtonContainer/GridContainer/TextureRect


signal combination_correct

func _ready():
	#randomize()
	#combination =  [randi() % 10,randi() % 10,randi() % 10,randi() % 10,]
	connect_buttons()
	reset_lock()
	

func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if child is Button: #See We make sure only buttons are selected no matter whatever node exists in this
			child.connect("pressed", self, "Button_pressed", [child.text])
			#connects button signals, From, To, string method,  binds - Now whatever is in text of button node will emit as argument
			
func Button_pressed(button): #no matter argument name only value matters!
		if button == "OK":
			check_guess()
		else:
			enter( int(button) )#connect method cast as strings but we need numbers here!

func check_guess():
	display.text = "CHecking"
	yield(get_tree().create_timer(1),"timeout")
	 #yield waits for above code to execute for 1 sec
	if guess == combination:
		$Timer.start()
		light.texture = load("res://GFX/Interface/PNG/dotGreen.png")
		$AudioStreamPlayer2D.stream = load("res://SFX/threeTone1.ogg")
		$AudioStreamPlayer2D.play()
	
	else:
		reset_lock()


func enter(button):
	guess.append(button) #append - adds front and whatever button we press adds up
	update_display()
	$AudioStreamPlayer2D.stream = load("res://SFX/twoTone1.ogg")
	$AudioStreamPlayer2D.play()

func update_display():
	display.text = PoolStringArray(guess).join("") #poolstringarray converts into string as label.text needs to be in string
	if guess.size() == combination.size():         #and Join - joins the Array of string together
		check_guess()

func reset_lock(): 
	display.text = ""
	guess.clear()
	display.text = "Error"


func _on_LockedDoor_reset():
	reset_lock()


func _on_Timer_timeout():
	emit_signal("combination_correct")
	hide()
	
