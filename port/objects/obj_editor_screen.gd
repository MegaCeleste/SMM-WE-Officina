extends "res://objects/obj_play_screen.gd"


# from objects/obj_editor_screen/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.idioma
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0)
	rot1 = 0.0
	rot2 = 0.0
	effect_hover = 0.0
	anim = 0.0
	alarm[2] = 2.0


# from objects/obj_editor_screen/Other_12.gml
func _user_2() -> void:
	GM.audio_play_sound(A.snd_play_start_create, 0.0, false)
	GM.audio_stop_sound(A.snd_titlemusic)
	GM.audio_stop_sound(A.snd_titlemusic_modern)
	GM.audio_stop_sound(A.snd_titlemusic_night)
	GM.audio_stop_sound(A.snd_titlemusic_smw)
	GM.audio_stop_sound(A.snd_music_mario_land)
	GM.audio_stop_sound(A.snd_SMB_master_sword)
	GM.audio_stop_sound(A.snd_SMB_master_sword_underground)
	GM.audio_stop_sound(A.snd_SMB_master_sword_castle)
	Scr.scr_stop_effect_sounds(self)
	GM.audio_play_sound(A.snd_caidas_letras, 0.0, false)
	if GM.instance_exists(A.obj_title_controller):
		for inst in GM.with_list(A.obj_title_controller):
			inst.ready_v = 1.0
	if GM.instance_exists(A.obj_editor_screen):
		for inst in GM.with_list(A.obj_editor_screen):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_play_screen):
		for inst in GM.with_list(A.obj_play_screen):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_title_oprime):
		for inst in GM.with_list(A.obj_title_oprime):
			inst.instance_destroy()
