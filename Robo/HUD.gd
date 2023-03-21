extends Control

onready var posx = $GridContainer/PosXValue
onready var posy = $GridContainer/PosYValue
onready var posz = $GridContainer/PosZValue

func _on_Player_playerpos(vx, vy, vz):
	posx.text = str(vx)
	posy.text = str(vy)
	posz.text = str(vz)
