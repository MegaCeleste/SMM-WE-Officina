extends "res://objects/obj_bowser_dead_castle.gd"


# from objects/obj_bowserjr_dead_castle/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bowserjr_walk
		1.0:
			sprite_index = A.spr_SMB3_bowserjr_walk
		2.0:
			sprite_index = A.spr_bowserjr_walk
		3.0:
			sprite_index = A.spr_NSMBU_bowserjr_walk
	if G.apariencia == 3.0:
		image_speed = 1.0
		GM.audio_stop_sound(A.snd_NSMBU_bowser_castle1)
		GM.audio_play_sound(A.snd_NSMBU_bowser_castle1, 0.0, false)
	else:
		image_speed = 0.15


# from objects/obj_bowserjr_dead_castle/Alarm_1.gml
func _alarm_1() -> void:
	gravity = 0.2
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB_bowser_dead)
			GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB_bowser_dead)
			GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_enemy_fall_castle)
			GM.audio_play_sound(A.snd_enemy_fall_castle, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_bowser_castle2)
			GM.audio_play_sound(A.snd_NSMBU_bowser_castle2, 0.0, false)
