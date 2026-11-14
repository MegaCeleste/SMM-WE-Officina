extends GMObject

var selected: float = 0.0
var disabled: float = 0.0
var index: float = 0.0
var text = null
var anim: float = 0.0
var effect_hover: float = 0.0
var c_color: float = 0.0


# from objects/obj_tabs_condiciones/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	selected = 0.0
	disabled = 0.0
	index = 0.0
	text = ""
	anim = 0.0
	effect_hover = 0.0
	c_color = GM.c_white


# from objects/obj_tabs_condiciones/Draw_0.gml
func _gm_draw() -> void:
	if disabled == 1.0:
		image_index = 2.0
		c_color = GM.make_color_rgb(160.0, 160.0, 160.0)
	elif selected == 1.0:
		image_index = 1.0
		c_color = GM.make_color_rgb(255.0, 255.0, 255.0)
	else:
		image_index = 0.0
		c_color = GM.make_color_rgb(89.0, 15.0, 16.0)
	draw_self()
	if effect_hover == 1.0 and disabled == 0.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0)), y, GM.string_hash_to_newline(text))
	GM.draw_set_halign(GM.fa_left)


# from objects/obj_tabs_condiciones/Mouse_4.gml
func _mouse_4() -> void:
	if disabled == 0.0:
		if index == 3.0:
			G.condiciones = 0.0
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_condiciones):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_tabs_condiciones/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_panel_right_move)
		GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_tabs_condiciones/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
