extends GMObject

var scale: float = 0.0
var surf: int = -1
var surf_colour: int = 0
var fallow = null
var listo: float = 0.0


# from objects/obj_curtainin/Create_0.gml
func _create() -> void:
	scale = 0.0
	surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	surf_colour = 0
	fallow = A.obj_lighting
	listo = 0.0
	alarm[0] = 15.0


# from objects/obj_curtainin/CleanUp_0.gml
func _cleanup() -> void:
	if GM.surface_exists(surf):
		GM.surface_free(surf)


# from objects/obj_curtainin/Step_0.gml
func _step() -> void:
	_user_0()
	if _destroyed:
		return
	if not GM.surface_exists(surf):
		surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	else:
		GM.surface_set_target(surf)
		GM.draw_clear(GM.c_white - surf_colour)
		GM.gpu_set_blendmode(GM.bm_subtract)
		Scr.draw_circle_colour_precise(self, (x - GM.camera_get_view_x(GM.view_get_camera(0))), (y - GM.camera_get_view_y(GM.view_get_camera(0))), scale, GM.c_white, GM.c_white, false, 64.0)
		GM.gpu_set_blendmode(GM.bm_normal)
		GM.surface_reset_target()


# from objects/obj_curtainin/Alarm_0.gml
func _alarm_0() -> void:
	listo = 1.0


# from objects/obj_curtainin/Other_10.gml
func _user_0() -> void:
	if GM.veq(fallow, A.obj_lighting):
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0))
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + (GM.camera_get_view_height(GM.view_get_camera(0)) / 2.0))
	if listo == 1.0:
		scale += 6.0
	if scale > 300.0:
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.disablecontrols = 0.0
		instance_destroy()


# from objects/obj_curtainin/Draw_0.gml
func _gm_draw() -> void:
	GM.gpu_set_blendmode(GM.bm_subtract)
	if GM.surface_exists(surf):
		GM.draw_surface(surf, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
	GM.gpu_set_blendmode(GM.bm_normal)
