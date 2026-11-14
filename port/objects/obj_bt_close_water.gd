extends GMObject


# from objects/obj_bt_close_water/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_bt_close_water/Step_2.gml
func _step_end() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 350.0)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 19.0)


# from objects/obj_bt_close_water/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 350.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 19.0))


# from objects/obj_bt_close_water/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_cursor, 0).move == 0.0:
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		for inst in GM.with_list(A.obj_levelmanager):
			inst.editor_water = 0.0
		for inst in GM.with_list(A.obj_cursor):
			if inst.cont_panel_right == 3.0:
				inst.cont_panel_right = 2.0
			if inst.cont_panel_left == 3.0:
				inst.cont_panel_left = 2.0
			if inst.cont_panel_top == 3.0:
				inst.cont_panel_top = 2.0
			inst.cont_panel_creator = 2.0
		for inst in GM.with_list(A.obj_expand):
			inst.visible = true
		for inst in GM.with_list(A.obj_editormanager):
			inst.alarm[0] = 15.0
		if GM.instance_exists(A.obj_water_level_control):
			for inst in GM.with_list(A.obj_water_level_control):
				inst.instance_destroy()
