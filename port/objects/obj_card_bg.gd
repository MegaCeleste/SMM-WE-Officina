extends "res://objects/obj_panelsparent.gd"

var active: float = 0.0
var anim: float = 0.0
var effect_hover: float = 0.0


# from objects/obj_card_bg/Create_0.gml
func _create() -> void:
	super._create()
	active = 0.0
	image_speed = 0.0
	anim = 0.0
	effect_hover = 0.0


# from objects/obj_card_bg/Step_0.gml
func _step() -> void:
	x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + 7.0) - GM.instance_find(A.obj_cursor, 0).anim_left)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 66.0)
	match G.bg_level:
		"ground":
			image_index = 0.0
		"underground":
			image_index = 1.0
		"castle":
			image_index = 2.0
		"underwater":
			image_index = 3.0
		"ghost":
			image_index = 4.0
		"airship":
			image_index = 5.0
		"forest":
			image_index = 6.0
		"sky":
			image_index = 7.0
		"desert":
			image_index = 8.0
		"snow":
			image_index = 9.0
		"fall":
			image_index = 10.0
		"beach":
			image_index = 11.0
		"mountain":
			if G.modo_noche == 0.0:
				image_index = 13.0
			else:
				image_index = 12.0


# from objects/obj_card_bg/Draw_0.gml
func _gm_draw() -> void:
	if active == 0.0:
		GM.draw_sprite(A.spr_card_background, 0.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0))
	GM.draw_sprite_ext(sprite_index, image_index, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 7.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 66.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 7.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 66.0), anim, 0.0)


# from objects/obj_card_bg/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open != 2.0 and ps == 1.0 and (not GM.instance_exists(A.obj_ventana)) and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0:
		for inst in GM.with_list(A.obj_panelsparent):
			inst.ps = 0.0
			inst.alarm[0] = 15.0
		if GM.instance_exists(A.obj_bg_selection) and GM.instance_find(A.obj_bg_selection, 0).image_speed == 0.0:
			GM.audio_play_sound(A.snd_panel_close, 0.0, false)
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_bg_selection):
				inst.event_user(0)
			GM.other = _o1
		elif not GM.instance_exists(A.obj_bg_selection):
			GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_bg_selection)
			GM.audio_play_sound(A.snd_panel_open, 0.0, false)
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
			if GM.instance_exists(A.obj_panel_save_load):
				var _o4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_panel_save_load):
					inst.event_user(0)
				GM.other = _o4
			if GM.instance_exists(A.obj_autoavance):
				var _o5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_autoavance):
					inst.event_user(0)
				GM.other = _o5
			if GM.instance_exists(A.obj_condiciones):
				var _o6: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_condiciones):
					inst.event_user(0)
				GM.other = _o6
			for inst in GM.with_list(A.obj_erase):
				inst.active = 0.0
			for inst in GM.with_list(A.obj_cursor):
				inst.image_index = 0.0


# from objects/obj_card_bg/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_izquierdo_move)
			GM.audio_play_sound(A.snd_panel_izquierdo_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_card_bg/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
