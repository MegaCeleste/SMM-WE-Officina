extends "res://objects/obj_panelparent.gd"

var text: float = 0.0


# from objects/obj_panel_save_load/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	text = 0.0


# from objects/obj_panel_save_load/Step_1.gml
func _step_begin() -> void:
	if image_speed < 0.0 and image_index <= 0.0:
		if (not GM.instance_exists(A.obj_condiciones)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_time)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_autoavance)) and (not GM.instance_exists(A.obj_alert_load)) and (not GM.instance_exists(A.obj_window_alert)):
			for inst in GM.with_list(A.obj_editormanager):
				inst.expand_open = 0.0
		instance_destroy()


# from objects/obj_panel_save_load/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_button_save_load):
		text = 0.0
	else:
		text = 1.0


# from objects/obj_panel_save_load/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_panel_save_load:
		image_speed = 0.0
		image_index = 4.0
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 213.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 62.0), A.obj_button_save_load)
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 213.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 105.0), A.obj_button_save_changes)
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 213.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 171.0), A.obj_button_save_load)):
			inst.sprite_index = A.spr_button_load
			inst.c_color = GM.make_color_rgb(62.0, 152.0, 186.0)


# from objects/obj_panel_save_load/Other_10.gml
func _user_0() -> void:
	image_index = 4.0
	image_speed = -0.5
	for inst in GM.with_list(A.obj_button_save_load):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_save_changes):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_robot):
		inst.active = 0.0


# from objects/obj_panel_save_load/Draw_0.gml
func _gm_draw() -> void:
	var vx
	if G.idioma == 0.0:
		vx = 10.0
	elif G.idioma == 2.0:
		vx = 14.0
	elif G.idioma == 3.0:
		vx = 6.0
	else:
		vx = 2.0
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 198.0), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	if text == 1.0:
		GM.draw_text(x + 55.0 - vx, y + 37.0, Scr.scr_language(self, 85.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_panel_save_load/Mouse_4.gml
func _mouse_4() -> void:
	if image_speed == 0.0 and image_index == 4.0 and GM.mouse_x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 336.0) and GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 347.0) and GM.mouse_y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0):
		GM.audio_play_sound(A.snd_close_guardabot, 0.0, false)
		_user_0()
