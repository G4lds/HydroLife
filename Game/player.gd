extends CharacterBody2D

@onready var RAIZ = get_node("/root/Raiz")
const SPEED = 300.0

var TOOL = 0
	
func _physics_process(delta: float) -> void:

	var direction := [Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down")]
	if direction:
		velocity.x = direction[0]
		velocity.y = direction[1]
		velocity = velocity.normalized() * SPEED
	move_and_slide()
	
	$Mouse.position = get_local_mouse_position()
	
	if Input.is_action_just_pressed("acao primaria"):
		$Animacoes.play("ferramenta")
		print(RAIZ.get_tile($Mouse.position))
		print($Mouse.global_position)
		RAIZ.change_tile(TOOL, RAIZ.get_tile($Mouse.global_position) ,$Mouse.global_position )
	
	if Input.is_action_just_pressed("Item 0"):
		change_tool(0)
	elif Input.is_action_just_pressed("Item 1"):
		change_tool(1)
	elif Input.is_action_just_pressed("Item 2"):
		change_tool(2)
	elif Input.is_action_just_pressed("Item 3"):
		change_tool(3)
	elif Input.is_action_just_pressed("Item 4"):
		change_tool(4)
	elif Input.is_action_just_pressed("Item 5"):
		change_tool(5)
	elif Input.is_action_just_pressed("Item 6"):
		change_tool(6)

func change_tool(tool:int):
	TOOL = tool
	$"Sprite Ferramenta".region_rect =  Rect2(tool * 32 - 32, 480, 32, 32)
	
