# from objects/obj_star（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"


# from objects/obj_star/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_star
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_star
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_star
			sprite_wings = A.spr_NSMBU_wings_items
	swimming = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	image_speed = 0.3
	alarm[10] = 2.0


# from objects/obj_star/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			if hspeed > 0.5:
				hspeed -= 0.08
				if hspeed <= 0.5:
					hspeed = 0.5
			elif hspeed < -0.5:
				hspeed += 0.08
				if hspeed >= -0.5:
					hspeed = -0.5
		elif hspeed > 1.0:
			hspeed -= 0.08
			if hspeed <= 1.0:
				hspeed = 1.0
		elif hspeed < -1.0:
			hspeed += 0.08
			if hspeed >= -1.0:
				hspeed = -1.0
		if gravity == 0.0:
			if G.modo_noche == 1.0:
				vspeed = -5.125
			else:
				vspeed = -4.0
		elif not GM.instance_exists(A.obj_deadmario):
			gravity = 0.125


# from objects/obj_star/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	elif paracaidas == 0.0:
		hspeed = (1.0 - (0.5 * swimming))


# from objects/obj_star/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	if GM.instance_exists(A.obj_invincibility):
		for inst in GM.with_list(A.obj_invincibility):
			inst.alarm[0] = 600.0
	else:
		GM.instance_create(x, y, A.obj_invincibility)
		if GM.instance_find(A.obj_levelmanager, 0).switchon == 0.0:
			GM.audio_play_sound(Scr.scr_snd_starman(self), 99.0, true)
		for inst in GM.with_list(A.obj_levelmanager):
			inst.alarm[1] = 1.0
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_get_start1)
		GM.audio_stop_sound(A.snd_NSMBU_get_start2)
		GM.audio_play_sound(GM.choose(A.snd_NSMBU_get_start1, A.snd_NSMBU_get_start2), 0.0, false)
	instance_destroy()
