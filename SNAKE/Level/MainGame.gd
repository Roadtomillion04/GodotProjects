extends Node

const SNAKE = 0 #Check the snake spritesheet.png it shows 0, so that's the id of it,don't change it's name!
const APPLE = 1 #same as apple 2nd spritesheet it will name as 1 

var apple_pos
var snake_body = [Vector2(7,10),Vector2(8,10),Vector2(9,10)]#we are drawing a initial snake with these vector positions in Tilemap
var snake_direction = Vector2(-1,0) #Initially we are moving to lest as our vectors in right set it to correct or it triggers to reset
var apple_eaten = false
var direction_changed = false

var score = 0
var high_score = 0
var path = "user://savingplace.save"

func _ready():
	apple_pos = place_apple() #As we returning vector there we've set equal or it won't work!
	load_highscores()
	#save_highscores()
	print(high_score)
	
func place_apple():
	randomize()
	var x = randi() % 20 #as we set our height and width to 800, each cell of tilemap takes 40 pixels so 800/40 = 20 and tilemap grid starts from 0 so we get randi(1 to 19)
	var y = randi() % 20
	return Vector2(x,y) #Now we return as vector for apple pos or it won't work
	
func draw_apple():        #x        , #y         ,idx that is 1 for apple we referred above for our convience
	$SnakeApple.set_cell(apple_pos.x, apple_pos.y, APPLE) #Now we draw apple in apple_pos


func draw_snake():
#	for pos in snake_body:
	
	for block_index in snake_body.size():# we have to find nieghbours near head
		var block = snake_body[block_index]
		
		if block_index == 0: #we are getting head
			var head_dir = relation2(snake_body[0], snake_body[1]) # To check relationship b/w head and next block
			if head_dir == "right":                           #flip_h
				$SnakeApple.set_cell(block.x, block.y, SNAKE, true, false, false, Vector2(2,0))
			
			if head_dir == "left":
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(2,0))
				
			if head_dir == "up":                                     #flip_y
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(3,0))
				
			if head_dir == "down":
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, true, false, Vector2(3,0))
		
		elif block_index == snake_body.size() -1: # now we are getting last piece
			var tail_dir = relation2(snake_body[-1], snake_body[-2]) #last_pice and and it's neighbour
			
			if tail_dir == "right":
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(0,0)) # At last the vector is we are targeting the specific part of spritesheet, as usual rows and columns in spritesheet also starts form 0!
			
			if tail_dir == "left":
				$SnakeApple.set_cell(block.x, block.y, SNAKE, true, false, false, Vector2(0,0))
			
			if tail_dir == "up":
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, true, false, Vector2(0,1))	
			
			if tail_dir == "down":
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(0,1))

		
		else:
			# this is all for draw block neighbours
			var previous_block = snake_body[block_index + 1] - block #This works same as relation2()
			var next_block = snake_body[block_index - 1] - block
			
			if previous_block.x == next_block.x:
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(4,1))
			
			elif previous_block.y == next_block.y:
				$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(4,0))
			
			else:
				#this is all for draw corners!
				if previous_block.x == -1 and next_block.y == -1 or next_block.x == -1 and previous_block.y == -1: 
					$SnakeApple.set_cell(block.x, block.y, SNAKE, true, true, false, Vector2(5,0))

				if previous_block.x == -1 and next_block.y == 1 or next_block.x == -1 and previous_block.y == 1: 
					$SnakeApple.set_cell(block.x, block.y, SNAKE, true, false, false, Vector2(5,0))
					
				if previous_block.x == 1 and next_block.y == -1 or next_block.x == 1 and previous_block.y == -1: 
					$SnakeApple.set_cell(block.x, block.y, SNAKE, false, true, false, Vector2(5,0))
					
				if previous_block.x == 1 and next_block.y == 1 or next_block.x == 1 and previous_block.y == 1: 
					$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(5,0))
		
func relation2(first_block:Vector2, next_block:Vector2):
	var block_relation = next_block - first_block #this gives either 1 of the 4 vector2() below
	if block_relation == Vector2(-1, 0): return "left"
	if block_relation == Vector2(1, 0): return "right"
	if block_relation == Vector2(0, -1): return "up"
	if block_relation == Vector2(0, 1): return "down"
	
	
func move_snake():
	if apple_eaten:
		delete_tiles(SNAKE)# As snake keeps growing on we now have to delte the tiles(previous vectors)
		var body_copy = snake_body.slice(0, snake_body.size() - 1)# See this -1 matters, In this time we are not ignoring tail so size() -1 gives (0 to 2) which returns all 3 vectors so we add by one tile 
		var new_head = body_copy[0] + snake_direction # new head depends upon our new Input direction
		body_copy.insert(0, new_head) #position, value
		snake_body = body_copy
		apple_eaten = false # we have to grow only one tile not keep goin on
	
	else:	
		delete_tiles(SNAKE)# As snake keeps growing on we now have to delte the tiles(previous vectors)
		var body_copy = snake_body.slice(0, snake_body.size() - 2)# First we are creating a copy of actual snake without tail part, Look as we have declared three vectors above slice() starts from idx 0, as we are ignoring tail part When we are calling size()it returns 3 , So we -2 to get (0 and 1) that to get only two vectors in snake body
		var new_head = body_copy[0] + snake_direction # new head depends upon our new Input direction
		body_copy.insert(0, new_head) #position, value
		snake_body = body_copy 

func delete_tiles(id):# Remember in func arguements name dosen't matter only value matters!
	var used_cell = $SnakeApple.get_used_cells_by_id(id)#Takes only id
	for cell in used_cell: #So only used_cells will be deleted not all cells!
		$SnakeApple.set_cell(cell.x, cell.y, -1)# this -1 matters, it means delete the cell, and as it is in for loop it will loop forever so we draw only body copy 

func _input(_event):# We don't need any speed here as we are already moving in grid wise
	
	# By now the failure_state triggers if multiple buttons pressed continuously
	
	if Input.is_action_just_pressed("left") and not snake_direction == Vector2(1, 0) and not Input.is_action_just_pressed("right"): snake_direction = Vector2(-1, 0) 
	direction_changed = true
	
	if Input.is_action_just_pressed("right") and not snake_direction == Vector2(-1, 0) and not Input.is_action_just_pressed("left"): snake_direction = Vector2(1, 0)
	direction_changed = true
	
	if Input.is_action_just_pressed("up") and not snake_direction == Vector2(0, 1) and not Input.is_action_just_pressed("down"): snake_direction = Vector2(0, -1)
	direction_changed = true
	
	if Input.is_action_just_pressed("down") and not snake_direction == Vector2(0, -1) and not Input.is_action_just_pressed("up"): snake_direction = Vector2(0, 1)
	direction_changed = true
#To make sure snake is not moving backwards!

func check_apple_eaten():
	if apple_pos == snake_body[0]:# only head can interact
		apple_pos = place_apple() # changes to new pos
		apple_eaten = true # Now our snake can grow
	
func check_failure_states():
	var head = snake_body[0] #head
	#snake leaves the screen
	if head.x > 20 or head.x < 0 or head.y > 20 or head.y < 0 or head in $SnakeApple.get_used_cells_by_id(2): #as our Tilemap is divided 20 by 20 in x and y, we are not checking positions!
		reset()
		game_over()
	
	
	#snake bites its tail
	for block in snake_body.slice(1, snake_body.size() - 1):# now we ignoring head part and checking only body parts
		if head == block: # if head and body are equal( same pos like that )
			reset()
			game_over()

func reset():
	var _err = get_tree().reload_current_scene()
	snake_direction = Vector2(-1,0)
	
	
func _on_SnakeTick_timeout():
	direction_changed = false
	move_snake()
	draw_snake()
	draw_apple()
	check_apple_eaten()
	update_scores()
	check_failure_states()
	
func _process(_delta):
	if apple_pos in snake_body: #so that apple won't place on snake 
		apple_pos = place_apple()
	$HighScore.text = "best " + str(high_score)
		

func update_scores():
	if apple_eaten:
		score += 1
		$ScoreLabel.text = "Score " + str(score) #str(snake_body.size() - 2)# new way


func save_highscores():
	var save_data = File.new()
	save_data.open(path, File.WRITE)
	save_data.store_var(high_score)
	save_data.close()

func load_highscores():
	var save_data = File.new()
	if save_data.file_exists(path):
		save_data.open(path, File.READ)
		high_score = save_data.get_var()
		save_data.close()

func game_over():
	if score > high_score:
		high_score = score
		save_highscores()
	


func _on_Confuser_timeout():
	$SnakeApple.set_cell(randi() % 20, randi() % 20, APPLE)
	$SnakeApple.set_cell(randi() % 20, randi() % 20, 2)
