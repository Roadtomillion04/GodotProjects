extends Label

var score = 0 setget set_score

func set_score(new_score):
	score = new_score
	text = "kills" + str(score)

#if we set this code on enemy script it gets deleted with queue_free so it wont update after score 1
