# from objects/obj_boomerang（第 5 批移植，已核对）
extends GMObject

var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var ready2: float = 0.0
var ready3: float = 0.0
var parent = null  # 由 obj_boomerangbro 写入（instance，原文 other.id）；Create 里先置 -1
var type_rotation: float = 0.0
var rotacion: float = 0.0
var delito: float = 0.0
var xscale: float = 0.0
var yscale: float = 0.0
var direct = null


# from objects/obj_boomerang/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_boomerang
		1.0:
			sprite_index = A.spr_SMB3_boomerang
		2.0:
			sprite_index = A.spr_boomerang
		3.0:
			sprite_index = A.spr_NSMBU_boomerang
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	parent = -1
	type_rotation = 0.0
	rotacion = 0.0
	delito = 0.0
	xscale = 1.0
	yscale = 1.0
	alarm[0] = 32.0
	vspeed = -0.75
	alarm[3] = 360.0
	alarm[4] = 480.0


# from objects/obj_boomerang/Step_0.gml
func _step() -> void:
	if type_rotation == 0.0:
		rotacion -= 10.0
	else:
		rotacion += 10.0
	if delito == 1.0:
		if xscale <= 0.2:
			instance_destroy()
		else:
			xscale -= 0.2
			yscale -= 0.2
	if ready_v != 0.0:
		if ready_v == 1.0:
			if hspeed > -2.0:
				hspeed += -0.075
			else:
				hspeed = -2.0
				vspeed = 0.0
				ready_v = 0.0
				ready2 = 1.0
				ready3 = 1.0
		elif ready_v == -1.0:
			if hspeed < 2.0:
				hspeed += 0.075
			else:
				hspeed = 2.0
				vspeed = 0.0
				ready_v = 0.0
				ready2 = 1.0
				ready3 = 1.0
	if ready2 != 0.0:
		if ready2 == 1.0:
			if vspeed > 0.0:
				vspeed += -0.05
			elif vspeed < 0.0:
				vspeed += 0.05
			else:
				vspeed = 0.0
		elif ready2 == 2.0:
			if vspeed < 0.75:
				vspeed += 0.05
			else:
				vspeed = 0.75
	if Scr.outside_view(self) > 0.5:
		instance_destroy()
	elif ready3 > 0.5 and delito == 0.0 and collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, parent, false, true) != null:
		delito = 1.0


# from objects/obj_boomerang/Alarm_0.gml
func _alarm_0() -> void:
	ready2 = 1.0
	alarm[1] = 15.0


# from objects/obj_boomerang/Alarm_1.gml
func _alarm_1() -> void:
	ready2 = 2.0
	alarm[2] = 8.0


# from objects/obj_boomerang/Alarm_2.gml
func _alarm_2() -> void:
	if hspeed > 0.0:
		ready_v = 1.0
	elif hspeed < 0.0:
		ready_v = -1.0


# from objects/obj_boomerang/Alarm_3.gml
func _alarm_3() -> void:
	if image_alpha == 1.0:
		image_alpha = 0.0
	else:
		image_alpha = 1.0
	alarm[3] = 7.0


# from objects/obj_boomerang/Alarm_4.gml
func _alarm_4() -> void:
	instance_destroy()


# from objects/obj_boomerang/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_boomerang/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, rotacion, GM.c_white, 1.0)
