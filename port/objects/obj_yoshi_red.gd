# 第 4 批移植，已核对。
extends "res://objects/obj_yoshi2.gd"


# from objects/obj_yoshi_red/Create_0.gml
func _create() -> void:
	super._create()
	color = 1.0
	s_yoshi_jump = A.spr_yoshi_jump_red
	s_yoshi_swallow = A.spr_yoshi_swallow_red
	s_yoshi_lick = A.spr_yoshi_lick_red
	s_yoshi_fm_wait = A.spr_yoshi_fm_wait_red
	s_yoshi_wait = A.spr_yoshi_wait_red
	s_yoshi_fm = A.spr_yoshi_fm_red
	s_yoshi = A.spr_yoshi_red
	s_yoshi_fm_jump = A.spr_yoshi_fm_jump_red


# from objects/obj_yoshi_red/Other_10.gml
func _user_0() -> void:
	var mario = GM.instance_find(A.obj_mario, 0)
	if mario.isduck == 1.0:
		locked = 2.0
		if G.powerup != 2.0:
			if GM.instance_number(A.obj_yoshifire_one) < 1:
				mouthholder = A.obj_yoshifire
				mouthsprite = A.spr_podoboo
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_one)
				mouthholder = null
				mouthsprite = null
				licking = 1.0
				alarm[2] = 8.0
				anim = 0.0
		elif GM.instance_number(A.obj_yoshifire) < 3:
			mouthholder = A.obj_yoshifire
			mouthsprite = A.spr_podoboo
			GM.audio_play_sound(A.snd_flames, 0.0, false)
			GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)
			for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
				inst.alarm[2] = 4.0
			for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
				inst.alarm[1] = 4.0
			mouthholder = null
			mouthsprite = null
			licking = 1.0
			alarm[2] = 8.0
			anim = 0.0
	else:
		locked = 1.0
		if G.powerup != 2.0:
			if GM.instance_number(A.obj_yoshifire_one) < 1:
				mouthholder = A.obj_yoshifire
				mouthsprite = A.spr_podoboo
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_one)
				mouthholder = null
				mouthsprite = null
				licking = 1.0
				alarm[2] = 8.0
				anim = 0.0
		elif GM.instance_number(A.obj_yoshifire) < 3:
			mouthholder = A.obj_yoshifire
			mouthsprite = A.spr_podoboo
			GM.audio_play_sound(A.snd_flames, 0.0, false)
			GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)
			for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
				inst.alarm[2] = 4.0
			for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
				inst.alarm[1] = 4.0
			mouthholder = null
			mouthsprite = null
			licking = 1.0
			alarm[2] = 8.0
			anim = 0.0
