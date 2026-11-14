extends "res://objects/obj_button_parent.gd"

var press: float = 0.0


# from objects/obj_button_ok/Create_0.gml
func _create() -> void:
	super._create()
	text = Scr.scr_language(self, 28.0)
	anim = 0.0
	press = 0.0
	alarm[0] = 5.0


# from objects/obj_button_ok/Alarm_0.gml
func _alarm_0() -> void:
	press = 1.0


# from objects/obj_button_ok/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_button)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0) + 4.0), y, GM.string_hash_to_newline((text)))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_button_ok/Mouse_4.gml
func _mouse_4() -> void:
	if press == 1.0:
		GM.audio_stop_sound(A.snd_panel_close)
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		if GM.instance_exists(A.obj_time):
			for inst in GM.with_list(A.obj_time):
				inst.event_user(0)
		elif GM.instance_exists(A.obj_autoavance):
			for inst in GM.with_list(A.obj_autoavance):
				inst.event_user(0)
		elif GM.instance_exists(A.obj_condiciones):
			G.condiciones = 1.0
			for inst in GM.with_list(A.obj_condiciones):
				inst.event_user(0)
		GM.other = _o


# from objects/obj_button_ok/KeyPress_13.gml
func _keypress_13() -> void:
	if press == 1.0:
		GM.audio_stop_sound(A.snd_panel_close)
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		if GM.instance_exists(A.obj_time):
			for inst in GM.with_list(A.obj_time):
				inst.event_user(0)
		elif GM.instance_exists(A.obj_autoavance):
			for inst in GM.with_list(A.obj_autoavance):
				inst.event_user(0)
		elif GM.instance_exists(A.obj_condiciones):
			G.condiciones = 1.0
			for inst in GM.with_list(A.obj_condiciones):
				inst.event_user(0)
		GM.other = _o
