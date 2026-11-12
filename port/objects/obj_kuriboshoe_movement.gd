# 第 4 批移植，已核对。
extends GMObject

var state: float = 0.0


# from objects/obj_kuriboshoe_movement/Create_0.gml
func _create() -> void:
	state = 0.0


# from objects/obj_kuriboshoe_movement/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if m.state == 1.0:
			if state == 0.0 and (GM.keyboard_check(G.izquierda) or GM.keyboard_check(G.derecha)):
				state = 1.0
				if vspeed == 0.0:
					vspeed = -1.8
					gravity = 0.3
			elif state == 1.0:
				if vspeed > 0.0 and y > (ystart - 1.0):
					vspeed = 0.0
					y = ystart
					state = 0.0
					if gravity > 0.0:
						gravity = 0.0
		elif m.state != 1.0:
			vspeed = 0.0
			y = ystart
			state = 0.0
			if gravity > 0.0:
				gravity = 0.0
	else:
		vspeed = 0.0
		y = ystart
		state = 0.0
		if gravity > 0.0:
			gravity = 0.0
