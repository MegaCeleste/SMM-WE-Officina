extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_configurar_controles_reset/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.controller
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_configurar_controles_reset/Step_1.gml
func _step_begin() -> void:
	image_index = G.controller


# from objects/obj_configurar_controles_reset/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, (y + 1.0), anim, 2.0)


# from objects/obj_configurar_controles_reset/Mouse_4.gml
func _mouse_4() -> void:
	if G.controller == 0.0:
		G.controller = 1.0
	else:
		G.controller = 0.0


# from objects/obj_configurar_controles_reset/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_settings_move)
		GM.audio_play_sound(A.snd_settings_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_configurar_controles_reset/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
