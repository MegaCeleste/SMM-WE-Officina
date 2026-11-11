# from scripts/scr_NSMBU_musicalscale_rebote/scr_NSMBU_musicalscale_rebote.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_musicalscale_rebote/scr_NSMBU_musicalscale_rebote.gml
static func scr_NSMBU_musicalscale_rebote(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	var scoreobject
	var _o: GMObject = GM.other
	scoreobject = GM.instance_create(GM.gm_round((((argument1.bbox_left + argument1.bbox_right) / 2.0) - 8.0)), GM.gm_round(argument1.y), A.obj_score)
	match argument0.hitpoint:  # UNSURE: hitpoint 由 obj_mario 声明，须为 float 才能匹配下面的浮点分支
		0.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(0)
			GM.other = _o
		1.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(1)
			GM.other = _o
		2.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(2)
			GM.other = _o
		3.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(3)
			GM.other = _o
		4.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(4)
			GM.other = _o
		5.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(5)
			GM.other = _o
		6.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_NSMBU_rebote, 0.0, false)
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(6)
			GM.other = _o
		_:
			if argument2 > 0.5:
				GM.audio_stop_sound(A.snd_NSMBU_rebote_1up)
				GM.audio_play_sound(A.snd_NSMBU_rebote_1up, 0.0, false)
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(7)
				GM.other = _o
	argument0.hitpoint += 1.0
