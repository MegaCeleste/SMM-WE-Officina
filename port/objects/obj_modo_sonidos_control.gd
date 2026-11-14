extends GMObject


# from objects/obj_modo_sonidos_control/Draw_0.gml
func _gm_draw() -> void:
	var offsetx
	GM.draw_sprite_ext(sprite_index, 1.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), (GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0), (GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0), 0.0, GM.c_white, 1.0)
	if GM.instance_exists(A.obj_erase) and GM.instance_find(A.obj_erase, 0).active == 0.0:
		if G.idioma == 1.0:
			offsetx = (GM.string_width(Scr.scr_language(self, 23.0)) - 9.0)
		elif G.idioma == 2.0:
			offsetx = (GM.string_width(Scr.scr_language(self, 23.0)) + 5.0)
		elif G.idioma == 3.0:
			offsetx = 22.0
		elif G.idioma == 4.0:
			offsetx = (GM.string_width(Scr.scr_language(self, 23.0)) + 4.0)
		else:
			offsetx = (GM.string_width(Scr.scr_language(self, 23.0)) - 12.5)
		GM.draw_sprite(A.spr_minitabs_en, 0.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 60.0) - GM.instance_find(A.obj_cursor, 0).anim_left), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 34.0) - GM.instance_find(A.obj_cursor, 0).anim_top))
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(GM.c_white)
		GM.draw_set_halign(GM.fa_left)
		GM.draw_text(((GM.camera_get_view_x(GM.view_get_camera(0)) + 27.0) + GM.sprite_get_width(A.spr_minitabs_en) / 2.0 + offsetx - GM.instance_find(A.obj_cursor, 0).anim_left), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 33.0) - GM.instance_find(A.obj_cursor, 0).anim_top), Scr.scr_language(self, 23.0))
	GM.draw_set_halign(GM.fa_left)
