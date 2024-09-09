extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Navegador.target_position = Vector2(112,112)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	print($Navegador.distance_to_target())
	print($Navegador.is_target_reachable())
	print($Navegador.get_next_path_position())
