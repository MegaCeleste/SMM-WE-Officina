extends GMObject

var s_oprime: int = 0


# from objects/obj_title_oprime/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 1.0
	if G.idioma == 0.0:
		s_oprime = A.spr_title_oprime
	elif G.idioma == 1.0:
		s_oprime = A.spr_title_oprime_en
	elif G.idioma == 2.0:
		s_oprime = A.spr_title_oprime_pt
	elif G.idioma == 3.0:
		s_oprime = A.spr_title_oprime_it
	elif G.idioma == 4.0:
		s_oprime = A.spr_title_oprime_ch
	sprite_index = s_oprime
	alarm[0] = 180.0


# from objects/obj_title_oprime/Step_2.gml
func _step_end() -> void:
	if sprite_index == A.spr_back_button_white:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 177.0)
	else:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 137.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 182.0)


# from objects/obj_title_oprime/Alarm_0.gml
func _alarm_0() -> void:
	image_index = 0.0
	alarm[1] = 12.0


# from objects/obj_title_oprime/Alarm_1.gml
func _alarm_1() -> void:
	image_index = 1.0
	alarm[0] = 180.0


# from objects/obj_title_oprime/Draw_0.gml
func _gm_draw() -> void:
	if sprite_index == A.spr_back_button_white:
		GM.draw_sprite(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 177.0))
	else:
		GM.draw_sprite(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 137.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 182.0))


# from objects/obj_title_oprime/Mouse_4.gml
func _mouse_4() -> void:
	GM.audio_play_sound(A.snd_back, 0.0, false)
	if sprite_index == A.spr_back_button_white:
		if GM.instance_exists(A.obj_button_home):
			for inst in GM.with_list(A.obj_button_home):
				inst.instance_destroy()
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_editor_screen)
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_play_screen)
		else:
			sprite_index = s_oprime
			image_speed = 0.0
			image_index = 1.0
			alarm[0] = 180.0
			if GM.instance_exists(A.obj_editor_screen):
				for inst in GM.with_list(A.obj_editor_screen):
					inst.instance_destroy()
			if GM.instance_exists(A.obj_play_screen):
				for inst in GM.with_list(A.obj_play_screen):
					inst.instance_destroy()
	else:
		sprite_index = A.spr_back_button_white
		image_speed = 0.0
		image_index = 0.0
		alarm[0] = -1.0
		alarm[1] = -1.0
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_editor_screen)
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 197.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_play_screen)
