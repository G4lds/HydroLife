extends Node2D
@onready var RAIZ = get_node("/root/Raiz")
var dead = []

func remove_children(POS):
	for i in range(0,get_child_count()):
		if get_child(i).position == POS:
			remove_child(get_child(i))

func Morrer():
	for i in range(0,len(dead)):
		RAIZ.change_tile(3,RAIZ.get_tile(dead[i].position),1)
		remove_child(dead[i])


func crescer(): 
	for i in range(0,get_child_count()):
		if not get_child(i).crescer():
			dead.append(get_child(i))
				
				
