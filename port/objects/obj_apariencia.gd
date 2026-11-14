extends "res://objects/obj_panelparent.gd"

var text: float = 0.0


# from objects/obj_apariencia/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	text = 0.0


# from objects/obj_apariencia/Step_1.gml
func _step_begin() -> void:
	if image_speed < 0.0 and image_index <= 0.0:
		if (not GM.instance_exists(A.obj_panel_save_load)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_autoavance)) and (not GM.instance_exists(A.obj_time)) and (not GM.instance_exists(A.obj_condiciones)):
			for inst in GM.with_list(A.obj_editormanager):
				inst.expand_open = 0.0
		instance_destroy()


# from objects/obj_apariencia/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_card_logo):
		text = 0.0
	else:
		text = 1.0


# from objects/obj_apariencia/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_panel_apariencia_anim:
		image_speed = 0.0
		image_index = 4.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 68.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0), A.obj_card_logo)):
			inst.apariencia = 0.0
			inst.image_index = 0.0
			inst.x_pos = 68.0
			inst.y_pos = 65.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 116.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0), A.obj_card_logo)):
			inst.apariencia = 1.0
			inst.image_index = 1.0
			inst.x_pos = 116.0
			inst.y_pos = 65.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 68.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 92.0), A.obj_card_logo)):
			inst.apariencia = 2.0
			inst.image_index = 2.0
			inst.x_pos = 68.0
			inst.y_pos = 92.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 116.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 92.0), A.obj_card_logo)):
			inst.apariencia = 3.0
			inst.image_index = 3.0
			inst.x_pos = 116.0
			inst.y_pos = 92.0


# from objects/obj_apariencia/Other_10.gml
func _user_0() -> void:
	image_index = 4.0
	image_speed = -0.5
	for inst in GM.with_list(A.obj_card_logo):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_logo_game):
		inst.active = 0.0


# from objects/obj_apariencia/Draw_0.gml
func _gm_draw() -> void:
	var offset
	if G.idioma == 3.0:
		offset = 15.0
	else:
		offset = 0.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_font(G.font_google)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	if text == 1.0:
		GM.draw_text((x + (sprite_width / 2.0) + offset), y + 37.0, Scr.scr_language(self, 80.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_apariencia/Mouse_4.gml
func _mouse_4() -> void:
	if image_speed == 0.0 and image_index == 4.0 and GM.mouse_x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0) and GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 166.0) and GM.mouse_y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0):
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		_user_0()
