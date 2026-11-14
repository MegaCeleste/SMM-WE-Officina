extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_button_meteoritos/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if (G.bg_level == "mountain") and (G.modo_noche == 1.0):
		image_index = G.meteoritos
	else:
		image_index = 2.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_button_meteoritos/Step_2.gml
func _step_end() -> void:
	if (G.bg_level == "mountain") and (G.modo_noche == 1.0):
		image_index = G.meteoritos
	else:
		image_index = 2.0
	x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0) - GM.instance_find(A.obj_cursor, 0).anim_left)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 87.0)


# from objects/obj_button_meteoritos/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 87.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		if image_index != 2.0:
			Scr.scr_anim_hover(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 87.0), anim, 1.0)


# from objects/obj_button_meteoritos/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open != 2.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0:
		if image_index != 2.0:
			GM.audio_play_sound(A.snd_panel_open, 0.0, false)
			if G.meteoritos == 0.0:
				G.meteoritos = 1.0
			else:
				G.meteoritos = 0.0


# from objects/obj_button_meteoritos/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and image_index != 2.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_izquierdo_move)
			GM.audio_play_sound(A.snd_panel_izquierdo_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_button_meteoritos/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
