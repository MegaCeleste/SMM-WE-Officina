# 第 4 批移植，已核对。
extends "res://objects/obj_powerupparent.gd"

var t_mario: String = ""
var jump: float = 0.0


# from objects/obj_link/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	sprite_wings = A.spr_SMB_wings_16x16
	swimming = 0.0
	t_mario = ""
	jump = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	alarm[10] = 4.0


# from objects/obj_link/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if progresivo == 1.0 and Scr.outside_view(self) == 0.0:
		if G.powerup == 0.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_mushroom)):
				inst.wings = self.wings
				inst.paracaidas = self.paracaidas
			instance_destroy()
	if (wings == 0.0 or paracaidas == 1.0) and object_index != A.obj_propellershroom:
		_user_3()
		_user_4()
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
		if gravity == 0.0:
			GM.instance_create((x + 8.0), y, A.obj_paracaidas_go)
			paracaidas = 0.0
			ystart = (y - 32.0)
			y += 1.0
			hspeed = 0.0
			alarm[10] = 10.0
	if wings == 1.0 and paracaidas == 0.0:
		if not GM.instance_exists(A.obj_deadmario):
			if G.apariencia == 3.0:
				wings_anim += 0.5
			else:
				wings_anim += 0.12
		if y > (ystart + 16.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.085
		elif y < (ystart - 16.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.085
	if wings == 0.0:
		if gravity == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.2)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.2:
				hspeed = 0.0


# from objects/obj_link/Alarm_0.gml
func _alarm_0() -> void:
	image_speed = 0.15


# from objects/obj_link/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6


# from objects/obj_link/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup == 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_pinchos, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_muncher, true, false) != null):
		other.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
		inst.visible = false
	GM.other = _o
	GM.audio_stop_sound(A.snd_hen_powerup)
	GM.audio_stop_sound(A.snd_SMB_powerup_superflower)
	GM.audio_stop_sound(A.snd_SMB_powerup_supermushroom)
	GM.audio_stop_sound(A.snd_SMB3_powerup)
	GM.audio_stop_sound(A.snd_SMB_powerup_link)
	if G.powerup == -50.0:
		for inst in GM.with_list(A.obj_levelmanager):
			inst.mchange = 3.0
	if G.powerup == -85.0:
		GM.audio_play_sound(A.snd_SMB_link_getitem, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_SMB_powerup_link, 0.0, false)
		for inst in GM.with_list(A.obj_levelmanager):
			inst.mchange = 4.0
		G.ef_repeat = 1.0
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.link_transform = 1.0
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
				inst.c_powerup = 1.0
				inst.small = 1.0
				inst.sprite_powerup = self.sprite_index
	instance_destroy()


# from objects/obj_link/Other_17.gml
func _user_7() -> void:
	image_speed = 0.0
	image_index = 0.0
	alarm[0] = 60.0
