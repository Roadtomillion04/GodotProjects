extends Area2D

func is_coliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0 
	
func push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_coliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position).normalized()
		#push_vector = push_vector.normalized()
	return push_vector

#it dosent work idk why..
