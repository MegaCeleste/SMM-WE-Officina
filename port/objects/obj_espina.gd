# from objects/obj_espina（第 5 批移植，已核对）
extends GMObject

var rotacion: float = 0.0


# from objects/obj_espina/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	rotacion = 0.0
	alarm[0] = 360.0
	alarm[1] = 480.0


# from objects/obj_espina/Step_2.gml
func _step_end() -> void:
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		instance_destroy()
	if GM.instance_exists(A.obj_deadmario):
		speed = 0.0


# from objects/obj_espina/Alarm_0.gml
func _alarm_0() -> void:
	if image_alpha == 1.0:
		image_alpha = 0.0
	else:
		image_alpha = 1.0
	alarm[0] = 7.0


# from objects/obj_espina/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_espina/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_espina/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, image_alpha)
