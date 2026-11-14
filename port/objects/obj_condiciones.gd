extends "res://objects/obj_panelparent.gd"

var can_draw: float = 0.0
var texto: Array = []
var text: float = 0.0


# from objects/obj_condiciones/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	can_draw = 0.0
	GM.aset(texto, 0, Scr.scr_language(self, 46.0))
	GM.aset(texto, 1, Scr.scr_language(self, 47.0))
	GM.aset(texto, 2, Scr.scr_language(self, 48.0))
	GM.aset(texto, 3, Scr.scr_language(self, 49.0))
	text = 0.0


# from objects/obj_condiciones/Step_1.gml
func _step_begin() -> void:
	if image_speed < 0.0 and image_index <= 0.0:
		if (not GM.instance_exists(A.obj_panel_save_load)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_time)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_autoavance)):
			for inst in GM.with_list(A.obj_editormanager):
				inst.expand_open = 0.0
		instance_destroy()


# from objects/obj_condiciones/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_tabs_condiciones):
		text = 0.0
	else:
		text = 1.0


# from objects/obj_condiciones/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_panel_condiciones:
		image_speed = 0.0
		image_index = 3.0
		can_draw = 1.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 83.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 86.0), A.obj_tabs_condiciones)):
			inst.index = 0.0
			inst.text = Scr.scr_language(inst, 43.0)
			inst.selected = 1.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 160.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 86.0), A.obj_tabs_condiciones)):
			inst.index = 1.0
			inst.text = Scr.scr_language(inst, 44.0)
			inst.disabled = 1.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 237.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 86.0), A.obj_tabs_condiciones)):
			inst.index = 2.0
			inst.text = Scr.scr_language(inst, 45.0)
			inst.disabled = 1.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 313.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 64.0), A.obj_tabs_condiciones)):
			inst.sprite_index = A.spr_conditions_clear
			inst.index = 3.0
			if G.condiciones == 1.0:
				inst.disabled = 0.0
			else:
				inst.disabled = 1.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 100.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 107.0), A.obj_condiciones_button)):
			inst.sprite_index = A.spr_condiciones_button_up
			if G.condiciones_count == 3.0:
				inst.image_index = 1.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 100.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), A.obj_condiciones_button)):
			inst.sprite_index = A.spr_condiciones_button_down
			if G.condiciones_count == 0.0:
				inst.image_index = 1.0
		GM.other = _o
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 224.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 154.0), A.obj_button_ok)


# from objects/obj_condiciones/Other_10.gml
func _user_0() -> void:
	image_speed = -0.5
	can_draw = 0.0
	for inst in GM.with_list(A.obj_condiciones_button):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_tabs_condiciones):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_ok):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_card_condiciones):
		inst.active = 0.0
	if G.condiciones == 0.0:
		G.condiciones_clear = 0.0
		G.condiciones_type = 0.0
		G.condiciones_count = 0.0


# from objects/obj_condiciones/Draw_0.gml
func _gm_draw() -> void:
	var posx
	if G.idioma == 1.0:
		posx = 8.0
	elif G.idioma == 4.0:
		posx = 4.0
	else:
		posx = 18.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if can_draw == 1.0:
		if G.condiciones_type == 0.0:
			GM.draw_sprite(A.spr_cond_icons, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 91.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 120.0))
			GM.draw_set_font(G.font_google)
			GM.draw_set_color(GM.c_white)
			GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 118.0), GM.string_hash_to_newline(texto[int(G.condiciones_count)]))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	if text == 1.0:
		GM.draw_text((x + (sprite_width / 2.0) + 45.0 + posx - GM.string_width(Scr.scr_language(self, 84.0))), y + 37.0, Scr.scr_language(self, 84.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_condiciones/Mouse_4.gml
func _mouse_4() -> void:
	if image_speed == 0.0 and image_index == 3.0 and GM.mouse_x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 326.0) and GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 337.0) and GM.mouse_y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0):
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		_user_0()
