extends GMObject

var image_i: float = 0.0
var al: float = 0.0
var cont: float = 0.0
var fast: float = 0.0
var cont_more = null


# from objects/obj_button_time/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_i = 0.0
	al = 0.0
	cont = 0.0
	fast = 0.0


# from objects/obj_button_time/Alarm_0.gml
func _alarm_0() -> void:
	if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if sprite_index == A.spr_button_time_up:
			if GM.instance_find(A.obj_levelmanager, 0).leveltime < 500.0:
				for inst in GM.with_list(A.obj_levelmanager):
					inst.leveltime += 10.0
				if not GM.audio_is_playing(A.snd_timeup):
					GM.audio_play_sound(A.snd_timeup, 0.0, false)
		elif sprite_index == A.spr_button_time_down:
			if GM.instance_find(A.obj_levelmanager, 0).leveltime > 10.0:
				for inst in GM.with_list(A.obj_levelmanager):
					inst.leveltime -= 10.0
				if not GM.audio_is_playing(A.snd_timedown):
					GM.audio_play_sound(A.snd_timedown, 0.0, false)
		if cont > 60.0:
			alarm[0] = 1.0
			cont_more = 0.0
		else:
			alarm[0] = 6.0
			cont_more = 1.0
	else:
		alarm[0] = -1.0
		al = 0.0
		cont = 0.0


# from objects/obj_button_time/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if al == 0.0:
			alarm[0] = 1.0
			al = 1.0
		cont += 1.0
