extends GMObject

var c_button: float = 0.0
var text = null
var effect_hover: float = 0.0
var anim: float = 0.0
var posy: float = 0.0
var alpha: float = 0.0
var time: float = 0.0


# from objects/obj_button_parent/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	c_button = GM.make_colour_rgb(89.0, 15.0, 16.0)
	text = Scr.scr_language(self, 28.0)
	effect_hover = 0.0
	anim = 0.0
	posy = 3.0
	alpha = 1.0
	time = 0.0


# from objects/obj_button_parent/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_button)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0)), (y + posy), GM.string_hash_to_newline((text)))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_button_parent/Mouse_10.gml
func _mouse_10() -> void:
	if time == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_button_parent/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
	alpha = 1.0
