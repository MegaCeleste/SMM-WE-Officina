extends "res://objects/obj_enemy_dead_castle.gd"


# from objects/obj_bowser_dead_castle/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			alarm[2] = 1.0
		modo_lava = 1.0
	if not GM.instance_exists(A.obj_deadmario):
		if modo_lava == 1.0 and gravity != 0.0:
			gravity = 0.1
			if vspeed > 1.5:
				vspeed = 1.5
		elif modo_lava == 0.0 and gravity != 0.0:
			gravity = 0.2
			if vspeed > 3.0:
				vspeed = 3.0
	if y > (GM.room_height + 248.0) or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_bowser_dead_castle/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bowse_fire
		1.0:
			sprite_index = A.spr_SMB3_bowser_dead
		2.0:
			sprite_index = A.spr_bowser_walk
		3.0:
			sprite_index = A.spr_NSMBU_bowser_dead
	if G.apariencia == 3.0:
		image_speed = 1.0
		GM.audio_stop_sound(A.snd_NSMBU_bowser_castle1)
		GM.audio_play_sound(A.snd_NSMBU_bowser_castle1, 0.0, false)
	else:
		image_speed = 0.15


# from objects/obj_bowser_dead_castle/Alarm_1.gml
func _alarm_1() -> void:
	gravity = 0.2
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB_bowser_dead)
			GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_bowser_dead)
			GM.audio_play_sound(A.snd_SMB3_bowser_dead, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_bowser_dead)
			GM.audio_play_sound(A.snd_bowser_dead, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_bowser_castle2)
			GM.audio_play_sound(A.snd_NSMBU_bowser_castle2, 0.0, false)
			GM.audio_stop_sound(A.snd_NSMBU_bowser_dead)
			GM.audio_play_sound(A.snd_NSMBU_bowser_dead, 0.0, false)


# from objects/obj_bowser_dead_castle/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_lava_water):
		if G.bg_level == "forest":
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 28.0), A.obj_splash_posion)
		else:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 28.0), A.obj_splash_lava)
	alarm[2] = 20.0
