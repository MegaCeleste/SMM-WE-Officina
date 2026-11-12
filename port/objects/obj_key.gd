# from objects/obj_key（第 5 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var sparkles: float = 0.0
var ready_v: float = 0.0
var followers: float = 0.0
var imdead = null


# from objects/obj_key/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_key
			sparkles = A.spr_SMB3_sparkles_keys
		1.0:
			sprite_index = A.spr_SMB3_key
			sparkles = A.spr_SMB3_sparkles_keys
		2.0:
			sparkles = A.spr_sparkles_keys
		3.0:
			sprite_index = A.spr_NSMBU_key
			sparkles = A.spr_sparkles_keys
	if G.apariencia == 3.0:
		image_speed = 0.25
	else:
		image_speed = 0.18
	gravity = 0.0
	ready_v = 0.0
	followers = 2.0


# from objects/obj_key/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	var o = other
	if lm.editor == 0.0 and o.held == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_key_appear)):
			inst.vspeed = -3.0
		instance_destroy()


# from objects/obj_key/Collision_obj_link_arrow.gml
func _collision_obj_link_arrow(other: GMObject) -> void:
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_key_appear)):
			inst.vspeed = -3.0
		instance_destroy()


# from objects/obj_key/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if ready_v == 0.0:
		if G.keys < GM.instance_number(A.obj_door_lock):
			if G.apariencia == 3.0:
				GM.audio_play_sound(A.snd_NSMBU_getkey, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_SMB3_getkey, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.image_speed = 0.21
				inst.sprite_index = self.sparkles
			G.keys += 1.0
			followers = (G.keys + 1.0)
			if not GM.instance_exists(A.obj_key_fallow):
				GM.instance_create(x, y, A.obj_key_fallow)
			else:
				for inst in GM.with_list(A.obj_key_fallow):
					inst.followers = self.followers
			instance_destroy()
		else:
			_user_0()


# from objects/obj_key/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_key_appear)):
		inst.vspeed = -3.0
	instance_destroy()


# from objects/obj_key/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_key_appear)):
			inst.vspeed = -3.0
		instance_destroy()


# from objects/obj_key/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(A.snd_SMB3_key_destroy)
	GM.audio_play_sound(A.snd_SMB3_key_destroy, 0.0, false)
	imdead = GM.instance_create((x + 8.0), (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_key_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_key_deads
		2.0:
			imdead.sprite_index = A.spr_key_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_key_deads
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


# from objects/obj_key/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
