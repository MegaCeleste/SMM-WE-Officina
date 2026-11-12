# from objects/obj_cannon_red（第 6c 批移植，已核对）
extends "res://objects/obj_cannon.gd"


# from objects/obj_cannon_red/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_cannon_red
		1.0:
			sprite_index = A.spr_SMB3_cannon_red
		3.0:
			sprite_index = A.spr_NSMBU_cannon_red
	sprite_anim = A.spr_NSMBU_cannon_red_anim


# from objects/obj_cannon_red/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.instance_exists(A.obj_mario):
		alarm[0] = 1.0
		return
	GM.audio_stop_sound(Scr.scr_snd_explode(self))
	GM.audio_play_sound(Scr.scr_snd_explode(self), 0.0, false)
	if G.apariencia == 3.0:
		anim_shoot = 1.0
	if G.apariencia == 3.0:
		for inst in GM.with_list(GM.instance_create(((x + 8.0) + GM.lengthdir_x(8.0, direct)), ((y + 8.0) + GM.lengthdir_y(8.0, direction)), A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_cannon_smoke
			inst.image_speed = 0.5
			inst.image_angle = self.direct
			inst.depth = -7.0
	for inst in GM.with_list(GM.instance_create(((x + 8.0) + GM.lengthdir_x(8.0, direct)), ((y + 8.0) + GM.lengthdir_y(8.0, direction)), A.obj_cannonball_red)):
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and inst.y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			inst.motion_set(self.direct, 1.0)
		else:
			inst.motion_set(self.direct, 2.0)
	alarm[0] = 192.0


# from objects/obj_cannon_red/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create((x + 8.0), (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	if G.apariencia == 0.0:
		imdead.sprite_index = A.spr_SMB_cannon_deads
	elif G.apariencia == 1.0:
		imdead.sprite_index = A.spr_SMB3_cannon_deads
	elif G.apariencia == 2.0:
		imdead.sprite_index = A.spr_cannon_deads
	imdead.image_index = 2.0
	imdead.image_speed = 0.0
	if direct == 0.0 or direct == 45.0 or direct == 90.0 or direct == 315.0:
		imdead.direct = 1.0
	else:
		imdead.direct = -1.0
	# ORIG-BUG: other.bbox_left + (bbox_right / 2) 中 bbox_right 是自身的而不是 other 的，other/self 混用，照搬
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()
