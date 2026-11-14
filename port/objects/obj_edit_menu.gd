extends GMObject


# from objects/obj_edit_menu/Create_0.gml
func _create() -> void:
	if GM.instance_exists(A.obj_creator_jugar_editar):
		GM.audio_pause_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
	image_speed = 0.0
	image_index = G.idioma
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 360.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), A.obj_button_close_menu)
	if not GM.instance_exists(A.obj_button_home):
		var _with_target2 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 212.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 70.0), A.obj_button_home)
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			if GM.room == A.rm_editor:
				inst.sprite_index = A.spr_buttons_plays_press
				inst.disabled = 1.0
		GM.other = _other1
		var _with_target4 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 212.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 110.0), A.obj_button_home)
		var _other3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target4):
			inst.image_index = 3.0
			if GM.room == A.rm_guardabot:
				inst.sprite_index = A.spr_buttons_plays_press
				inst.disabled = 1.0
		GM.other = _other3
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 212.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 176.0), A.obj_profile)
	var _with_target6 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 307.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 187.0), A.obj_settings_button)
	var _other5: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target6):
		inst.image_index = 2.0
	GM.other = _other5
	var _with_target8 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 331.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 187.0), A.obj_settings_button)
	var _other7: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target8):
		inst.image_index = 1.0
	GM.other = _other7
	var _with_target10 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 355.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 187.0), A.obj_settings_button)
	var _other9: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target10):
		inst.image_index = 3.0
	GM.other = _other9


# from objects/obj_edit_menu/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_button_home):
		var _with_target12 = A.obj_button_home
		var _other11: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target12):
			inst.instance_destroy()
		GM.other = _other11
	var _with_target14 = A.obj_button_close_menu
	var _other13: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target14):
		inst.instance_destroy()
	GM.other = _other13
	var _with_target16 = A.obj_settings_button
	var _other15: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target16):
		inst.instance_destroy()
	GM.other = _other15
	var _with_target18 = A.obj_profile
	var _other17: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target18):
		inst.instance_destroy()
	GM.other = _other17
	if GM.instance_exists(A.obj_gb_button):
		var _with_target20 = A.obj_gb_button
		var _other19: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target20):
			inst.press = 1.0
		GM.other = _other19
	GM.instance_activate_object(A.obj_menu_editor)
	GM.instance_activate_object(A.obj_menu_editor_ext)
	if GM.instance_exists(A.obj_expand):
		var _with_target22 = A.obj_expand
		var _other21: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target22):
			inst.active = 0.0
		GM.other = _other21
	if (not GM.instance_exists(A.obj_settings_panel)) and (not GM.instance_exists(A.obj_window_alert)) and GM.instance_exists(A.obj_creator_jugar_editar):
		GM.audio_resume_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
	if GM.instance_exists(A.obj_gb_button) and (not GM.instance_exists(A.obj_settings_panel)):
		var _with_target24 = A.obj_gb_button
		var _other23: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target24):
			inst.alarm[0] = 10.0
		GM.other = _other23
		var _with_target26 = A.obj_btn_reload
		var _other25: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target26):
			inst.alarm[0] = 10.0
		GM.other = _other25


# from objects/obj_edit_menu/Step_0.gml
func _step() -> void:
	if (GM.room == A.rm_guardabot) and GM.instance_exists(A.obj_edit_menu):
		GM.audio_pause_sound(A.snd_guardabot)


# from objects/obj_edit_menu/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_expand_bg, 1.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), (GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0), (GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0), 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
