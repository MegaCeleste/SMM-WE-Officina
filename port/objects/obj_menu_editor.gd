extends "res://objects/obj_parent_layout.gd"

var can_press: float = 0.0
var anim: float = 0.0
var effect_hover: float = 0.0


# from objects/obj_menu_editor/Create_0.gml
func _create() -> void:
	can_press = 1.0
	anim = 0.0
	effect_hover = 0.0


# from objects/obj_menu_editor/Step_0.gml
func _step() -> void:
	x = (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 39.0)


# from objects/obj_menu_editor/Alarm_0.gml
func _alarm_0() -> void:
	can_press = 1.0


# from objects/obj_menu_editor/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 43.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0)) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 43.0), anim, 2.0)


# from objects/obj_menu_editor/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_ventana_mario)) and (not GM.instance_exists(A.obj_ventana)) and G.cursor == 0.0 and can_press == 1.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0:
		GM.audio_play_sound(A.snd_abrir_menu, 0.0, false)
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_edit_menu)
		for _obj_write1 in GM.with_list(A.obj_erase):
			_obj_write1.active = 0.0
		for _obj_write2 in GM.with_list(A.obj_cursor):
			_obj_write2.image_index = 0.0
		for _obj_write3 in GM.with_list(A.obj_editormanager):
			_obj_write3.expand_open = 2.0
		for _obj_write4 in GM.with_list(A.obj_expand):
			_obj_write4.active = 1.0
		for _obj_write5 in GM.with_list(A.obj_card_item):
			_obj_write5.active = 0.0
		G.select_resource = A.obj_resource_empty


# from objects/obj_menu_editor/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_menu_editor/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
