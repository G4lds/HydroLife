extends CharacterBody2D

@onready var RAIZ = get_node("/root/Raiz")
const SPEED = 200.0
const ALCANCE = 96
enum {ID,Capacidade,Quantidade,Tipo}
enum {Vazio,Enxada,Pa,Foice,Marreta,Regador,Sementes,Terra,Cano,Dispersor}

var Inventario:Dictionary ={
	Enxada			:{ID:1},
	Pa				:{ID:2},
	Foice			:{ID:3},
	Marreta			:{ID:4},
	Regador			:{ID:5,Capacidade:10,Quantidade:10},
	Sementes		:{ID:6,Tipo:1,
		Quantidade:{
			1:10,
			2:10,
			3:10,
			4:10,
			5:10,
			6:10,
			7:10,
			8:10}},
	Terra			:{ID:7,Quantidade:10},
	Cano			:{ID:8,Quantidade:10},
	Dispersor		:{ID:9,Quantidade:10}
}

var Tool:int = 0

func _input(event):
	if Input.is_action_just_pressed("Item0"):
		change_tool(0)
	elif Input.is_action_just_pressed("Item1"):
		change_tool(1)
	elif Input.is_action_just_pressed("Item2"):
		change_tool(2)
	elif Input.is_action_just_pressed("Item3"):
		change_tool(3)
	elif Input.is_action_just_pressed("Item4"):
		change_tool(4)
	elif Input.is_action_just_pressed("Item5"):
		change_tool(5)
	elif Input.is_action_just_pressed("Item6"):
		change_tool(6)
	elif Input.is_action_just_pressed("Item7"):
		change_tool(7)
	elif Input.is_action_just_pressed("Item8"):
		change_tool(8)
	elif Input.is_action_just_pressed("Item9"):
		change_tool(9)
	elif Input.is_action_pressed("RodaMouseCima"):
		if Tool < 9:
			change_tool(Tool+1)
		else:
			change_tool(0)
	elif Input.is_action_pressed("RodaMouseBaixo"):
		if Tool > 0:
			change_tool(Tool-1)
		else:
			change_tool(9)
	
	if Input.is_action_just_pressed("acao primaria"):
		$Animacoes.play("ferramenta")
		use_tool(Tool)
		print(Inventario)
	
	if Input.is_action_pressed("ui_accept"):
		RAIZ.Turno()
		


func _physics_process(_delta: float) -> void:

	var direction := [Input.get_axis("Esquerda", "Direita"), Input.get_axis("Cima", "Baixo")]
	if direction:
		velocity.x = direction[0]
		velocity.y = direction[1]
		velocity = velocity.normalized() * SPEED
	move_and_slide()
	
	$Camera.global_position.x = clamp(RAIZ.DisplaySize.x/4 - 32,global_position.x,RAIZ.LarguraMapa*32 - RAIZ.DisplaySize.x/4 + 32)
	$Camera.global_position.y = clamp(RAIZ.DisplaySize.y/4 - 32,global_position.y,RAIZ.AlturaMapa*32 - RAIZ.DisplaySize.y/4 + 32)
	
	$Mouse.position = get_local_mouse_position().normalized() * clamp(Vector2(0,0).distance_to(get_local_mouse_position()),0,ALCANCE)
	$Mouse/Selecao.global_position = (Vector2i(clamp(0,$Mouse.global_position.x,RAIZ.DisplaySize.x),clamp(0,$Mouse.global_position.y,RAIZ.DisplaySize.y))/32) * 32 + Vector2i(16,16)

func use_tool(TOOL):
	match TOOL:
		1:
			RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position))
		3:
			var tipo = RAIZ.get_tile($Mouse.global_position).Baixo
			if RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position)):
				if tipo.y == 10:
					Inventario[Sementes][Quantidade][16 - tipo.x] += 4
				else:
					Inventario[Sementes][Quantidade][16 - tipo.x] += 1
		2:
			if RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position)):
				Inventario[Terra][Quantidade] += 1
		4:
			print(RAIZ.get_tile($Mouse.global_position).Alto.y)
			if RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position)):
				if RAIZ.get_tile($Mouse.global_position).Alto.y == 2:
					Inventario[Cano][Quantidade] += 1
				elif RAIZ.get_tile($Mouse.global_position).Alto.y == 3:
					Inventario[Dispersor][Quantidade] += 1
		5:
			if Inventario[TOOL][Quantidade] > 0:
				if RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position),Inventario[Regador][Quantidade]):
					Inventario[TOOL][Quantidade] = 10
				else:
					Inventario[TOOL][Quantidade] -= 1
		7,8,9:
			if Inventario[TOOL][Quantidade] > 0:
				if RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position)):
					Inventario[TOOL][Quantidade] -= 1
		6:
			if Inventario[Sementes][Quantidade][Inventario[Sementes][Tipo]] > 0:
				if RAIZ.change_tile(TOOL,RAIZ.get_tile($Mouse.global_position),Inventario[Sementes][Tipo]):
					Inventario[Sementes][Quantidade][Inventario[Sementes][Tipo]] -= 1

func change_tool(TOOL:int):
	if Tool == TOOL and Tool == 6:
		match Inventario[Sementes][Tipo]:
			1,2,3,4,5,6,7:
				Inventario[Sementes][Tipo] += 1
			8:
				Inventario[Sementes][Tipo] = 1
	Tool = TOOL
	$"Sprite Ferramenta".region_rect =  Rect2(TOOL * 32 - 32, 480, 32, 32)
	
