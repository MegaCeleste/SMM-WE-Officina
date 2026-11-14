extends GMObject

var c_etiqueta: float = 0.0
var index: float = 0.0
var idd: float = 0.0
var selected: float = 0.0
var disabled: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0
var text_draw: Array = []
var text: Array = []


# from objects/obj_etiquetas/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	c_etiqueta = GM.make_colour_rgb(89.0, 15.0, 16.0)
	index = 0.0
	idd = 0.0
	selected = 0.0
	disabled = 0.0
	effect_hover = 0.0
	anim = 0.0
	GM.aset(text_draw, 0, Scr.scr_language(self, 52.0))
	GM.aset(text_draw, 1, Scr.scr_language(self, 53.0))
	GM.aset(text_draw, 2, Scr.scr_language(self, 54.0))
	GM.aset(text_draw, 3, Scr.scr_language(self, 55.0))
	GM.aset(text_draw, 4, Scr.scr_language(self, 56.0))
	GM.aset(text_draw, 5, Scr.scr_language(self, 57.0))
	GM.aset(text_draw, 6, Scr.scr_language(self, 58.0))
	GM.aset(text_draw, 7, Scr.scr_language(self, 59.0))
	GM.aset(text_draw, 8, Scr.scr_language(self, 60.0))
	GM.aset(text_draw, 9, Scr.scr_language(self, 61.0))
	GM.aset(text_draw, 10, Scr.scr_language(self, 62.0))
	GM.aset(text_draw, 11, Scr.scr_language(self, 63.0))
	GM.aset(text_draw, 12, Scr.scr_language(self, 64.0))
	GM.aset(text_draw, 13, Scr.scr_language(self, 65.0))
	GM.aset(text_draw, 14, "Link")
	GM.aset(text, 0, "Tradicional")
	GM.aset(text, 1, "Puzles")
	GM.aset(text, 2, "Contrarreloj")
	GM.aset(text, 3, "Autoavance")
	GM.aset(text, 4, "Automatismos")
	GM.aset(text, 5, "Corto pero intenso")
	GM.aset(text, 6, "Competitivo")
	GM.aset(text, 7, "Tematico")
	GM.aset(text, 8, "Música")
	GM.aset(text, 9, "Artístico")
	GM.aset(text, 10, "Habilidad")
	GM.aset(text, 11, "Disparos")
	GM.aset(text, 12, "Contra jefes")
	GM.aset(text, 13, "En solitario")
	GM.aset(text, 14, "Link")


# from objects/obj_etiquetas/Step_2.gml
func _step_end() -> void:
	if selected == 1.0:
		c_etiqueta = 16777215.0
		image_index = 1.0
	elif disabled == 1.0:
		c_etiqueta = GM.make_colour_rgb(110.0, 119.0, 126.0)
		image_index = 2.0
	else:
		c_etiqueta = GM.make_colour_rgb(89.0, 15.0, 16.0)
		image_index = 0.0


# from objects/obj_etiquetas/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_etiqueta)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0)), y, GM.string_hash_to_newline(text_draw[int(idd)]))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_etiquetas/Mouse_4.gml
func _mouse_4() -> void:
	if disabled == 0.0:
		if selected == 0.0:
			if G.etiqueta1 == -1.0:
				GM.audio_play_sound(A.snd_aceptar, 0.0, false)
				G.etiqueta1 = idd
				selected = 1.0
				if G.etiqueta1 != -1.0 and G.etiqueta2 != -1.0:
					for inst in GM.with_list(A.obj_etiquetas):
						if inst.selected == 0.0:
							inst.disabled = 1.0
			elif G.etiqueta2 == -1.0:
				GM.audio_play_sound(A.snd_aceptar, 0.0, false)
				G.etiqueta2 = idd
				selected = 1.0
				if G.etiqueta1 != -1.0 and G.etiqueta2 != -1.0:
					for inst in GM.with_list(A.obj_etiquetas):
						if inst.selected == 0.0:
							inst.disabled = 1.0
		else:
			GM.audio_play_sound(A.snd_item_deselect, 0.0, false)
			selected = 0.0
			if G.etiqueta1 == idd:
				G.etiqueta1 = -1.0
			elif G.etiqueta2 == idd:
				G.etiqueta2 = -1.0
			if G.etiqueta1 == -1.0 or G.etiqueta2 == -1.0:
				for inst in GM.with_list(A.obj_etiquetas):
					inst.disabled = 0.0


# from objects/obj_etiquetas/Mouse_10.gml
func _mouse_10() -> void:
	if disabled == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_etiquetas/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
