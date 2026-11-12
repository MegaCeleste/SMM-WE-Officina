extends "res://objects/obj_wrench.gd"


# from objects/obj_rorock/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	angle = 0.0
	alarm[1] = 360.0
	alarm[2] = 480.0


# from objects/obj_rorock/Step_0.gml
func _step() -> void:
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0) or (x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 128.0) and y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0)) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 128.0):
		instance_destroy()
	if not GM.instance_exists(A.obj_deadmario):
		angle -= (6.0 * GM.gm_sign(hspeed))
	if GM.instance_exists(A.obj_deadmario):
		speed = 0.0


# from objects/obj_rorock/Alarm_2.gml
func _alarm_2() -> void:
	_user_0()


# from objects/obj_rorock/Other_10.gml
func _user_0() -> void:
	GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)
	instance_destroy()


# from objects/obj_rorock/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, angle, GM.c_white, image_alpha)
