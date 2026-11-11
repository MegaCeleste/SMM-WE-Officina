# from objects/obj_logo_c/（第 2 批移植，已逐事件核对）
extends GMObject

var c_title: int = 0
var c_letter: int = 0
var x_pos: float = 0.0


# from objects/obj_logo_c/Create_0.gml
func _create() -> void:
	c_title = GM.make_colour_rgb(229.0, 23.0, 42.0)
	c_letter = 16777215
	x_pos = x
	match GM.os_get_language():
		"es":
			G.idioma = 0.0
		"pt":
			G.idioma = 2.0
		"it":
			G.idioma = 3.0
		"zh":
			G.idioma = 4.0
		_:
			G.idioma = 1.0


# from objects/obj_logo_c/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_letter)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text_color(x_pos, (y + 32.0), GM.string_hash_to_newline(Scr.scr_language(self, 0.0)), c_title, c_title, c_title, c_title, 1.0)
	GM.draw_text(x_pos, (y + 66.0), GM.string_hash_to_newline(Scr.scr_language(self, 1.0)))
	GM.draw_set_halign(GM.fa_left)
