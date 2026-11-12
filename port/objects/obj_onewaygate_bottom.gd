# 第 7 批移植，已核对。
extends "res://objects/obj_deactivation.gd"

var rotacion: float = 0.0
var rot: float = 0.0  # obj_1up、obj_claw、obj_muncher 等多处从外面写入
var up: float = 0.0
var rot_angle: float = 0.0


# from objects/obj_onewaygate_bottom/Create_0.gml
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
	rot = 0.0
	up = 0.0
	rot_angle = 0.0


# from objects/obj_onewaygate_bottom/Step_2.gml
func _step_end() -> void:
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


# from objects/obj_onewaygate_bottom/Other_10.gml
func _user_0() -> void:
	if not GM.audio_is_playing(Scr.scr_snd_oneway(self)):
		GM.audio_play_sound(Scr.scr_snd_oneway(self), 0.0, false)


# from objects/obj_onewaygate_bottom/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
