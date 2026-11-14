extends "res://objects/obj_parent_layout.gd"

var active: float = 0.0
var effect_hover: float = 0.0
var can_press: float = 0.0
var anim: float = 0.0


# from objects/obj_expand/Create_0.gml
func _create() -> void:
	active = 0.0
	effect_hover = 0.0
	can_press = 1.0
	anim = 0.0


# from objects/obj_expand/Step_0.gml
func _step() -> void:
	if active == 0.0:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 356.0)
	else:
		x = GM.camera_get_view_x(GM.view_get_camera(0))
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) - GM.instance_find(A.obj_cursor, 0).anim_top)


# from objects/obj_expand/Alarm_0.gml
func _alarm_0() -> void:
	can_press = 1.0


# from objects/obj_expand/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 356.0), ((GM.camera_get_view_y(GM.view_get_camera(0))) - GM.instance_find(A.obj_cursor, 0).anim_top), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, (GM.camera_get_view_x(GM.view_get_camera(0)) + 356.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 2.5) - GM.instance_find(A.obj_cursor, 0).anim_top), anim, 2.0)


# from objects/obj_expand/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0 and (not place_meeting(x, y, A.obj_button_close)) and (not place_meeting(x, y, A.obj_window_alert)) and (not place_meeting(x, y, A.obj_panel_expand)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_ventana_mario)) and (not GM.instance_exists(A.obj_ventana)) and G.cursor == 0.0 and can_press == 1.0:
		GM.audio_play_sound(A.snd_open_palette, 0.0, false)
		for inst in GM.with_list(A.obj_editormanager):
			inst.hspeed = 0.0
		for inst in GM.with_list(A.obj_editormanager):
			inst.vspeed = 0.0
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 2.0
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_panel_expand)
		for inst in GM.with_list(A.obj_cursor):
			inst.item_add = 0.0
			if inst.cont_panel_right == 0.0:
				inst.cont_panel_right = 1.0
			if inst.cont_panel_left == 0.0:
				inst.cont_panel_left = 1.0
			if inst.cont_panel_top == 0.0:
				inst.cont_panel_top = 1.0
			inst.cont_panel_creator = 1.0
		if GM.instance_exists(A.obj_bg_selection):
			for inst in GM.with_list(A.obj_bg_selection):
				inst.instance_destroy()
		if GM.instance_exists(A.obj_time):
			for inst in GM.with_list(A.obj_time):
				inst.instance_destroy()
		active = 1.0
		visible = false


# from objects/obj_expand/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_expand/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
