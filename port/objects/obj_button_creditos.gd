extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_button_creditos/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.idioma
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_button_creditos/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_button_creditos/Mouse_4.gml
func _mouse_4() -> void:
	GM.audio_stop_sound(A.snd_aceptar)
	GM.audio_play_sound(A.snd_aceptar, 0.0, false)
	GM.room_goto(A.rm_credito)


# from objects/obj_button_creditos/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_settings_move)
		GM.audio_stop_sound(A.snd_settings_player_move)
		GM.audio_play_sound(A.snd_settings_player_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_creditos/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
