extends KinematicBody

const speed = 1
const time = 0.001

var posf := Vector3(0,0,0)
var cod := Vector3(0,2,0)
var sp := Vector3(0,0,0)

signal playerpos(vx, vy, vz)

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
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8())
	for position in positions:
		print(position)
		posf.x = position['X']
		print("X: ", posf.x)
		posf.y = position['Y']
		print("Y: ", posf.y)
		posf.z = position['Z']
		print("Z: ", posf.z)
		while (cod.x != posf.x or cod.y != posf.y or cod.z != posf.z):
			cod.x = PlayerPos(cod.x, posf.x, "x")
			cod.y = PlayerPos(cod.y, posf.y, "y")
			cod.z = PlayerPos(cod.z, posf.z, "z")
			print(cod.x, ", ", cod.y, ", ", cod.z)
			move_and_slide(sp)
			emit_signal("playerpos", cod.x, cod.y, cod.z)
			yield(get_tree().create_timer(time), "timeout")
