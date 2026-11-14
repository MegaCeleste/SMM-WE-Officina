extends GMObject

var anim: float = 0.0
var effect_hover: float = 0.0
var c_disabled: float = 0.0
var c_color = null
var text: String = ""


# from objects/obj_button_settings_sombras/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	anim = 0.0
	effect_hover = 0.0
	c_disabled = GM.make_colour_rgb(110.0, 119.0, 126.0)
	c_color = c_disabled
	text = "Desactivado"


# from objects/obj_button_settings_sombras/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_text((x + 25.0), (y + 1.0), GM.string_hash_to_newline(text))
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_button_settings_sombras/Mouse_4.gml
func _mouse_4() -> void:
	pass


# from objects/obj_button_settings_sombras/Mouse_10.gml
func _mouse_10() -> void:
	pass


# from objects/obj_button_settings_sombras/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
