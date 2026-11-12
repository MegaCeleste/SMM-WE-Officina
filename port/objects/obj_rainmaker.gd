# from objects/obj_rainmaker（第 7 批移植，已核对）
extends GMObject

var rain_sys: float = 0.0
var ind: float = 0.0
var rain: float = 0.0
var emitter: float = 0.0


# from objects/obj_rainmaker/Create_0.gml
func _create() -> void:
	rain_sys = GM.part_system_create()
	ind = 1.0
	GM.part_system_depth(rain_sys, -8.0)
	rain = GM.part_type_create()
	GM.part_type_sprite(rain, A.spr_rain, false, false, true)
	GM.part_type_alpha1(rain, 0.8)
	GM.part_type_speed(rain, 7.0, 15.0, 0.0, 0.0)
	GM.part_type_direction(rain, 240.0, 240.0, 0.0, 0.0)
	GM.part_type_colour1(rain, 16777215)
	emitter = GM.part_emitter_create(rain_sys)
	GM.part_emitter_stream(rain_sys, emitter, rain, 5.0)
	GM.part_emitter_region(rain_sys, emitter, (GM.camera_get_view_x(GM.view_get_camera(0)) - 600.0), ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 600.0), 0.0, 0.0, 3, 0)
	for _rep in range(5):
		GM.part_system_update(rain_sys)


# from objects/obj_rainmaker/Destroy_0.gml
func _destroy() -> void:
	GM.part_emitter_destroy_all(rain_sys)
	GM.part_type_destroy(rain)
	GM.part_system_destroy(rain_sys)


# from objects/obj_rainmaker/Step_2.gml
func _step_end() -> void:
	GM.part_emitter_region(rain_sys, emitter, (GM.camera_get_view_x(GM.view_get_camera(0)) - 600.0), ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 600.0), 0.0, 0.0, 3, 0)


# from objects/obj_rainmaker/Other_10.gml
func _user_0() -> void:
	if ind == 1.0:
		ind = 0.0
	else:
		ind = 1.0
	GM.part_system_automatic_update(rain_sys, ind)
