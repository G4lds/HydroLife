extends Node2D

const CustoRegar:int = 1
const FatorDistancia:int = 400
const CaixaDagua:Vector2 = Vector2(3,3)
const LarguraMapa:int = 40
const AlturaMapa:int = 24

@onready var DisplaySize = get_viewport_rect().size

var AGUA:int = 250
var Dia:int = 0
var DiaTotal:int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level/Tilemap/Alto.set_cell(CaixaDagua,0,Vector2i(14,0))


func get_tile(POS:Vector2) -> Dictionary:
	return {
		"Solo": $Level/Tilemap/Solo.get_cell_atlas_coords(Vector2i(POS.x,POS.y)/32 ), 
		"Baixo": $Level/Tilemap/Baixo.get_cell_atlas_coords(Vector2i(POS.x,POS.y)/32 ), 
		"Alto": $Level/Tilemap/Alto.get_cell_atlas_coords(Vector2i(POS.x,POS.y)/32 ),
		"Pos": Vector2i(POS.x,POS.y)/32 
		}


func change_tile(COMO:int,QUEM:Dictionary,TIPO:int = 0) -> bool:
	match COMO:
		1:
			if [Vector2i(1,0),Vector2i(2,0)].has(QUEM.Solo) and QUEM.Baixo == Vector2i(-1,-1):
				$Level/Tilemap/Solo.set_cell(QUEM.Pos,0,QUEM.Solo + Vector2i(1,0))
				return true
		7:
			if QUEM.Solo == Vector2i(0,0) and QUEM.Baixo == Vector2i(-1,-1):
				$Level/Tilemap/Solo.set_cell(QUEM.Pos,0,Vector2i(2,0))
				return true
		5:
			if QUEM.Alto == Vector2i(14,0):
				AGUA -= 10 - TIPO
				return true
			elif QUEM.Solo == Vector2i(3,0):
				$Level/Tilemap/Solo.set_cell(QUEM.Pos,0,Vector2i(4,0))
				return false
		8:
			if QUEM.Alto == Vector2i(-1,-1):
				$Level/Tilemap/Alto.set_cell(QUEM.Pos,0,Vector2i(0,2))
				return true
		9:
			if QUEM.Alto == Vector2i(-1,-1):
				$Level/Tilemap/Alto.set_cell(QUEM.Pos,0,Vector2i(0,3))
				add_sprinkler(QUEM.Pos)
				return true
		4:
			if [Vector2i(0,2),Vector2i(1,2),Vector2i(2,2),Vector2i(3,2),Vector2i(4,2)].has(QUEM.Alto):
				$Level/Tilemap/Alto.set_cell(QUEM.Pos,0,Vector2i(-1,-1))
				return true
			elif [Vector2i(0,3),Vector2i(1,3),Vector2i(2,3),Vector2i(3,3),Vector2i(4,3)].has(QUEM.Alto):
				$Level/Tilemap/Alto.set_cell(QUEM.Pos,0,Vector2i(-1,-1))
				$Estruturas/Sprinklers.remove_children(Vector2(32 * QUEM.Pos + Vector2i(16,16)))
				return true
		6:
			if [Vector2i(3,0),Vector2i(4,0)].has(QUEM.Solo) and QUEM.Baixo == Vector2i(-1,-1):
				if TIPO > 4:
					$Level/Tilemap/Baixo.set_cell(QUEM.Pos,0,Vector2i(16-TIPO,3))
					add_Planta(QUEM.Pos,TIPO)
				elif QUEM.Alto == Vector2i(-1,-1):
					$Level/Tilemap/Baixo.set_cell(QUEM.Pos,0,Vector2i(16-TIPO,3))
					add_Planta(QUEM.Pos,TIPO)
				return true
		2:
			if [4,5,6,7,9,11].has(QUEM.Baixo.y) and [7,8,9,10,11,12,13,14,15].has(QUEM.Baixo.x):
				$Level/Tilemap/Baixo.set_cell(QUEM.Pos,0,Vector2i(-1,-1))
				$Estruturas/Plantas.remove_children(Vector2(32 * QUEM.Pos + Vector2i(16,16)))
				return false
			elif [Vector2i(1,0),Vector2i(3,0)].has(QUEM.Solo) and QUEM.Baixo == Vector2i(-1,-1):
				$Level/Tilemap/Solo.set_cell(QUEM.Pos,0,QUEM.Solo - Vector2i(1,0))
				return true
			elif Vector2i(2,0) == (QUEM.Solo) and QUEM.Baixo == Vector2i(-1,-1):
				$Level/Tilemap/Solo.set_cell(QUEM.Pos,0,QUEM.Solo - Vector2i(2,0))
				return true
			elif Vector2i(4,0) == (QUEM.Solo) and QUEM.Baixo == Vector2i(-1,-1):
				$Level/Tilemap/Solo.set_cell(QUEM.Pos,0,QUEM.Solo - Vector2i(2,0))
				return false
		3:
			if [3,4,5,6,8,10].has(QUEM.Baixo.y) and [8,9,10,11,12,13,14,15].has(QUEM.Baixo.x):
				if TIPO == 0:
					$Level/Tilemap/Baixo.set_cell(QUEM.Pos,0,Vector2i(-1,-1))
					$Estruturas/Plantas.remove_children(Vector2(32 * QUEM.Pos + Vector2i(16,16)))
				else:
					$Level/Tilemap/Baixo.set_cell(QUEM.Pos,0,Vector2i(-1,-1))
				return true
			
		101:
			$Level/Tilemap/Baixo.set_cell(QUEM.Pos,0,Vector2i(QUEM.Baixo.x,TIPO))
			pass
			
	return false


func add_sprinkler(POS: Vector2i) -> void:
	var SPRINKLER = preload("res://sprinkler.tscn").instantiate()
	SPRINKLER.position = Vector2(32 * POS + Vector2i(16,16))  
	$Estruturas/Sprinklers.add_child(SPRINKLER)


func add_Planta(POS: Vector2i, TIPO):
	var PLANTA = preload("res://planta.tscn").instantiate()
	PLANTA.TIPO = TIPO
	PLANTA.position = Vector2(32 * POS + Vector2i(16,16))
	$Estruturas/Plantas.add_child(PLANTA)


func _secar_agua() -> void:
	for j in range(0,LarguraMapa):
		for i in range(0,AlturaMapa):
			if get_tile(32 * Vector2(j,i) + Vector2(16,16)).Solo == Vector2i(4,0):
				$Level/Tilemap/Solo.set_cell(Vector2(j,i),0,Vector2i(3,0))


func Turno() -> void:
	Dia += 1
	DiaTotal += 1
	if Dia > 10:
		Dia = 0
		AGUA = clamp(AGUA + 50,0,250)
		
	$Estruturas/Sprinklers.regar(false)
	$Estruturas/Plantas.crescer()
	$Estruturas/Plantas.Morrer()
	_secar_agua()
	$Estruturas/Sprinklers.regar()
	print("AGUA: ",AGUA)
