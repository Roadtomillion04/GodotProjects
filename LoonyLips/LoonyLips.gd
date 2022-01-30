extends Control

var player_words:Array = []

var template:Array = [
	{"prompts": ["your name","a food","a color","ur fav game"],
	"story": "A hero called %s loves eating %s likes %s color and loves to play %s"},

	{"prompts": ["your friend name","a food","a color","ur fav game"],
	"story": "A hero's friend called %s loves eating %s likes %s color and loves to play %s"}

]

var current_story

onready var playerText = $VBoxContainer/HBoxContainer/PlayerText
onready var displayText = $VBoxContainer/DisplayText


func _ready():
	pick_current_story()
	displayText.text = "Welcome to LoonyLips and we tell u a story "
	check_player_words_length() #This is key and should execute first
	playerText.grab_focus()

func pick_current_story():
	randomize()
	var select_Story = $StoryBook.get_child_count()
	current_story = template[randi() % template.size()] #refer randi



func _on_LineEdit_text_entered(new_text):
	add_to_playerwords()


func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_playerwords()
	


func add_to_playerwords():
	if playerText.text == "":
		displayText.text = "Please Enter Something " 
		
	else:	
		player_words.append(playerText.text)
		displayText.text = "" #empty
		playerText.clear()
		check_player_words_length() #only then ask_prompt and tell_story will execute
	
func is_story_done():
	return player_words.size() == current_story.prompts.size() #after return no code will execute in func
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else :
		ask_prompts()
		
func tell_story():
	displayText.text = current_story.story % player_words	
	
func ask_prompts():
	displayText.text += "May I have " + current_story.prompts[player_words.size()]
	
func end_game():
	playerText.queue_free()
	tell_story()
	$VBoxContainer/HBoxContainer/Label.text = "play again!"
