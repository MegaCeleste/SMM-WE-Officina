extends GMObject

var ready_v: float = 0.0
var pos: float = 0.0


# from objects/obj_load_image/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	pos = 0.0


# from objects/obj_load_image/Step_0.gml
func _step() -> void:
	image_angle -= 8.0
	if pos == 0.0:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 338.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 198.0)
	else:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 357.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 192.0)


# from objects/obj_load_image/Alarm_1.gml
func _alarm_1() -> void:
	for _obj_write1 in GM.with_list(A.obj_editormanager):
		_obj_write1.expand_open = 0.0
	instance_destroy()


# from objects/obj_load_image/Draw_0.gml
func _gm_draw() -> void:
	if ready_v == 1.0:
		GM.draw_sprite_ext(A.spr_expand_bg, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), (GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0), (GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0), 0.0, GM.c_white, 1.0)
	draw_self()
