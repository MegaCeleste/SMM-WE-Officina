extends GMObject

var cont_sounds: float = 0.0
var stop: float = 0.0
var sonido: float = 0.0
var sonido2: float = 0.0
var sonido3: float = 0.0
var sonido4: float = 0.0
var active: float = 0.0
var full: float = 0.0


# from objects/obj_efecto_sonido/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	cont_sounds = 1.0
	stop = 0.0
	sonido = A.snd_es_risas
	sonido2 = A.snd_es_risas2
	sonido3 = A.snd_es_risas3
	sonido4 = A.snd_es_risas4
	active = 0.0
	full = 0.0
	alarm[0] = 1.0


# from objects/obj_efecto_sonido/Step_2.gml
func _step_end() -> void:
	if full == 1.0:
		x = GM.camera_get_view_x(GM.view_get_camera(0))
		y = GM.camera_get_view_y(GM.view_get_camera(0))


# from objects/obj_efecto_sonido/Alarm_0.gml
func _alarm_0() -> void:
	if cont_sounds == 1.0:
		if stop == 0.0:
			GM.audio_stop_sound(sonido)
		GM.audio_play_sound(sonido, 0.0, false)
	else:
		var ramdom_sound: float = GM.choose(sonido, sonido2, sonido3, sonido4)
		GM.audio_stop_sound(ramdom_sound)
		GM.audio_play_sound(ramdom_sound, 0.0, false)


# from objects/obj_efecto_sonido/Other_7.gml
func _animation_end() -> void:
	instance_destroy()


# from objects/obj_efecto_sonido/Draw_0.gml
func _gm_draw() -> void:
	if full == 1.0:
		GM.draw_sprite(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
	else:
		draw_self()
