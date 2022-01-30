extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT # starting from
var borders = Rect2()
var step_history = []
var step_since_turn = 0 # To prevent longer hallways

func _init(starting_position, new_borders): #Called when the object is initialized.
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders

func walk(steps):
	for step in steps:
		if randf() <= 0.25 or step_since_turn >= 4:
			change_direction()

		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		step_since_turn += 1
		position = target_position
		return true
	
	else:
		return false # oustide of boders

func change_direction():
	step_since_turn = 0
	var directions = DIRECTIONS.duplicate() # as DIRECTION is const we can't change its value so we are creating a copy!
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while !borders.has_point(position + direction):
		direction = directions.pop_front()
