extends "res://objects/obj_panelparent.gd"

var can_time: float = 0.0
var anim: float = 0.0
var text: float = 0.0


# from objects/obj_time/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	can_time = 0.0
	anim = 0.0
	text = 0.0


# from objects/obj_time/Step_1.gml
func _step_begin() -> void:
	if image_speed < 0.0 and image_index <= 0.0:
		if (not GM.instance_exists(A.obj_panel_save_load)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_autoavance)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_condiciones)):
			for inst in GM.with_list(A.obj_editormanager):
				inst.expand_open = 0.0
		instance_destroy()


# from objects/obj_time/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_button_time):
		text = 0.0
	else:
		text = 1.0


# from objects/obj_time/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_cronometro:
		image_speed = 0.0
		image_index = 4.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 106.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0), A.obj_button_time)):
			inst.sprite_index = A.spr_button_time_up
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 106.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_button_time)):
			inst.sprite_index = A.spr_button_time_down
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 83.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 157.0), A.obj_button_ok)
		can_time = 1.0


# from objects/obj_time/Other_10.gml
func _user_0() -> void:
	image_speed = -0.5
	for inst in GM.with_list(A.obj_button_time):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_ok):
		inst.instance_destroy()
	can_time = 0.0
	for inst in GM.with_list(A.obj_panel_time):
		inst.active = 0.0


# from objects/obj_time/Draw_0.gml
func _gm_draw() -> void:
	var posx
	if G.idioma == 1.0:
		posx = -7.0
	elif G.idioma == 4.0:
		posx = 0.0
	elif G.idioma == 3.0:
		posx = -2.0
	else:
		posx = 4.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_font(G.big_digits)
	anim += 0.15
	if can_time == 1.0:
		GM.draw_sprite(A.spr_cronometro_jump, anim, (GM.camera_get_view_x(GM.view_get_camera(0)) + 99.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 73.0))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 100.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 112.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, GM.instance_find(A.obj_levelmanager, 0).leveltime, 3.0)))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	if text == 1.0:
		GM.draw_text((x + (sprite_width / 2.0) + 45.0 + posx - GM.string_width(Scr.scr_language(self, 83.0))), y + 37.0, Scr.scr_language(self, 83.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_time/Mouse_4.gml
func _mouse_4() -> void:
	if image_speed == 0.0 and image_index == 4.0 and GM.mouse_x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 161.0) and GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 172.0) and GM.mouse_y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0):
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		_user_0()
