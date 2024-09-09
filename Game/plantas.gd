extends Node2D
@onready var RAIZ = get_node("/root/Raiz")

func regar():
	$Timer.start()

func remove_children(POS):
	for i in range(1,get_child_count()):
		if get_child(i).position == POS:
			remove_child(get_child(i))

func _regar():
	for i in range(1,get_child_count()):
		get_child(i).regar()
	print(RAIZ.AGUA)

func _on_timer_timeout() -> void:
	_regar()
