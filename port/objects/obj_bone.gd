# from objects/obj_bone（第 6e 批移植，已核对）
extends "res://objects/obj_wrench.gd"

var direct: float = 0.0


# from objects/obj_bone/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	direct = 1.0


# from objects/obj_bone/Step_0.gml
func _step() -> void:
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0) or (x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 128.0) and y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0)) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 128.0):
		instance_destroy()
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -7.0
	if GM.instance_exists(A.obj_deadmario):
		speed = 0.0
	if not GM.instance_exists(A.obj_deadmario):
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 14.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
			image_angle -= (4.0 * GM.gm_sign(hspeed))
		else:
			image_angle -= (8.0 * GM.gm_sign(hspeed))


# from objects/obj_bone/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
