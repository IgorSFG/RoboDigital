extends Control

# Constantes para os componentes do HUD
onready var posx = $GridContainer/PosXValue
onready var posy = $GridContainer/PosYValue
onready var posz = $GridContainer/PosZValue

# Sinal recebido pelo player, com as posições
func _on_Player_playerpos(vx, vy, vz):
	posx.text = str(vx)
	posy.text = str(vy)
	posz.text = str(vz)
