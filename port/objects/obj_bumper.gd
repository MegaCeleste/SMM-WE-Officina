# 第 7 批移植，已核对。
extends "res://objects/obj_deactivation.gd"

var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名），同 obj_thwomp 的改名
var scale: float = 0.0


# from objects/obj_bumper/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bumper
		1.0:
			sprite_index = A.spr_SMB3_bumper
		2.0:
			sprite_index = A.spr_bumper
		3.0:
			sprite_index = A.spr_NSMBU_bumper
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	scale = 1.0
	alarm[0] = 120.0


# from objects/obj_bumper/Step_0.gml
func _step() -> void:
	depth = -7.0
	if ready_v == 1.0:
		scale += 0.04
		if scale > 1.3:
			ready_v = 2.0
	elif ready_v == 2.0:
		scale -= 0.04
		if scale < 1.0:
			scale = 1.0
			ready_v = 0.0


# from objects/obj_bumper/Alarm_0.gml
func _alarm_0() -> void:
	if image_index == 0.0:
		image_index = 1.0
		alarm[0] = 10.0
	else:
		image_index = 0.0
		alarm[0] = (120.0 + GM.random(GM.gm_round(120.0)))


# from objects/obj_bumper/Collision_obj_clown.gml
func _collision_obj_clown(other: GMObject) -> void:
	if ready_v == 0.0:
		if G.apariencia == 0.0 or G.apariencia == 1.0:
			GM.audio_play_sound(A.snd_SMB3_bumper1, 0.0, false)
		elif G.apariencia == 2.0:
			GM.audio_play_sound(A.snd_bumper1, 0.0, false)
		ready_v = 1.0
	for inst in GM.with_list(other):
		if inst.rot == 0.0:
			inst.rot = 1.0
	other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, other.y))
	if (other.y + 16.0) < (y - 12.0):
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			other.vspeed = -0.5
		else:
			other.vspeed = -1.3
	elif G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
		other.vspeed = 1.5
	else:
		other.vspeed = 3.5


# from objects/obj_bumper/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if ready_v == 0.0:
		if G.apariencia < 2.0:
			GM.audio_play_sound(A.snd_SMB3_bumper1, 0.0, false)
		elif G.apariencia == 2.0:
			GM.audio_play_sound(A.snd_bumper1, 0.0, false)
		elif G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_NSMBU_bumper1, 0.0, false)
		ready_v = 1.0
	other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, (other.y + 16.0)))
	if (other.y + 16.0) < (y - 12.0):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o
		if GM.keyboard_check(G.saltar) or GM.keyboard_check(G.saltar_spin):
			if G.apariencia < 2.0:
				GM.audio_stop_sound(A.snd_SMB3_bumper1)
				GM.audio_play_sound(A.snd_SMB3_bumper2, 0.0, false)
			elif G.apariencia == 2.0:
				GM.audio_stop_sound(A.snd_bumper1)
				GM.audio_play_sound(A.snd_bumper2, 0.0, false)
			elif G.apariencia == 3.0:
				GM.audio_stop_sound(A.snd_NSMBU_bumper1)
				GM.audio_play_sound(A.snd_NSMBU_bumper2, 0.0, false)
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			other.vspeed = -2.125
		else:
			other.vspeed = -5.0
	elif G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
		other.vspeed = 1.125
	else:
		other.vspeed = 3.125


# from objects/obj_bumper/Draw_0.gml
func _gm_draw() -> void:
	if ready_v > 0.0:
		GM.draw_sprite_ext(sprite_index, 2.0, GM.gm_round(x), GM.gm_round(y), scale, scale, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, 0.0, GM.c_white, 1.0)
