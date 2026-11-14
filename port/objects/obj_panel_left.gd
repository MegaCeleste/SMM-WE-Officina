extends "res://objects/obj_parent_layout.gd"


# from objects/obj_panel_left/Create_0.gml
func _create() -> void:
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 4.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0), A.obj_logo_game)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 4.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_bg)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 97.0), A.obj_panel_time)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 133.0), A.obj_card_condiciones)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 31.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 70.0), A.obj_card_bout)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 31.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 87.0), A.obj_button_meteoritos)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 159.0), A.obj_button_sdog)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 33.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0), A.obj_button_trail)


# from objects/obj_panel_left/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_logo_game):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_panel_time):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_card_bg):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_card_bout):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_sdog):
		inst.instance_destroy()


# from objects/obj_panel_left/Step_0.gml
func _step() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) - GM.instance_find(A.obj_cursor, 0).anim_left)
	y = GM.camera_get_view_y(GM.view_get_camera(0))


# from objects/obj_panel_left/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) - GM.instance_find(A.obj_cursor, 0).anim_left), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
