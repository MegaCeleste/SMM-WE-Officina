# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_step_sounds/scr_step_sounds.gml
static func scr_step_sounds(me: GMObject, argument0 = null, argument1 = null):
	match argument0:
		0.0:
			if argument1 == 0.0:
				GM.audio_play_sound(A.snd_NSMBU_step_normal1, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_NSMBU_step_normal2, 0.0, false)
		1.0:
			if argument1 == 0.0:
				GM.audio_play_sound(A.snd_NSMBU_step_block1, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_NSMBU_step_block2, 0.0, false)
		2.0:
			if argument1 == 0.0:
				GM.audio_play_sound(A.snd_NSMBU_step_airship, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_NSMBU_step_airship2, 0.0, false)
