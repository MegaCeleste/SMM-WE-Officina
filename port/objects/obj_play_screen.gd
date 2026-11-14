extends GMObject

var rot1: float = 0.0
var rot2: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_play_screen/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.idioma
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0)
	rot1 = 0.0
	rot2 = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_play_screen/Step_2.gml
func _step_end() -> void:
	if object_index == A.obj_play_screen:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0)
	else:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0)


# from objects/obj_play_screen/Alarm_0.gml
func _alarm_0() -> void:
	if rot2 >= 20.0:
		alarm[1] = 1.0
		alarm[0] = -1.0
	else:
		rot1 -= 3.0
		rot2 += 3.0
		alarm[0] = 1.0


# from objects/obj_play_screen/Alarm_1.gml
func _alarm_1() -> void:
	if rot2 <= 0.0:
		alarm[1] = -1.0
		_user_2()
	else:
		rot1 += 3.0
		rot2 -= 3.0
		alarm[1] = 1.0


# from objects/obj_play_screen/Other_10.gml
func _user_0() -> void:
	if not GM.instance_exists(A.obj_button_home):
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0), A.obj_button_home)):
			inst.image_index = 3.0
			inst.depth = -25.0


# from objects/obj_play_screen/Other_11.gml
func _user_1() -> void:
	if GM.instance_exists(A.obj_button_home):
		for inst in GM.with_list(A.obj_button_home):
			inst.instance_destroy()


# from objects/obj_play_screen/Other_12.gml
func _user_2() -> void:
	GM.audio_play_sound(A.snd_play_start_create, 0.0, false)
	for inst in GM.with_list(A.obj_play_screen):
		inst.visible = false
	for inst in GM.with_list(A.obj_editor_screen):
		inst.visible = false
	rot1 = 0.0
	rot2 = 0.0
	_user_0()


# from objects/obj_play_screen/Draw_0.gml
func _gm_draw() -> void:
	if object_index == A.obj_play_screen:
		GM.draw_sprite_ext(A.spr_creator_top, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), image_xscale, image_yscale, rot2, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_index, G.idioma, (GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), image_xscale, image_yscale, rot1, GM.c_white, 1.0)
		if effect_hover == 1.0:
			anim += 0.3
			Scr.scr_anim_hover(self, (GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), anim, 2.0)
	else:
		GM.draw_sprite_ext(A.spr_creator_top, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), image_xscale, image_yscale, rot2, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_index, G.idioma, (GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), image_xscale, image_yscale, rot1, GM.c_white, 1.0)
		if effect_hover == 1.0:
			anim += 0.3
			Scr.scr_anim_hover(self, (GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), anim, 2.0)


# from objects/obj_play_screen/Mouse_4.gml
func _mouse_4() -> void:
	var editor = GM.instance_find(A.obj_editor_screen, 0)
	if visible == true and (not GM.instance_exists(A.obj_settings_panel)) and rot1 == 0.0 and rot2 == 0.0 and editor.rot1 == 0.0 and editor.rot2 == 0.0:
		alarm[0] = 1.0


# from objects/obj_play_screen/Mouse_10.gml
func _mouse_10() -> void:
	effect_hover = 1.0


# from objects/obj_play_screen/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
