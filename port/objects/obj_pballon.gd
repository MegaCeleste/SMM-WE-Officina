# from objects/obj_pballon（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var timer: float = 0.0


# from objects/obj_pballon/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	match G.apariencia:
		0.0:
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_wings = A.spr_NSMBU_wings_items
	timer = 0.0
	sequence = 0.0
	swimming = 0.0
	modo_lava = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	alarm[10] = 2.0


# from objects/obj_pballon/Step_0.gml
func _step() -> void:
	if paracaidas == 1.0:
		if x > (xstart + 16.0):
			if hspeed < -0.5:
				hspeed = -0.5
			else:
				hspeed -= 0.015
		elif x < (xstart - 16.0):
			if hspeed > 0.5:
				hspeed = 0.5
			else:
				hspeed += 0.015
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif wings == 1.0:
		if not GM.instance_exists(A.obj_deadmario):
			wings_anim += 0.12
		y = (ystart + (sin((timer * 0.04375)) * 8.0))
		timer += 1.0
	else:
		y = (ystart + (sin((timer * 0.04375)) * 2.0))
		timer += 1.0
		hspeed = (maxf(0.0, (absf(hspeed) - 0.15)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.15:
			hspeed = 0.0


# from objects/obj_pballon/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
	elif paracaidas == 1.0:
		hspeed = -0.6


# from objects/obj_pballon/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup != 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_pinchos, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_muncher, true, false) != null):
		if other.holding == 2.0 and G.apariencia == 2.0:
			other.isduck = 1.0
			other.isduckhold = 1.0
		else:
			other.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	if G.powerup != Scr.scr_sprite_get_constant(self, sprite_index):
		if GM.instance_find(A.obj_mario, 0).holding != 2.0:
			for inst in GM.with_list(A.obj_mario):
				inst.holding = 0.0
		GM.instance_create(other.x, (other.y + 20.0), A.obj_mario_pballon)
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
				inst.c_powerup = 1.0
				inst.sprite_powerup = sprite_index
			GM.audio_play_sound(A.snd_pballon_item, 0.0, false)
	else:
		GM.audio_stop_sound(A.snd_powerup)
		GM.audio_play_sound(A.snd_powerup, 0.0, false)
	instance_destroy()
