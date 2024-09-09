extends Node2D


func check_children():
	$Timer.start()

func remove_children(POS):
	for i in range(1,get_child_count()):
		if get_child(i).position == POS:
			remove_child(get_child(i))

func _check_children():
	for i in range(1,get_child_count()):
		get_child(i).check()

func _on_timer_timeout() -> void:
	_check_children()
