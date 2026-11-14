extends GMObject

var cond_count: float = 0.0
var texto: Array = []
var start: float = 0.0
var lose: float = 0.0


# from objects/obj_alert_condicion/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	cond_count = G.condiciones_count
	GM.aset(texto, 0, Scr.scr_language(self, 46.0))
	GM.aset(texto, 1, Scr.scr_language(self, 47.0))
	GM.aset(texto, 2, Scr.scr_language(self, 48.0))
	GM.aset(texto, 3, Scr.scr_language(self, 49.0))
	alarm[0] = 180.0
	start = 0.0
	lose = 0.0


# from objects/obj_alert_condicion/Alarm_0.gml
func _alarm_0() -> void:
	instance_destroy()


# from objects/obj_alert_condicion/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_cond_alert, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 98.0), 17.0, 3.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite(A.spr_cond_icons, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 65.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 103.0))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 106.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), GM.string_hash_to_newline(texto[int(cond_count)]))
	if lose == 1.0:
		GM.draw_set_color(GM.make_colour_rgb(255.0, 112.0, 51.0))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 106.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 127.0), GM.string_hash_to_newline(Scr.scr_language(self, 171.0)))
