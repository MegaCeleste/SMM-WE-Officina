extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0
var c_color: float = 0.0


# from objects/obj_button_save_load/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	effect_hover = 0.0
	anim = 0.0
	c_color = GM.make_color_rgb(199.0, 61.0, 71.0)


# from objects/obj_button_save_load/Draw_0.gml
func _gm_draw() -> void:
	var ypos
	if G.idioma == 1.0:
		ypos = 7.0
	else:
		ypos = 0.0
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)
	if sprite_index == A.spr_button_save:
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(c_color)
		GM.draw_set_halign(GM.fa_left)
		GM.draw_set_valign(GM.fa_top)
		GM.draw_text(x + 15.0, y + 4.0 + ypos, GM.string_hash_to_newline(Scr.scr_language(self, 104.0)))
	elif sprite_index == A.spr_button_load:
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(c_color)
		GM.draw_set_halign(GM.fa_left)
		GM.draw_set_valign(GM.fa_top)
		GM.draw_text(x + 15.0, y + 1.5, GM.string_hash_to_newline(Scr.scr_language(self, 106.0)))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_button_save_load/Mouse_4.gml
func _mouse_4() -> void:
	GM.audio_play_sound(A.snd_select_guardabot, 0.0, false)
	if sprite_index == A.spr_button_save:
		if GM.instance_exists(A.obj_panel_save_load):
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_panel_save_load):
				inst.event_user(0)
			GM.other = _o1
			for inst in GM.with_list(A.obj_robot):
				inst.active = 0.0
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 2.0
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_window_alert)
	elif sprite_index == A.spr_button_load:
		if GM.instance_exists(A.obj_panel_save_load):
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_panel_save_load):
				inst.event_user(0)
			GM.other = _o2
			for inst in GM.with_list(A.obj_robot):
				inst.active = 0.0
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 2.0
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 84.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 55.0), A.obj_alert_load)


# from objects/obj_button_save_load/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_panel_right_move)
		GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_save_load/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
