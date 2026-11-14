extends GMObject

var follow_x = null
var follow_y = null


# from objects/obj_silbido/Create_0.gml
func _create() -> void:
	follow_x = 0.0
	follow_y = 0.0
	visible = false


# from objects/obj_silbido/Step_0.gml
func _step() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + follow_x)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + follow_y)
