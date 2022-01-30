extends Node

#Singleton -- Exists permanently in Background! Avoid as much less usage of it or it leads to sphagetti code


func generate_combination(length):
	var combination:Array
	for number in range(length): #Range starts from 0 
		combination.append(randi() % 10) 
	return combination	#Return = returns the code after appending
