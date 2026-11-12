# from objects/obj_frogsuit（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"


# from objects/obj_frogsuit/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.0
	image_index = 0.0
	alarm[10] = 2.0


# from objects/obj_frogsuit/Step_0.gml
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
				vspeed = -4.125
			else:
				vspeed = -3.0
			y -= 1.0
		elif not GM.instance_exists(A.obj_deadmario):
			gravity = 0.125


# from objects/obj_frogsuit/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	if paracaidas == 0.0:
		hspeed = (1.0 - (0.5 * swimming))


# from objects/obj_frogsuit/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup == 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_pinchos, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_muncher, true, false) != null):
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
		if G.powerup == 0.0:
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.sprite_powerup = sprite_index
				GM.audio_stop_sound(A.snd_changeleaf)
				GM.audio_play_sound(A.snd_changeleaf, 0.0, false)
		elif GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
				inst.c_powerup = 1.0
				inst.sprite_powerup = sprite_index
			GM.audio_stop_sound(A.snd_changeleaf)
			GM.audio_play_sound(A.snd_changeleaf, 0.0, false)
	else:
		GM.audio_stop_sound(Scr.scr_snd_powerup(self))
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	instance_destroy()
