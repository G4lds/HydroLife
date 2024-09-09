extends CharacterBody2D

@onready var RAIZ = get_node("/root/Raiz")
var DISTANCIA = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Navegador.target_position = Vector2(112,112)
	
	




func check():
	if $Navegador.is_target_reachable():
		DISTANCIA = $Navegador.distance_to_target()
		return true
	print($Navegador.distance_to_target())
	print($Navegador.is_target_reachable())
	print($Navegador.get_next_path_position())
	return false

func regar():
	if check():
		RAIZ.AGUA -= RAIZ.CustoRegar
		RAIZ.change_tile(3, RAIZ.get_tile(global_position) ,global_position )
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(32,32)) ,global_position + Vector2(32,32))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(32,0)) ,global_position + Vector2(32,0))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(32,-32)) ,global_position + Vector2(32,-32))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(-32,32)) ,global_position + Vector2(-32,32))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(-32,0)) ,global_position + Vector2(-32,0))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(-32,-32)) ,global_position + Vector2(-32,-32))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(0,32)) ,global_position + Vector2(0,32))
		RAIZ.change_tile(3, RAIZ.get_tile(global_position + Vector2(0,-32)) ,global_position + Vector2(0,-32))
		
	
