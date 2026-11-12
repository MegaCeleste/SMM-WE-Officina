# from objects/obj_hen_mushroom（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var t_mario: String = ""
var jump: float = 0.0


# from objects/obj_hen_mushroom/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
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


# from objects/obj_hen_mushroom/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			if hspeed > 1.0:
				hspeed -= 0.08
				if hspeed <= 1.0:
					hspeed = 1.0
			elif hspeed < -1.0:
				hspeed += 0.08
				if hspeed >= -1.0:
					hspeed = -1.0
		elif hspeed > 1.1:
			hspeed -= 0.08
			if hspeed <= 1.1:
				hspeed = 1.1
		elif hspeed < -1.1:
			hspeed += 0.08
			if hspeed >= -1.1:
				hspeed = -1.1


# from objects/obj_hen_mushroom/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	if paracaidas == 0.0:
		hspeed = (1.0 - (0.5 * swimming))


# from objects/obj_hen_mushroom/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0) and (not place_meeting(x, (y - 16.0), A.obj_solid)) and wings == 0.0:
		vspeed = -3.0
		if hspeed == 0.0:
			hspeed = 1.0
		elif (x + (sprite_width / 2.0)) > (other.x + (sprite_width / 2.0)):
			hspeed = 1.0
		elif (x + (sprite_width / 2.0)) < (other.x + (sprite_width / 2.0)):
			hspeed = -1.0


# from objects/obj_hen_mushroom/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup == 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_pinchos, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_muncher, true, false) != null):
		other.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	GM.audio_stop_sound(A.snd_hen_powerup)
	GM.audio_stop_sound(A.snd_SMB_powerup_superflower)
	GM.audio_stop_sound(A.snd_SMB_powerup_supermushroom)
	GM.audio_stop_sound(A.snd_SMB3_powerup)
	if G.powerup == -50.0:
		for inst in GM.with_list(A.obj_levelmanager):
			inst.mchange = 3.0
	if G.powerup == -78.0:
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	else:
		GM.audio_play_sound(A.snd_hen_powerup, 0.0, false)
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
				inst.c_powerup = 1.0
				inst.small = 1.0
				inst.sprite_powerup = sprite_index
	instance_destroy()
