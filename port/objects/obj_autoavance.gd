extends "res://objects/obj_panelparent.gd"

var vx: float = 0.0
var text: float = 0.0


# from objects/obj_autoavance/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	if G.idioma == 2.0:
		vx = 25.0
	else:
		vx = 0.0
	text = 0.0


# from objects/obj_autoavance/Step_1.gml
func _step_begin() -> void:
	if image_speed < 0.0 and image_index <= 0.0:
		if (not GM.instance_exists(A.obj_panel_save_load)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_time)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_condiciones)):
			for inst in GM.with_list(A.obj_editormanager):
				inst.expand_open = 0.0
		instance_destroy()


# from objects/obj_autoavance/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_button_autoavance):
		text = 0.0
	else:
		text = 1.0


# from objects/obj_autoavance/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_panel_autoavance_anim:
		image_speed = 0.0
		image_index = 4.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 72.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 61.0), A.obj_button_autoavance)):
			if G.autoavance == 0.0:
				inst.image_index = 1.0
				inst.c_button = 16777215.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 72.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 84.0), A.obj_button_autoavance)):
			inst.sprite = A.spr_btn_autoscroll_slow
			inst.text = Scr.scr_language(inst, 40.0)
			inst.value = 1.0
			if G.autoavance == 1.0:
				inst.image_index = 1.0
				inst.c_button = 16777215.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 72.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 107.0), A.obj_button_autoavance)):
			inst.sprite = A.spr_btn_autoscroll_medium
			inst.text = Scr.scr_language(inst, 41.0)
			inst.value = 2.0
			if G.autoavance == 2.0:
				inst.image_index = 1.0
				inst.c_button = 16777215.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 72.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_button_autoavance)):
			inst.sprite = A.spr_btn_autoscroll_fast
			inst.text = Scr.scr_language(inst, 42.0)
			inst.value = 3.0
			if G.autoavance == 3.0:
				inst.image_index = 1.0
				inst.c_button = 16777215.0
		GM.other = _o
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 103.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), A.obj_button_ok)


# from objects/obj_autoavance/Other_10.gml
func _user_0() -> void:
	image_speed = -0.5
	for inst in GM.with_list(A.obj_button_autoavance):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_ok):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_card_autoavance):
		inst.active = 0.0


# from objects/obj_autoavance/Draw_0.gml
func _gm_draw() -> void:
	var posx
	if G.idioma == 1.0:
		posx = 7.0
	elif G.idioma == 0.0:
		posx = 2.0
	elif G.idioma == 2.0:
		posx = 20.0
	elif G.idioma == 3.0:
		posx = 28.0
	else:
		posx = 2.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	if text == 1.0:
		GM.draw_text((x + (sprite_width / 2.0) + 45.0 + posx - GM.string_width(Scr.scr_language(self, 82.0))), y + 37.0, Scr.scr_language(self, 82.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_autoavance/Mouse_4.gml
func _mouse_4() -> void:
	if image_speed == 0.0 and image_index == 4.0 and GM.mouse_x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 201.0) and GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 212.0) and GM.mouse_y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0):
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		_user_0()
