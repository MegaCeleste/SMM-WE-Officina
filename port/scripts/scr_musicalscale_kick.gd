extends RefCounted


# from scripts/scr_musicalscale_kick/scr_musicalscale_kick.gml
static func scr_musicalscale_kick(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	var kick  # 局部变量提升（GML 的 var 是函数作用域）
	var kick_1up  # 局部变量提升（GML 的 var 是函数作用域）
	var scoreobject = GM.instance_create(GM.gm_round((((argument1.bbox_left + argument1.bbox_right) / 2.0) - 8.0)), GM.gm_round(argument1.y), A.obj_score)
	match G.apariencia:
		0.0:
			kick = A.snd_SMB3_kick
			kick_1up = A.snd_step_enemy_1up
		1.0:
			kick = A.snd_SMB3_kick
			kick_1up = A.snd_step_enemy_1up
		2.0:
			kick = A.snd_kick
			kick_1up = A.snd_kick_1up
	if G.apariencia == 3.0:
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_1, 0.0, false)
				var _o: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o
			1.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_2, 0.0, false)
				var _o2: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o2
			2.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_3, 0.0, false)
				var _o3: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o3
			3.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_4, 0.0, false)
				var _o4: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o4
			4.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_5, 0.0, false)
				var _o5: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o5
			5.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_6, 0.0, false)
				var _o6: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o6
			6.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_7, 0.0, false)
				var _o7: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o7
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(A.snd_NSMBU_kick_1up)
					GM.audio_play_sound(A.snd_NSMBU_kick_1up, 0.0, false)
					var _o8: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o8
	else:
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o9: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o9
			1.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o10: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o10
			2.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o11: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o11
			3.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o12: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o12
			4.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o13: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o13
			5.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o14: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o14
			6.0:
				if argument2 > 0.5:
					GM.audio_play_sound(kick, 0.0, false)
				var _o15: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o15
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(kick_1up)
					GM.audio_play_sound(kick_1up, 0.0, false)
					var _o16: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o16
	argument0.hitpoint += 1.0
