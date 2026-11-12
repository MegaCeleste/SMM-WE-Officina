# 第 4 批移植，已核对。
extends "res://objects/obj_physicsparent.gd"

var canpick: float = 0.0
var dir = null
var bota: float = 0.0


# from objects/obj_getshoe/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	canpick = 1.0
	dir = 1.0
	bota = 1.0
	if G.apariencia == 0.0:
		if bota == 2.0:
			sprite_index = A.spr_SMB_kuriboshoe2
		else:
			sprite_index = A.spr_SMB_kuriboshoe
	elif bota == 2.0:
		sprite_index = A.spr_kuriboshoe2
	alarm[1] = 600.0
	alarm[2] = 780.0


# from objects/obj_getshoe/Step_0.gml
func _step() -> void:
	super._step()
	if bota == 2.0:
		if G.apariencia == 0.0:
			sprite_index = A.spr_SMB_kuriboshoe2
		else:
			sprite_index = A.spr_kuriboshoe2
	if gravity == 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.1:
			hspeed = 0.0


# from objects/obj_getshoe/Alarm_0.gml
func _alarm_0() -> void:
	canpick = 1.0


# from objects/obj_getshoe/Alarm_1.gml
func _alarm_1() -> void:
	if image_alpha == 1.0:
		image_alpha = 0.0
	else:
		image_alpha = 1.0
	alarm[1] = 6.0


# from objects/obj_getshoe/Alarm_2.gml
func _alarm_2() -> void:
	instance_destroy()


# from objects/obj_getshoe/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if o.bbox_bottom < ((bbox_top - vspeed) + 5.0) and o.vspeed > 0.0 and o.holding == 0.0 and o.state == 2.0:
		_user_1()


# from objects/obj_getshoe/Other_11.gml
func _user_1() -> void:
	var m = GM.instance_find(A.obj_mario, 0)
	if m.holding == 0.0 and m.visible == true:
		x = m.x
		y = (m.y + 16.0)
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 3.0
		GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
		if sprite_index == A.spr_SMB_kuriboshoe2 or sprite_index == A.spr_kuriboshoe2:
			GM.instance_create(m.x, m.y, A.obj_kuriboshoe2)
		else:
			GM.instance_create(m.x, m.y, A.obj_kuriboshoe)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.dash_atack = 0.0
			inst.dash_cont = 0.0
			inst.arrow = 0.0
			inst.arrow_ready = 0.0
			inst.event_user(15)
		GM.other = _o
		instance_destroy()


# from objects/obj_getshoe/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y), dir, 1.0, 0.0, GM.c_white, image_alpha)
