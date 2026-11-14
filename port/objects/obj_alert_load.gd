extends GMObject

var c_title: float = 0.0


# from objects/obj_alert_load/Create_0.gml
func _create() -> void:
	c_title = GM.make_colour_rgb(89.0, 15.0, 16.0)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_noti_load_button)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 282.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0), A.obj_load_btn_c)


# from objects/obj_alert_load/Destroy_0.gml
func _destroy() -> void:
	for _obj_write1 in GM.with_list(A.obj_editormanager):
		_obj_write1.expand_open = 0.0
	var _with_target3 = A.obj_noti_load_button
	var _other2: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target3):
		inst.instance_destroy()
	GM.other = _other2
	var _with_target5 = A.obj_load_btn_c
	var _other4: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target5):
		inst.instance_destroy()
	GM.other = _other4


# from objects/obj_alert_load/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_expand_bg, 1.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), (GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0), (GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0), 0.0, GM.c_white, 1.0)
	GM.draw_sprite_stretched(sprite_index, 0.0, x, y, 216.0, 100.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_title)
	GM.draw_text((x + 9.0), (y + 16.0), GM.string_hash_to_newline(Scr.scr_language(self, 89.0)))
