extends CharacterBody2D

@onready var RAIZ = get_node("/root/Raiz")
var TIPO = 0
var CRECIMENTO = 0
var VIDA = 6


func crescer():
	print(VIDA ," ", CRECIMENTO)
	if _check() and CRECIMENTO <= 5:
		match TIPO:
			1:
				CRECIMENTO += .1
			2:
				CRECIMENTO += .2
			3:
				CRECIMENTO += .3
	elif CRECIMENTO <= 5:
		match TIPO:
			0:
				VIDA -= 2
			1:
				VIDA -= 2
			2:
				VIDA -= 2
	else:
		match TIPO:
			0:
				VIDA -= 1
			1:
				VIDA -= 2
			2:
				VIDA -= 3
	if VIDA <= 0:
			print("vida: ",VIDA)
			return false
	match int(CRECIMENTO):
		1:
			RAIZ.change_tile(101,RAIZ.get_tile(position),4)
		2: 
			RAIZ.change_tile(101,RAIZ.get_tile(position),5)
		3:
			RAIZ.change_tile(101,RAIZ.get_tile(position),6)
		4:
			RAIZ.change_tile(101,RAIZ.get_tile(position),8)
		5:
			RAIZ.change_tile(101,RAIZ.get_tile(position),10)
	return true

func _check():
	if RAIZ.get_tile(position).Solo == Vector2i(4,0):
		return true
	return false
	
		
	
