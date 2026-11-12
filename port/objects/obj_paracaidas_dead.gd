extends "res://objects/obj_deactivation.gd"


# from objects/obj_paracaidas_dead/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	vspeed = -2.2


# from objects/obj_paracaidas_dead/Step_0.gml
func _step() -> void:
	gravity = 0.3
	if vspeed > 4.0:
		vspeed = 4.0
	if y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 216.0):
		instance_destroy()
