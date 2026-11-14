extends GMObject

var effect_hover: float = 0.0
var c_disabled: float = 0.0
var c_color = null
var text = null


# from objects/obj_configurar_controles/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	effect_hover = 0.0
	c_disabled = GM.make_colour_rgb(110.0, 119.0, 126.0)
	c_color = c_disabled
	text = Scr.scr_language(self, 187.0)


# from objects/obj_configurar_controles/Destroy_0.gml
func _destroy() -> void:
	GM.instance_destroy(A.obj_configurar_controles_reset)


# from objects/obj_configurar_controles/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_text((x + 33.0), (y + 6.0), GM.string_hash_to_newline(text))
	if effect_hover == 1.0:
		# The source sprite is absent from the project; this hover state is never set.
		var hover_sprite: int = GM.asset_get_index("spr_settings_button_big_hover")
		if hover_sprite >= 0:
			GM.draw_sprite(hover_sprite, 0.0, x, y)


# from objects/obj_configurar_controles/Mouse_10.gml
func _mouse_10() -> void:
	pass


# from objects/obj_configurar_controles/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
