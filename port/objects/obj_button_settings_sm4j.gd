extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0
var c_disabled: float = 0.0
var c_color: float = 0.0
var text = null


# from objects/obj_button_settings_sm4j/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	effect_hover = 0.0
	anim = 0.0
	c_disabled = GM.make_colour_rgb(110.0, 119.0, 126.0)
	c_color = GM.make_colour_rgb(89.0, 15.0, 16.0)
	if G.sm4j_style == 1.0:
		text = Scr.scr_language(self, 30.0)
	else:
		text = Scr.scr_language(self, 31.0)


# from objects/obj_button_settings_sm4j/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_text((x + 25.0), (y + 1.0), GM.string_hash_to_newline(text))
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_button_settings_sm4j/Mouse_4.gml
func _mouse_4() -> void:
	GM.audio_stop_sound(A.snd_aceptar)
	GM.audio_play_sound(A.snd_aceptar, 0.0, false)
	if G.sm4j_style == 1.0:
		G.sm4j_style = 0.0
		text = Scr.scr_language(self, 31.0)
		G.key_br = 0.0
	else:
		G.sm4j_style = 1.0
		text = Scr.scr_language(self, 30.0)


# from objects/obj_button_settings_sm4j/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_settings_move)
		GM.audio_play_sound(A.snd_settings_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_settings_sm4j/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
