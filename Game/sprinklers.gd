extends Node2D
@onready var RAIZ = get_node("/root/Raiz")

func remove_children(POS):
	for i in range(0,get_child_count()):
		if get_child(i-1).position == POS:
			remove_child(get_child(i-1))

func regar(GASTAR:bool = true):
	for i in range(0,get_child_count()):
		get_child(i).regar(GASTAR)
