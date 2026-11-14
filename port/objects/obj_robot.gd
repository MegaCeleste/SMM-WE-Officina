extends "res://objects/obj_parent_layout.gd"

var active: float = 0.0
var canpress: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_robot/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	active = 0.0
	canpress = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_robot/Step_0.gml
func _step() -> void:
	x = (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 68.0)
	if active == 1.0:
		image_index = 1.0


# from objects/obj_robot/Draw_0.gml
func _gm_draw() -> void:
	if active == 0.0:
		GM.draw_sprite(A.spr_card_bg, 0.0, ((((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), ((GM.camera_get_view_y(GM.view_get_camera(0))) + 70.0))
	GM.draw_sprite_ext(sprite_index, image_index, ((((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), ((GM.camera_get_view_y(GM.view_get_camera(0))) + 68.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, ((((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), ((GM.camera_get_view_y(GM.view_get_camera(0))) + 70.0), anim, 2.0)


# from objects/obj_robot/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open != 2.0 and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_autoavance)) and (not GM.instance_exists(A.obj_time)) and (not GM.instance_exists(A.obj_condiciones)) and G.cursor == 0.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0 and canpress == 0.0:
		if GM.instance_exists(A.obj_panel_save_load) and GM.instance_find(A.obj_panel_save_load, 0).image_speed == 0.0:
			GM.audio_play_sound(A.snd_close_guardabot, 0.0, false)
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_panel_save_load):
				inst.event_user(0)
			GM.other = _o1
		elif not GM.instance_exists(A.obj_panel_save_load):
			GM.audio_play_sound(A.snd_open_guardabot, 0.0, false)
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 198.0), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_panel_save_load)
			for inst in GM.with_list(A.obj_editormanager):
				inst.expand_open = 1.0
			active = 1.0
			if GM.instance_exists(A.obj_time):
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_time):
					inst.event_user(0)
				GM.other = _o2
			if GM.instance_exists(A.obj_apariencia):
				var _o3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_apariencia):
					inst.event_user(0)
				GM.other = _o3
			if GM.instance_exists(A.obj_bg_selection):
				var _o4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_bg_selection):
					inst.event_user(0)
				GM.other = _o4
			if GM.instance_exists(A.obj_condiciones):
				var _o5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_condiciones):
					inst.event_user(0)
				GM.other = _o5
			for inst in GM.with_list(A.obj_erase):
				inst.active = 0.0
			for inst in GM.with_list(A.obj_cursor):
				inst.image_index = 0.0


# from objects/obj_robot/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if active == 0.0:
			image_index = 1.0
		if active == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_robot/Mouse_11.gml
func _mouse_11() -> void:
	if active == 0.0:
		image_index = 0.0
	effect_hover = 0.0
