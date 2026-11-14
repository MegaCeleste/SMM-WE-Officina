extends "res://objects/obj_button_close.gd"


# from objects/obj_zoomclose/Step_0.gml
func _step() -> void:
	x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 40.0)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 8.0)


# from objects/obj_zoomclose/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, 0.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 40.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 8.0), 2.0, 2.0, 0.0, GM.c_white, 1.0)


# from objects/obj_zoomclose/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 2.0:
		for inst in GM.with_list(A.obj_editormanager):
			inst.zoom = 3.0
		instance_destroy()
