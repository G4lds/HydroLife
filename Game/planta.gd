extends CharacterBody2D

@onready var RAIZ = get_node("/root/Raiz")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if RAIZ.get_tile == 4:
		return true
	return false

func regar():
	if not check():
		pass
		
	
