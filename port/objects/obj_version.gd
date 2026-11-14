extends GMObject

var color: float = 0.0

# from objects/obj_version/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	color = GM.c_white
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(color)

# from objects/obj_version/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_set_font(G.font_google_legacy)
	GM.draw_set_color(color)
	GM.draw_text(x, y, GM.string_hash_to_newline(G.ver))
	GM.draw_set_font(G.font_google)
