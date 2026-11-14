extends "res://objects/obj_button_parent.gd"

# from objects/obj_btn_invitado/Create_0.gml
func _create() -> void:
	super._create()
	c_button = 16777215.0
	text = Scr.scr_language(self, 11.0)

# from objects/obj_btn_invitado/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, effect_hover, x, y, 1.0, 1.0, 0.0, GM.c_white, alpha)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_button)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text(x + sprite_width / 2.0, y + posy + 1.0, GM.string_hash_to_newline(text))
	GM.draw_set_halign(GM.fa_left)

# from objects/obj_btn_invitado/Mouse_4.gml
func _mouse_4() -> void:
	if GM.veq(G.my1, 0.0):
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0, GM.camera_get_view_y(GM.view_get_camera(0)) + 12.0, A.obj_iname_control)
	else:
		GM.room_goto(A.rm_title)
