extends Label

var score = 0 setget set_score

func set_score(new_score):
	score = new_score
	self.text = str(score) 
	
