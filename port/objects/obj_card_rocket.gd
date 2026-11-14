extends "res://objects/obj_parent_layout.gd"

var aud: float = 0.0
var cont: float = 0.0
var ready_v: float = 0.0
var counter_draw: float = 0.0
var counter_anim: float = 0.0
var effect_hover: float = 0.0


# from objects/obj_card_rocket/Create_0.gml
func _create() -> void:
	aud = 0.0
	cont = 0.0
	ready_v = 0.0
	image_speed = 0.0
	image_index = 0.0
	counter_draw = 0.0
	counter_anim = 0.0
	effect_hover = 0.0


# from objects/obj_card_rocket/Step_0.gml
func _step() -> void:
	x = (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 184.0)
	if counter_draw == 1.0:
		counter_anim += 0.15
	if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if counter_anim >= 11.85:
			GM.audio_play_sound(A.snd_rocket_go, 0.0, false)
			sprite_index = A.spr_rocket
			image_speed = 0.0
			image_index = 0.0
			aud = 0.0
			ready_v = 0.0
			cont = 0.0
			counter_draw = 0.0
			counter_anim = 0.0
			for inst in GM.with_list(GM.instance_create(x, (y + 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_smoke
			G.instance_deactivate = 0.0
			alarm[0] = 2.0
	elif GM.mouse_check_button_released(GM.mb_left) and sprite_index == A.spr_rocket_go:
		GM.audio_stop_sound(A.snd_rocket_count)
		sprite_index = A.spr_rocket
		image_speed = 0.0
		image_index = 0.0
		aud = 0.0
		ready_v = 0.0
		cont = 0.0
		counter_draw = 0.0
		counter_anim = 0.0


# from objects/obj_card_rocket/Alarm_0.gml
func _alarm_0() -> void:
	G.save_changes = 0.0
	_user_0()


# from objects/obj_card_rocket/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_parent_resource):
		for inst in GM.with_list(A.obj_parent_resource):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_parent_sounds):
		for inst in GM.with_list(A.obj_parent_sounds):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_decoracion_1):
		for inst in GM.with_list(A.obj_decoracion_1):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_decoracion_2):
		for inst in GM.with_list(A.obj_decoracion_2):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_decoracion_3):
		for inst in GM.with_list(A.obj_decoracion_3):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_decoracion_4):
		for inst in GM.with_list(A.obj_decoracion_4):
			inst.instance_destroy()
	for inst in GM.with_list(A.obj_ground2):
		inst.y = 400.0
		inst.size_y = 2.0
	for inst in GM.with_list(A.obj_ground3):
		GM.room_width = 1152.0
		inst.x = 992.0
		inst.y = 400.0
		inst.size_y = 2.0
	G.instance_deactivate = 1.0
	ready_v = 0.0


# from objects/obj_card_rocket/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(A.spr_rocket_draw, 0.0, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 184.0))
	if ready_v == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 184.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))), (GM.camera_get_view_y(GM.view_get_camera(0)) + 216.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if counter_draw == 1.0:
		GM.draw_sprite(A.spr_rocket_counter, counter_anim, (GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0))


# from objects/obj_card_rocket/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_cursor, 0).item_add == 0.0 and GM.instance_find(A.obj_cursor, 0).move == 0.0 and GM.instance_find(A.obj_erase, 0).active == 0.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0 and ready_v == 0.0:
		if counter_draw == 0.0 and (not GM.audio_is_playing(A.snd_rocket_count)):
			GM.audio_play_sound(A.snd_rocket_count, 0.0, false)
		counter_draw = 1.0
		sprite_index = A.spr_rocket_go
		image_speed = 0.15


# from objects/obj_card_rocket/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if sprite_index == A.spr_rocket:
			image_index = 1.0
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_card_rocket/Mouse_11.gml
func _mouse_11() -> void:
	if sprite_index == A.spr_rocket:
		image_index = 0.0
	effect_hover = 0.0
