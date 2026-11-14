extends "res://objects/obj_button_parent.gd"

var canpress: float = 0.0
var type: float = 0.0
var button_c: float = 0.0


# from objects/obj_pausa_button/Create_0.gml
func _create() -> void:
	super._create()
	canpress = 0.0
	text = Scr.scr_language(self, 152.0)
	type = 0.0
	button_c = GM.c_white
	alarm[0] = 15.0


# from objects/obj_pausa_button/Alarm_0.gml
func _alarm_0() -> void:
	canpress = 1.0


# from objects/obj_pausa_button/Alarm_1.gml
func _alarm_1() -> void:
	var previous_other: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_menu_pausa):
		inst.event_user(int(self.type))
	GM.other = previous_other


# from objects/obj_pausa_button/Alarm_2.gml
func _alarm_2() -> void:
	var previous_other: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_menu_pausa):
		inst.event_user(1)
	GM.other = previous_other


# from objects/obj_pausa_button/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0.0, button_c, 1.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_button)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0)), (y + posy), GM.string_hash_to_newline((text)))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_pausa_button/Mouse_4.gml
func _mouse_4() -> void:
	if (not GM.instance_exists(A.obj_settings_panel)) and canpress == 1.0 and image_index == 0.0:
		match type:
			0.0:
				image_index = 1.0
				GM.audio_play_sound(A.snd_pausa, 0.0, false)
				c_button = 16777215.0
			1.0:
				if G.lives > 1.0 or G.dsm == 0.0:
					image_index = 1.0
					GM.audio_play_sound(A.snd_volver_a_empezar, 0.0, false)
					c_button = 16777215.0
			2.0:
				if G.lives > 0.0 or G.dsm == 0.0:
					image_index = 1.0
					GM.audio_play_sound(A.snd_salir_del_nivel, 0.0, false)
					if G.postnivel != 0.0:
						G.postnivel = 0.0
					c_button = 16777215.0
		alarm[1] = 6.0


# from objects/obj_pausa_button/KeyPress_82.gml
func _keypress_82() -> void:
	if G.lives > 1.0:
		if (not GM.instance_exists(A.obj_settings_panel)) and canpress == 1.0 and type == 1.0 and image_index == 0.0:
			image_index = 1.0
			c_button = 16777215.0
			GM.audio_play_sound(A.snd_volver_a_empezar, 0.0, false)
			alarm[2] = 6.0
	elif G.dsm != 1.0:
		if (not GM.instance_exists(A.obj_settings_panel)) and canpress == 1.0 and type == 1.0 and image_index == 0.0:
			image_index = 1.0
			c_button = 16777215.0
			GM.audio_play_sound(A.snd_volver_a_empezar, 0.0, false)
			alarm[2] = 6.0
