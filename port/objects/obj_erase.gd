extends "res://objects/obj_parent_layout.gd"

var active: float = 0.0
var active2: float = 0.0
var can_clean: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_erase/Create_0.gml
func _create() -> void:
	active = 0.0
	active2 = 0.0
	gravity = 0.0
	speed = 0.0
	image_speed = 0.0
	can_clean = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_erase/Step_0.gml
func _step() -> void:
	x = (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 129.0)
	if active == 1.0:
		sprite_index = A.spr_clean_selected
		if active2 == 0.0:
			alarm[0] = 1.0
			active2 = 1.0
	else:
		sprite_index = A.spr_clean
		alarm[0] = -1.0
		image_index = 0.0
		active2 = 0.0


# from objects/obj_erase/Alarm_0.gml
func _alarm_0() -> void:
	if image_index == 0.0:
		image_index = 1.0
		alarm[0] = 25.0
		GM.audio_stop_sound(A.snd_jump_erase)
		GM.audio_play_sound(A.snd_jump_erase_reverse, 0.0, false)
	else:
		image_index = 0.0
		alarm[0] = 25.0
		GM.audio_stop_sound(A.snd_jump_erase_reverse)
		GM.audio_play_sound(A.snd_jump_erase, 0.0, false)


# from objects/obj_erase/Alarm_1.gml
func _alarm_1() -> void:
	can_clean = 1.0


# from objects/obj_erase/Other_10.gml
func _user_0() -> void:
	if active == 0.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0 and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0):
		if GM.instance_find(A.obj_cursor, 0).fast_clean == 0.0:
			for inst in GM.with_list(A.obj_card_item):
				inst.active = 0.0
			G.select_resource = A.obj_resource_empty
		G.cursor = 2.0
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_cursor):
			inst.event_user(0)
		GM.other = _o1
		alarm[1] = 20.0
		active = 1.0
	elif active == 1.0:
		active = 0.0
		can_clean = 0.0
		image_index = 0.0
		G.cursor = 0.0
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_cursor):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_erase/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 129.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 129.0), anim, 2.0)


# from objects/obj_erase/Mouse_4.gml
func _mouse_4() -> void:
	_user_0()


# from objects/obj_erase/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_erase/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
