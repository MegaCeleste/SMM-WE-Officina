# from objects/obj_key_appear（第 5 批移植，已核对）
extends GMObject

var sparkles: float = 0.0
var ready_v: float = 0.0
var followers: float = 0.0
var imdead = null


# from objects/obj_key_appear/Create_0.gml
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
	vspeed = -3.0
	image_speed = 0.18
	friction = 0.2175
	GM.audio_stop_sound(A.snd_key_appear)
	GM.audio_play_sound(A.snd_key_appear, 0.0, false)
	ready_v = 0.0
	followers = 2.0
	alarm[1] = 1.0


# from objects/obj_key_appear/Step_0.gml
func _step() -> void:
	if vspeed == 0.0 and ready_v == 0.0:
		if G.keys < GM.instance_number(A.obj_door_lock):
			alarm[0] = 60.0
			ready_v = 1.0
		else:
			_user_0()  # UNVERIFIED(U14): 从 Step 调用，user event 里的 other 此时是兼容层设的实例自身
	if ready_v == 2.0:
		if GM.instance_exists(A.obj_doormario):
			x = GM.instance_find(A.obj_doormario, 0).x
			y = (GM.instance_find(A.obj_doormario, 0).y + 16.0)
		elif GM.instance_exists(A.obj_player_warp):
			x = GM.instance_find(A.obj_player_warp, 0).x
			y = (GM.instance_find(A.obj_player_warp, 0).y + 16.0)
		elif GM.instance_exists(A.obj_mario):
			speed = 10.0
			move_towards_point(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 16.0), speed)


# from objects/obj_key_appear/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 2.0
	GM.audio_stop_sound(A.snd_key_go)
	GM.audio_play_sound(A.snd_key_go, 0.0, false)


# from objects/obj_key_appear/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create(((x - 3.0) + GM.random(GM.gm_round(22.0))), ((y - 3.0) + GM.random(GM.gm_round(22.0))), A.obj_smoke)):
		if G.apariencia == 0.0:
			inst.sprite_index = A.spr_SMB3_boltspark
		elif G.apariencia == 1.0:
			inst.sprite_index = A.spr_SMB3_boltspark
		elif G.apariencia == 2.0:
			inst.sprite_index = A.spr_boltspark2
		else:
			inst.sprite_index = A.spr_SMB3_boltspark
		inst.image_speed = 0.1
	alarm[1] = 8.0


# from objects/obj_key_appear/Collision_obj_doormario.gml
func _collision_obj_doormario(other: GMObject) -> void:
	if ready_v == 2.0:
		_user_1()


# from objects/obj_key_appear/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if ready_v == 2.0:
		_user_1()


# from objects/obj_key_appear/Collision_obj_player_warp.gml
func _collision_obj_player_warp(other: GMObject) -> void:
	if ready_v == 2.0:
		_user_1()


# from objects/obj_key_appear/Other_10.gml
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


# from objects/obj_key_appear/Other_11.gml
func _user_1() -> void:
	if G.keys < GM.instance_number(A.obj_door_lock):
		if GM.instance_exists(A.obj_mario):
			if G.apariencia == 3.0:
				GM.audio_play_sound(A.snd_NSMBU_getkey, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_SMB3_getkey, 0.0, false)
			for inst in GM.with_list(GM.instance_create((GM.other.x - 7.0), (y + 10.0), A.obj_smoke)):
				inst.image_speed = 0.22
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
