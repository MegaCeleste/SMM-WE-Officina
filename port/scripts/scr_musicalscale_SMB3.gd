extends RefCounted


# from scripts/scr_musicalscale_SMB3/scr_musicalscale_SMB3.gml
static func scr_musicalscale_SMB3(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	var scoreobject
	scoreobject = GM.instance_create(GM.gm_round((((argument1.bbox_left + argument1.bbox_right) / 2.0) - 8.0)), GM.gm_round(argument1.y), A.obj_score)
	match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
		0.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(0)
			GM.other = _o
		1.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o2: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(1)
			GM.other = _o2
		2.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o3: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(2)
			GM.other = _o3
		3.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o4: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(3)
			GM.other = _o4
		4.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o5: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(4)
			GM.other = _o5
		5.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o6: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(5)
			GM.other = _o6
		6.0:
			if argument2 > 0.5:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o7: GMObject = GM.other
			GM.other = me
			for inst in GM.with_list(scoreobject):
				inst.event_user(6)
			GM.other = _o7
		_:
			if argument2 > 0.5:
				GM.audio_stop_sound(A.snd_SMB3_1up)
				GM.audio_play_sound(A.snd_SMB3_1up, 0.0, false)
				var _o8: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(7)
				GM.other = _o8
