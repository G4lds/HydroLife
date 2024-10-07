extends Control
@onready var RAIZ = get_node("/root/Raiz")
var Inventory:Dictionary
enum {ID,Capacidade,Quantidade,Tipo}
enum {Vazio,Enxada,Pa,Foice,Marreta,Regador,Sementes,Terra,Cano,Dispersor}
# Called every frame. 'delta' is the elapsed time since the previous frame.dd
func _process(delta: float) -> void:
	match get_parent().get_parent().Tool:
		0:
			$Selecao.visible = false
		1:
			$Selecao.visible = true
			$Selecao.offset.x = 1*32
		2:
			$Selecao.visible = true
			$Selecao.offset.x = 2*32
		3:
			$Selecao.visible = true
			$Selecao.offset.x = 3*32
		4:
			$Selecao.visible = true
			$Selecao.offset.x = 4*32
		5:
			$Selecao.visible = true
			$Selecao.offset.x = 5*32
		6:
			$Selecao.visible = true
			$Selecao.offset.x = 6*32
		7:
			$Selecao.visible = true
			$Selecao.offset.x = 7*32
		8:
			$Selecao.visible = true
			$Selecao.offset.x = 8*32
		9:
			$Selecao.visible = true
			$Selecao.offset.x = 9*32
	
	Inventory = get_parent().get_parent().Inventario
	$"52".text = "Q:" + str(Inventory[Regador][Quantidade])
	$"62".text = "Q:" + str(Inventory[Sementes][Quantidade][Inventory[Sementes][Tipo]]) + "\n T:" + str(Inventory[Sementes][Tipo])
	$"72".text = "Q:" + str(Inventory[Terra][Quantidade])
	$"82".text = "Q:" + str(Inventory[Cano][Quantidade])
	$"92".text = "Q:" + str(Inventory[Dispersor][Quantidade])
	$Agua.text = "Agua: " + str(RAIZ.AGUA)
	$Dia.text = "Dia: " + str(RAIZ.DiaTotal)
	
	
