extends GMObject


# from objects/obj_expand_panels/Create_0.gml
func _create() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 346.0)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 100.0)


# from objects/obj_expand_panels/Step_0.gml
func _step() -> void:
	x = (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 38.0) + GM.instance_find(A.obj_cursor, 0).anim_right)
	if GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 2.0:
		sprite_index = A.spr_expand_panels_big
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 200.0)
	else:
		sprite_index = A.spr_expand_panels
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 100.0)


# from objects/obj_expand_panels/Draw_0.gml
func _gm_draw() -> void:
	var zoom
	if GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 2.0:
		zoom = 200.0
	else:
		zoom = 100.0
	GM.draw_sprite_ext(sprite_index, image_index, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 38.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + zoom), 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_expand_panels/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0) and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0 and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0 and GM.instance_find(A.obj_erase, 0).active == 0.0 and GM.instance_find(A.obj_cursor, 0).move == 0.0:
		GM.audio_play_sound(A.snd_close_palette2, 0.0, false)
		if GM.instance_find(A.obj_cursor, 0).cont_panel_right == 0.0:
			for inst in GM.with_list(A.obj_cursor):
				inst.cont_panel_right = 1.0
		elif GM.instance_find(A.obj_cursor, 0).cont_panel_right == 3.0:
			for inst in GM.with_list(A.obj_cursor):
				inst.cont_panel_right = 2.0
