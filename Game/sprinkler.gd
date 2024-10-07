extends CharacterBody2D

@onready var RAIZ = get_node("/root/Raiz")
var DISTANCIA = 0


func check():
	$Navegador.target_position = 32 * RAIZ.CaixaDagua + Vector2(16,16)
	if $Navegador.is_target_reachable():
		DISTANCIA = $Navegador.distance_to_target()
		return true
	return false


func regar(GASTAR:bool):
	if check():
		if GASTAR:
			RAIZ.AGUA -= int(RAIZ.CustoRegar + DISTANCIA/RAIZ.FatorDistancia)
		RAIZ.change_tile(5, RAIZ.get_tile(global_position),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(32,32)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(32,0)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(32,-32)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(-32,32)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(-32,0)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(-32,-32)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(0,32)),1)
		RAIZ.change_tile(5, RAIZ.get_tile(position + Vector2(0,-32)),1)
		
	
