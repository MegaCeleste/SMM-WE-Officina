# 第 7 批移植，已核对。
extends "res://objects/obj_deactivation.gd"

var rotacion: float = 0.0
var mytop = null
var rot: float = 0.0  # obj_1up、obj_claw 等多处从外面写入
var up: float = 0.0
var rot_angle: float = 0.0


# from objects/obj_onewaygate_top/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_oneway
		1.0:
			sprite_index = A.spr_SMB3_oneway
		2.0:
			sprite_index = A.spr_oneway
		3.0:
			sprite_index = A.spr_NSMBU_oneway
	if G.apariencia == 3.0:
		image_speed = 0.2
	else:
		image_speed = 0.1
	rotacion = 0.0
	mytop = GM.instance_create((x - 16.0), (y - 16.0), A.obj_solidtop)
	mytop.image_xscale = 2.0
	rot = 0.0
	up = 0.0
	rot_angle = 0.0


# from objects/obj_onewaygate_top/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(mytop):
		inst.instance_destroy()


# from objects/obj_onewaygate_top/Step_2.gml
func _step_end() -> void:
	var solidoneway
	if GM.instance_exists(A.obj_mario):
		# PORT: 块体里调用了 event_user，按 port-plan 第 17 条维护 GM.other（外层 with: other = 本实例；内层 with: other = 当前 obj_mario）
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			solidoneway = inst.collision_rectangle(inst.bbox_left, inst.bbox_bottom, inst.bbox_right, (inst.bbox_bottom + inst.vspeed), mytop, false, false)  # GML: other.mytop
			if solidoneway != null and inst.vspeed > 0.0 and inst.bbox_bottom < (solidoneway.yprevious + 5.0) and (inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 4.0), inst.bbox_right, (solidoneway.y - 1.0), A.obj_solid, true, false) == null):
				GM.other = inst
				for inst2 in GM.with_list(self):  # GML: with (other.id)
					inst2.rot = 1.0
					inst2._user_0()
				GM.other = self
		GM.other = _o
	if rot == 1.0:
		if up == 0.0:
			if rotacion > (rot_angle - 5.0):
				rotacion -= 1.0
			else:
				up = 1.0
		if up == 1.0:
			if rotacion < (rot_angle + 5.0):
				rotacion += 1.0
			else:
				up = 2.0
		elif up == 2.0:
			if rotacion > rot_angle:
				rotacion -= 1.0
			else:
				up = 0.0
				rot = 0.0
	else:
		rotacion = rot_angle


# from objects/obj_onewaygate_top/Other_10.gml
func _user_0() -> void:
	if not GM.audio_is_playing(Scr.scr_snd_oneway(self)):
		GM.audio_play_sound(Scr.scr_snd_oneway(self), 0.0, false)


# from objects/obj_onewaygate_top/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
