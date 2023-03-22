extends Control

# Variáveis para as posições do HUD
onready var posx = $Positions/GridContainer/PosXValue
onready var posy = $Positions/GridContainer/PosYValue
onready var posz = $Positions/GridContainer/PosZValue

# Variáveis para as rotações do HUD
onready var rotx = $Rotations/GridContainer/PosXValue
onready var roty = $Rotations/GridContainer/PosYValue
onready var rotz = $Rotations/GridContainer/PosZValue

# Sinal enviado pelo player, com as posições
func _on_Player_playerpos(cx, cy, cz, rx, ry, rz):
	posx.text = str(cx)
	posy.text = str(cy)
	posz.text = str(cz)
	
	rotx.text = str(rx)
	roty.text = str(ry)
	rotz.text = str(rz)
