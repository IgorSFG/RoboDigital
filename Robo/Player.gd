extends KinematicBody

const speed = 1

var posfx = 0
var posfy = 0
var posfz = 0
var cod := Vector3(0, 2, 0)

signal playerpos(vx, vy, vz)

func Velocity(init, final):
	if final > init:
		return init + speed
	elif final < init:
		return init - speed
	else:
		return init
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8())
	for position in positions:
		print(position)
		posfx = position['X']
		print(posfx)
		posfy = position['Y']
		print(posfy)
		posfz = position['Z']
		print(posfz)
		while (cod.x != posfx or cod.y != posfy or cod.z != posfz):
			cod.x = Velocity(cod.x, posfx)
			cod.y = Velocity(cod.y, posfy)
			cod.z = Velocity(cod.z, posfz)
			print(cod.x, ", ", cod.y, ", ", cod.z)
			move_and_slide(cod)
			emit_signal("playerpos", cod.x, cod.y, cod.z)
			yield(get_tree().create_timer(0.1), "timeout")
