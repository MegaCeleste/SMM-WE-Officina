extends "res://objects/obj_deactivation.gd"

var type: float = 0.0
var size_x = null
var size_y = null
var sprite = null
var index = null
var solidtop = null
var v = null
var h = null
var p = null
var t = null


# from objects/obj_modelsizable/Create_0.gml
func _create() -> void:
	type = 0.0
	size_x = 3.0
	size_y = 3.0
	sprite = 0.0
	index = 0.0
	solidtop = A.obj_lighting
	alarm[0] = 1.0


# from objects/obj_modelsizable/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(solidtop, A.obj_lighting) and GM.instance_exists(solidtop):
		var _with_target2 = solidtop
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			inst.instance_destroy()
		GM.other = _other1


# from objects/obj_modelsizable/Alarm_0.gml
func _alarm_0() -> void:
	solidtop = GM.instance_create(x, y, A.obj_solidtop)
	solidtop.image_xscale = image_xscale


# from objects/obj_modelsizable/Alarm_1.gml
func _alarm_1() -> void:
	mask_index = sprite


# from objects/obj_modelsizable/Other_10.gml
func _user_0() -> void:
	var m1 = 3.0
	var m2 = 4.0
	var m3 = 5.0
	v = 0.0
	while v < size_y:
		h = 0.0
		while h < size_x:
			if v == 0.0:
				if h == 0.0:
					index = 0.0
				elif h == (size_x - 1.0):
					index = 2.0
				else:
					index = 1.0
			elif v == (size_y - 1.0):
				if h == 0.0:
					index = 9.0
				elif h == (size_x - 1.0):
					index = 11.0
				else:
					index = 10.0
			elif h == 0.0:
				index = m1
			elif h == (size_x - 1.0):
				index = m3
			else:
				index = m2
			GM.draw_sprite(sprite, index, (x + (h * 16.0)), (y + (v * 16.0)))
			if m1 == 3.0:
				m1 = 6.0
			else:
				m1 = 3.0
			if m2 == 4.0:
				m2 = 7.0
			else:
				m2 = 4.0
			if m3 == 5.0:
				m3 = 8.0
			else:
				m3 = 5.0
			h += 1.0
		if m1 == 3.0:
			m1 = 6.0
		else:
			m1 = 3.0
		if m2 == 4.0:
			m2 = 7.0
		else:
			m2 = 4.0
		if m3 == 5.0:
			m3 = 8.0
		else:
			m3 = 5.0
		v += 1.0
	alarm[1] = 1.0


# from objects/obj_modelsizable/Other_11.gml
func _user_1() -> void:
	p = 0.0
	while p < size_x:
		if p == 0.0:
			index = 0.0
		elif p == (size_x - 1.0):
			index = 2.0
		else:
			index = 1.0
		GM.draw_sprite(sprite, index, (x + (p * 16.0)), y)
		p += 1.0
	t = 1.0
	while t < size_y:
		if size_y == 3.0 or size_y == 5.0 or size_y == 7.0 or size_y == 9.0 or size_y == 7.0 or size_y == 11.0 or size_y == 13.0 or size_y == 15.0 or size_y == 17.0 or size_y == 19.0:
			if t == 1.0:
				GM.draw_sprite(sprite, 3.0, ((x + ((size_x * 16.0) / 2.0)) - 8.0), (y + (t * 16.0)))
			else:
				GM.draw_sprite(sprite, 6.0, ((x + ((size_x * 16.0) / 2.0)) - 8.0), (y + (t * 16.0)))
		elif t == 1.0:
			GM.draw_sprite(sprite, 4.0, ((x + ((size_x * 16.0) / 2.0)) - 16.0), (y + (t * 16.0)))
			GM.draw_sprite(sprite, 5.0, (x + ((size_x * 16.0) / 2.0)), (y + (t * 16.0)))
		else:
			GM.draw_sprite(sprite, 7.0, ((x + ((size_x * 16.0) / 2.0)) - 16.0), (y + (t * 16.0)))
			GM.draw_sprite(sprite, 8.0, (x + ((size_x * 16.0) / 2.0)), (y + (t * 16.0)))
		t += 1.0
	alarm[1] = 1.0


# from objects/obj_modelsizable/Other_12.gml
func _user_2() -> void:
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
	alarm[1] = 1.0


# from objects/obj_modelsizable/Draw_0.gml
func _gm_draw() -> void:
	event_user(int(type))
