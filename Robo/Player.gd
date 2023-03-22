extends KinematicBody

# Constantes para a movimentação do player
const speed = 1
const time = 0.001

# Variáveis de coordenadas
var cod := Vector3.ZERO
var codf := Vector3.ZERO
# Variáveis de rotação
var rot := Vector3.ZERO
var rotf := Vector3.ZERO
# Variáveis de velocidade
var sp := Vector3.ZERO

# Sinal para o HUD
signal playerpos(cx, cy, cz, rx, ry, rz)

# Função que iguala as posições e determina o sentido do movimento
func PlayerPos(init, final, axis):
	if final > init:
		if axis == "x": sp.x = speed
		elif axis == "y": sp.y = speed
		elif axis == "z": sp.z = speed
		return init + speed
	elif final < init:
		if axis == "x": sp.x = -speed
		elif axis == "y": sp.y = -speed
		elif axis == "z": sp.z = -speed
		return init - speed
	else:
		if axis == "x": sp.x = 0
		elif axis == "y": sp.y = 0
		elif axis == "z": sp.z = 0
		return init

func RotPlayer(init, final):
	if final > init:
		return init + speed
	elif final < init:
		return init - speed
	else:
		return init

# Se o requerimento HTTP tiver sucesso, iniciará a função
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8()) # Valor recebido em JSON
	# A cada conjunto de coordenadas (x,y,z), movimenta-se o player
	for position in positions:
		print(position)
		codf.x = position['X']
		print("X: ", codf.x)
		codf.y = position['Y']
		print("Y: ", codf.y)
		codf.z = position['Z']
		print("Z: ", codf.z)
		print("")
		
		rotf.x = position['Rx']
		print("Rx: ", rotf.x)
		rotf.y = position['Ry']
		print("Ry: ", rotf.y)
		rotf.y = position['Rx']
		print("Rz: ", rotf.z)
		
		# Enquanto um valor for diferente, será acrescentado um valor até igualar
		while (cod.x != codf.x or cod.y != codf.y or cod.z != codf.z or rot != rotf):
			cod.x = PlayerPos(cod.x, codf.x, "x")
			cod.y = PlayerPos(cod.y, codf.y, "y")
			cod.z = PlayerPos(cod.z, codf.z, "z")
			
			rot.x = PlayerPos(rot.x, rotf.x, "0")
			rot.y = PlayerPos(rot.y, rotf.y, "0")
			rot.z = PlayerPos(rot.z, rotf.z, "0")

			# Mostra as coordenadas atuais
			print(cod.x, ", ", cod.y, ", ", cod.z)
			# Mostra as rotações atuais
			print(rot.x, ", ", rot.y, ", ", rot.z)
			
			# Movimenta o player
			sp = move_and_slide(sp)
			
			# Rotaciona o player
			self.rotation_degrees.x = rot.x
			self.rotation_degrees.y = rot.y
			self.rotation_degrees.z = rot.z
			
			# Emite um sinal para o HUD
			emit_signal("playerpos", cod.x, cod.y, cod.z, rot.x, rot.y, rot.z)
			yield(get_tree().create_timer(time), "timeout") # Delay
