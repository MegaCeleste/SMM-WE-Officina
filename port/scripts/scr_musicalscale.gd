extends RefCounted


# from scripts/scr_musicalscale/scr_musicalscale.gml
static func scr_musicalscale(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	var scoreobject = GM.instance_create(GM.gm_round((((argument1.bbox_left + argument1.bbox_right) / 2.0) - 8.0)), GM.gm_round(argument1.y), A.obj_score)
	if G.apariencia == 0.0:
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o
			1.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o2: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o2
			2.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o3: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o3
			3.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o4: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o4
			4.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o5: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o5
			5.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o6: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o6
			6.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o7: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o7
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(A.snd_step_enemy_1up)
					GM.audio_play_sound(A.snd_step_enemy_1up, 0.0, false)
					var _o8: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o8
	elif G.apariencia == 1.0:
		if argument0.hitpoint < 7.0:
			if argument1.object_index == A.obj_bobomb or argument1.object_index == A.obj_bobomb_ready:
				GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				var _o9: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o9
			1.0:
				var _o10: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o10
			2.0:
				var _o11: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o11
			3.0:
				var _o12: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o12
			4.0:
				var _o13: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o13
			5.0:
				var _o14: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o14
			6.0:
				var _o15: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o15
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(A.snd_step_enemy_1up)
					GM.audio_play_sound(A.snd_step_enemy_1up, 0.0, false)
					var _o16: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o16
	elif G.apariencia == 2.0:
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick, 0.0, false)
				var _o17: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o17
			1.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick2, 0.0, false)
				var _o18: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o18
			2.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick3, 0.0, false)
				var _o19: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o19
			3.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick4, 0.0, false)
				var _o20: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o20
			4.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick5, 0.0, false)
				var _o21: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o21
			5.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick6, 0.0, false)
				var _o22: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o22
			6.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_kick7, 0.0, false)
				var _o23: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o23
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(A.snd_kick_1up)
					GM.audio_play_sound(A.snd_kick_1up, 0.0, false)
					var _o24: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o24
	elif G.apariencia == 3.0:
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o25: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o25
			1.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o26: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o26
			2.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o27: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o27
			3.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o28: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o28
			4.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o29: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o29
			5.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o30: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o30
			6.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
				var _o31: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o31
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(A.snd_NSMBU_kick_jump)
					GM.audio_play_sound(A.snd_NSMBU_kick_jump, 0.0, false)
					GM.audio_stop_sound(A.snd_NSMBU_1up_original)
					GM.audio_play_sound(A.snd_NSMBU_1up_original, 0.0, false)
					var _o32: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o32
	else:
		match argument0.hitpoint:  # hitpoint 为 float（各 object 里都是数值）
			0.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o33: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(0)
				GM.other = _o33
			1.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o34: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(1)
				GM.other = _o34
			2.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o35: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(2)
				GM.other = _o35
			3.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o36: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(3)
				GM.other = _o36
			4.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o37: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(4)
				GM.other = _o37
			5.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o38: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(5)
				GM.other = _o38
			6.0:
				if argument2 > 0.5:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				var _o39: GMObject = GM.other
				GM.other = me
				for inst in GM.with_list(scoreobject):
					inst.event_user(6)
				GM.other = _o39
			_:
				if argument2 > 0.5:
					GM.audio_stop_sound(A.snd_step_enemy_1up)
					GM.audio_play_sound(A.snd_step_enemy_1up, 0.0, false)
					var _o40: GMObject = GM.other
					GM.other = me
					for inst in GM.with_list(scoreobject):
						inst.event_user(7)
					GM.other = _o40
	argument0.hitpoint += 1.0
