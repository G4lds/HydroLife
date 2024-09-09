extends Node2D

var AGUA = 100
var AGUA_GASTA = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_tile(POS:Vector2) -> Vector2:
	return $Level/Tilemap/Ground.get_cell_atlas_coords(Vector2(floor(POS.x),floor(POS.y))/32)

func change_tile(COMO:int,QUEM:Vector2,POS) -> void:
	match COMO:
		1:
			if [1,2].has(int(QUEM.x)):
				$Level/Tilemap/Ground.set_cell(Vector2(floor(POS.x),floor(POS.y))/32,0,QUEM+Vector2(1,0))
		2:
			if 0 == int(QUEM.x):
				$Level/Tilemap/Ground.set_cell(Vector2(floor(POS.x),floor(POS.y))/32,0,QUEM+Vector2(2,0))
		3:
			if 3 == int(QUEM.x):
				$Level/Tilemap/Ground.set_cell(Vector2(floor(POS.x),floor(POS.y))/32,0,QUEM+Vector2(1,0))
		4:
			if 3 != int(QUEM.x):
				$Level/Tilemap/Detail.set_cell(Vector2(floor(POS.x),floor(POS.y))/32,0,Vector2(9,6))
				$Estruturas/Sprinklers.check_children()
		5: 
			if 3 != int(QUEM.x):
				$Level/Tilemap/Detail.set_cell(Vector2(floor(POS.x),floor(POS.y))/32,0,Vector2(9,7))
				add_sprinkler(POS)
				$Estruturas/Sprinklers.check_children()
		6:
			if 3 != int(QUEM.x):
				$Level/Tilemap/Detail.set_cell(Vector2(floor(POS.x),floor(POS.y))/32,0,Vector2(-1,-1))
				$Estruturas/Sprinklers.check_children()
				$Estruturas/Sprinklers.remove_children(Vector2(32 * int(POS.x/32)+16,32 * int(POS.y/32)+16))
			

func add_sprinkler(POS: Vector2):
	var SPRINKLER = preload("res://sprinkler.tscn").instantiate()
	SPRINKLER.position = Vector2(32 * int(POS.x/32)+16,32 * int(POS.y/32)+16)
	$Estruturas/Sprinklers.add_child(SPRINKLER)
	

func tick():
	print(tick())
