extends KinematicBody

# Constantes para a movimentação do player
const speed = 1
const time = 0.001

# Variáveis de posição e velocidade do player
var posf := Vector3(0,0,0)
var cod := Vector3(0,2,0)
var sp := Vector3(0,0,0)

# Sinal para o HUD
signal playerpos(vx, vy, vz)

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

# Se o requerimento HTTP tiver sucesso, iniciará a função
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8()) # Valor recebido em JSON
	# A cada conjunto de coordenadas (x,y,z), movimenta-se o player
	for position in positions:
		print(position)
		posf.x = position['X']
		print("X: ", posf.x)
		posf.y = position['Y']
		print("Y: ", posf.y)
		posf.z = position['Z']
		print("Z: ", posf.z)
		# Enquanto uma coordenada for diferente, será acrescentado um valor até igualar
		while (cod.x != posf.x or cod.y != posf.y or cod.z != posf.z):
			cod.x = PlayerPos(cod.x, posf.x, "x")
			cod.y = PlayerPos(cod.y, posf.y, "y")
			cod.z = PlayerPos(cod.z, posf.z, "z")
			print(cod.x, ", ", cod.y, ", ", cod.z) # Mostra as coordenadas atuais
			move_and_slide(sp) # Movimenta o player
			emit_signal("playerpos", cod.x, cod.y, cod.z) # Emite um sinal para o HUD
			yield(get_tree().create_timer(time), "timeout") # Delay
