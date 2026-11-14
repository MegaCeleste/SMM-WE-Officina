extends GMObject

var anim: float = 0.0
var effect_hover: float = 0.0


# from objects/obj_button_trail/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.player_trail
	anim = 0.0
	effect_hover = 0.0


# from objects/obj_button_trail/Step_2.gml
func _step_end() -> void:
	image_index = G.player_trail
	x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + 33.0) - GM.instance_find(A.obj_cursor, 0).anim_left)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0)


# from objects/obj_button_trail/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 30.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 159.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 30.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 159.0), anim, 1.0)


# from objects/obj_button_trail/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open != 2.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0:
		if G.player_trail == 0.0:
			GM.audio_play_sound(A.snd_add_trayectory, 0.0, false)
			G.player_trail = 1.0
		else:
			GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)
			G.player_trail = 0.0


# from objects/obj_button_trail/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_izquierdo_move)
			GM.audio_play_sound(A.snd_panel_izquierdo_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_button_trail/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
