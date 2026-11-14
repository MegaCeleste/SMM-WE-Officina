extends GMObject

var page: float = 0.0


# from objects/obj_header/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	page = 0.0
	# image_speed = 0
	# page = 0
	# c_color = make_colour_rgb(89, 15, 16)
	# posy = 3
	# if page = 0
	# 	image_index = 0
	# else if page = 1
	# 	image_index = 0
	# else if page = 2
	# 	image_index = 1
	# else if page = 3
	# 	image_index = 2
	# else if page = 4
	# 	image_index = 2
	# else if page = 5
	# 	image_index = 2
	# else if page = 6
	# 	image_index = 2
	# else if page = 7
	# 	image_index = 2
	# else if page = 8
	# 	image_index = 2
	# else
	# 	image_index = 3


# from objects/obj_header/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_btn_header_parent):
		inst.instance_destroy()
	# with (obj_btn_header_1)
	#    instance_destroy()
	# with (obj_btn_header_2)
	#    instance_destroy()
	# with (obj_btn_header_3)
	#    instance_destroy()
	# with (obj_btn_header_4)
	#    instance_destroy()


# from objects/obj_header/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_find(A.obj_panel_expand, 0).header != 0.0:
		if not GM.instance_exists(A.obj_btn_header_1):
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 1.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 14.0), A.obj_btn_header_1)
	if GM.instance_find(A.obj_panel_expand, 0).header != 1.0:
		if not GM.instance_exists(A.obj_btn_header_2):
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 2.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 14.0), A.obj_btn_header_2)
	if GM.instance_find(A.obj_panel_expand, 0).header != 2.0:
		if not GM.instance_exists(A.obj_btn_header_3):
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 3.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 14.0), A.obj_btn_header_3)
	if GM.instance_find(A.obj_panel_expand, 0).header != 3.0:
		if not GM.instance_exists(A.obj_btn_header_4):
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 4.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 14.0), A.obj_btn_header_4)


# from objects/obj_header/Draw_0.gml
func _gm_draw() -> void:
	var index: float = GM.instance_find(A.obj_panel_expand, 0).header
	var c_color = GM.make_colour_rgb(89.0, 15.0, 16.0)
	var posy = 3.0
	GM.draw_sprite_ext(sprite_index, index, x, y, image_xscale, image_yscale, 0.0, GM.c_white, image_alpha)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_set_valign(GM.fa_top)
	match index:
		0.0:
			GM.draw_text((x + (sprite_width / 2.0)), (y + posy + 1.0), Scr.scr_language(self, 66.0))
		1.0:
			GM.draw_text((x + (sprite_width / 2.0)), (y + posy + 1.0), Scr.scr_language(self, 67.0))
		2.0:
			GM.draw_text((x + (sprite_width / 2.0)), (y + posy + 1.0), Scr.scr_language(self, 68.0))
		3.0:
			GM.draw_text((x + (sprite_width / 2.0)), (y + posy + 1.0), Scr.scr_language(self, 69.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)
