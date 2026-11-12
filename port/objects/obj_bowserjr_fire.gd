extends "res://objects/obj_bowser_fire.gd"

var x_scale: float = 0.0
var y_scale: float = 0.0


# from objects/obj_bowserjr_fire/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	direct = 1.0
	x_scale = 0.1
	y_scale = 0.1
	gravity = 0.0
	if GM.instance_exists(A.obj_mario):
		move_towards_point(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 16.0), 1.0)
	else:
		move_towards_point(GM.instance_find(A.obj_levelmanager, 0).x, GM.instance_find(A.obj_levelmanager, 0).y, 1.0)


# from objects/obj_bowserjr_fire/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -7.0
	image_angle -= (15.0 * GM.gm_sign(hspeed))
	if x_scale >= 0.8:
		x_scale = 0.8
		y_scale = 0.8
	else:
		x_scale += 0.03
		y_scale += 0.03


# from objects/obj_bowserjr_fire/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, y_scale, y_scale, image_angle, GM.c_white, 1.0)
