extends "res://objects/obj_settings_button.gd"

var c_color: float = 0.0

# from objects/obj_profile/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.0
	image_index = 0.0
	effect_hover = 0.0
	anim = 0.0
	c_color = GM.make_color_rgb(89.0, 15.0, 16.0)

# from objects/obj_profile/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_text(x + 30.0, y + 4.0, GM.string_hash_to_newline(G.my1))
	GM.draw_set_color(GM.c_gray)
	if GM.veq(G.my1, 0.0) or GM.veq(G.my2, 0.0) or GM.veq(G.my3, -1.0) or GM.veq(G.my4, -1.0) or GM.veq(G.my5, 0.0) or GM.veq(G.my6, -1.0):
		GM.draw_text(x + 30.0, y + 12.0, "OpenWE")
	else:
		GM.draw_text(x + 30.0, y + 12.0, "OpenWE")
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)

# from objects/obj_profile/Mouse_10.gml
func _mouse_10() -> void:
	var cursor = GM.instance_find(A.obj_cursor, 0)
	if cursor != null and cursor.active_menu == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_paloma_move)
			GM.audio_play_sound(A.snd_paloma_move, 0.0, false)
		effect_hover = 1.0

# from objects/obj_profile/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
