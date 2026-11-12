# from objects/obj_leafmaker（第 7 批移植，已核对）
extends "res://objects/obj_rainmaker.gd"

var snow_sys: float = 0.0
var snow: float = 0.0


# from objects/obj_leafmaker/Create_0.gml
func _create() -> void:
	var leaf
	snow_sys = GM.part_system_create()
	ind = 1.0
	snow = GM.part_type_create()
	match G.apariencia:
		0.0:
			leaf = A.spr_SMB_hoja
		1.0:
			leaf = A.spr_SMB3_hoja
		2.0:
			leaf = A.spr_hoja
		3.0:
			leaf = A.spr_NSMBU_hoja
	GM.part_type_sprite(snow, leaf, false, false, false)
	GM.part_system_depth(snow_sys, -8.0)
	GM.part_type_size(snow, 0.3, 0.8, 0.0, 0.0)
	GM.part_type_life(snow, 216.0, 432.0)
	GM.part_type_speed(snow, 0.5, 1.0, 0.0, 0.0)
	GM.part_type_direction(snow, 240.0, 260.0, 0.05, 0.1)
	GM.part_type_colour1(snow, 16777215)
	emitter = GM.part_emitter_create(snow_sys)
	GM.part_emitter_stream(snow_sys, emitter, snow, 1.0)
	GM.part_emitter_region(snow_sys, emitter, (GM.camera_get_view_x(GM.view_get_camera(0)) - 600.0), ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 600.0), GM.camera_get_view_y(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 3, 0)
	GM.part_system_update(snow_sys)


# from objects/obj_leafmaker/Destroy_0.gml
func _destroy() -> void:
	GM.part_emitter_destroy_all(snow_sys)
	GM.part_type_destroy(snow)
	GM.part_system_destroy(snow_sys)


# from objects/obj_leafmaker/Step_2.gml
func _step_end() -> void:
	GM.part_emitter_region(snow_sys, emitter, (GM.camera_get_view_x(GM.view_get_camera(0)) - 600.0), ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 600.0), GM.camera_get_view_y(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 3, 0)


# from objects/obj_leafmaker/Other_10.gml
func _user_0() -> void:
	if ind == 1.0:
		ind = 0.0
	else:
		ind = 1.0
	GM.part_system_automatic_update(snow_sys, ind)
