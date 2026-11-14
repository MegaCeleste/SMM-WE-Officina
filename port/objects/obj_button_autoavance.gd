extends "res://objects/obj_button_parent.gd"

var sprite: float = 0.0
var index: float = 0.0
var value: float = 0.0


# from objects/obj_button_autoavance/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_btn_autoscroll_disabled
	index = 0.0
	c_button = GM.make_colour_rgb(89.0, 15.0, 16.0)
	text = Scr.scr_language(self, 39.0)
	anim = 0.0
	value = 0.0


# from objects/obj_button_autoavance/Step_2.gml
func _step_end() -> void:
	if image_index == 1.0:
		index += 0.15
	else:
		index = 0.0


# from objects/obj_button_autoavance/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_sprite(sprite, index, (x + 16.0), y)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_button)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text(((x + 29.0) + 49.0), (y + 4.0), GM.string_hash_to_newline((text)))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 0.0)


# from objects/obj_button_autoavance/Mouse_4.gml
func _mouse_4() -> void:
	if value != G.autoavance:
		GM.audio_stop_sound(A.snd_aceptar)
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		G.autoavance = value
		for inst in GM.with_list(A.obj_button_autoavance):
			inst.image_index = 0.0
			inst.c_button = GM.make_colour_rgb(89.0, 15.0, 16.0)
		image_index = 1.0
		c_button = 16777215.0
	else:
		GM.audio_stop_sound(A.snd_wrong)
		GM.audio_play_sound(A.snd_wrong, 0.0, false)


# from objects/obj_button_autoavance/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_panel_right_move)
		GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_autoavance/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
