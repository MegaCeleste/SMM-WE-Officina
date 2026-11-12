extends "res://objects/obj_platform_parent.gd"

var sprite: int = 0  ## sprite 编号
var index: float = 0.0
var size_x: float = 0.0
var direct_t: float = 0.0
var h: float = 0.0


# from objects/obj_plataforma/Create_0.gml
func _create() -> void:
	sprite = A.spr_platform
	index = 0.0
	size_x = 4.0
	image_speed = 0.0
	direct_t = 0.0
	alarm[0] = 1.0


# from objects/obj_plataforma/Step_0.gml
func _step() -> void:
	if direct_t == 0.0 or direct_t == 2.0:
		if y > (ystart + 32.0) or y < (ystart - 32.0):
			vspeed = (-vspeed)
	elif x > (xstart + 48.0) or x < (xstart - 48.0):
		hspeed = (-hspeed)


# from objects/obj_plataforma/Alarm_0.gml
func _alarm_0() -> void:
	match direct_t:
		0.0:
			vspeed = 0.6
		1.0:
			hspeed = 0.6
		2.0:
			vspeed = -0.6
		3.0:
			hspeed = -0.6


# from objects/obj_plataforma/Alarm_1.gml
func _alarm_1() -> void:
	match direct_t:
		0.0:
			vspeed = -0.6
		1.0:
			hspeed = -0.6
		2.0:
			vspeed = 0.6
		3.0:
			hspeed = 0.6
	alarm[0] = 160.0


# from objects/obj_plataforma/Draw_0.gml
func _gm_draw() -> void:
	h = 0.0
	while h < size_x:
		if h == 0.0:
			index = 0.0
		elif h == (size_x - 1.0):
			index = 2.0
		else:
			index = 1.0
		GM.draw_sprite(sprite, index, (x + (h * 16.0)), y)
		h += 1.0
