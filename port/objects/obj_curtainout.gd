extends GMObject

var target: float = -4.0
var back: int = -1
var scale: float = 0.0
var surf: int = -1
var surf_colour: int = 0


# from objects/obj_curtainout/Create_0.gml
func _create() -> void:
	target = -4.0
	back = int(Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)), 0.0, 0.0))
	scale = 300.0
	surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	surf_colour = 0


# from objects/obj_curtainout/CleanUp_0.gml
func _cleanup() -> void:
	if GM.surface_exists(surf):
		GM.surface_free(surf)
	# PORT: The captured sprite is owned by this transition.
	GM.sprite_delete(back)


# from objects/obj_curtainout/Step_0.gml
func _step() -> void:
	_user_0()
	if not GM.surface_exists(surf):
		surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	else:
		GM.surface_set_target(surf)
		GM.draw_clear(GM.c_white - surf_colour)
		GM.gpu_set_blendmode(GM.bm_subtract)
		Scr.draw_circle_colour_precise(self, (x - GM.camera_get_view_x(GM.view_get_camera(0))), (y - GM.camera_get_view_y(GM.view_get_camera(0))), scale, GM.c_white, GM.c_white, false, 64.0)
		GM.gpu_set_blendmode(GM.bm_normal)
		GM.surface_reset_target()


# from objects/obj_curtainout/Other_10.gml
func _user_0() -> void:
	x = GM.gm_round(x)
	y = GM.gm_round(y)
	scale += -6.25
	if scale < 0.0:
		if GM.instance_number(A.obj_fadein) == 0:
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_fadein)):
				inst.target = self.target


# from objects/obj_curtainout/Draw_0.gml
func _gm_draw() -> void:
	GM.gpu_set_blendmode(GM.bm_subtract)
	GM.draw_surface(surf, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
	GM.gpu_set_blendmode(GM.bm_normal)
