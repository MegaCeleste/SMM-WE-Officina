extends GMObject


# from objects/obj_water_level_control/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 350.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 19.0), A.obj_bt_close_water)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 242.0), GM.instance_find(A.obj_card_bout, 0).pos_y, A.obj_water_move)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 222.0), GM.instance_find(A.obj_card_bout, 0).pos_y_limit, A.obj_water_move_limit)


# from objects/obj_water_level_control/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_bt_close_water):
		for inst in GM.with_list(A.obj_bt_close_water):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_water_move_limit):
		for inst in GM.with_list(A.obj_water_move_limit):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_water_move):
		for inst in GM.with_list(A.obj_water_move):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_ventana_water):
		for inst in GM.with_list(A.obj_ventana_water):
			inst.can_anim2 = 1.0


# from objects/obj_water_level_control/Step_2.gml
func _step_end() -> void:
	x = GM.camera_get_view_x(GM.view_get_camera(0))
	y = GM.camera_get_view_y(GM.view_get_camera(0))


# from objects/obj_water_level_control/Draw_0.gml
func _gm_draw() -> void:
	var offsetx
	var texto
	GM.draw_sprite_ext(sprite_index, 1.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), (GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0), (GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0), 0.0, GM.c_white, 1.0)
	if G.idioma == 1.0:
		offsetx = (GM.string_width(Scr.scr_language(self, 154.0)) - 28.0)
	elif G.idioma == 2.0:
		offsetx = (GM.string_width(Scr.scr_language(self, 154.0)) - 30.0)
	elif G.idioma == 3.0:
		offsetx = 1.0
	elif G.idioma == 4.0:
		offsetx = (GM.string_width(Scr.scr_language(self, 154.0)) - 27.0)
	else:
		offsetx = (GM.string_width(Scr.scr_language(self, 154.0)) - 30.0)
	if G.bg_level == "forest" or G.bg_level == "beach":
		GM.draw_sprite(A.spr_minitabs_en, 1.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
		texto = 154.0
	else:
		GM.draw_sprite(A.spr_minitabs_en, 2.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
		texto = 155.0
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_text(((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.sprite_get_width(A.spr_minitabs_en) / 2.0 - offsetx), ((GM.camera_get_view_y(GM.view_get_camera(0)) - 1.0)), Scr.scr_language(self, texto))
	GM.draw_set_halign(GM.fa_left)
