extends "res://objects/obj_bowser_fire.gd"


# from objects/obj_NSMBU_bowser_fire/Create_0.gml
func _create() -> void:
	var new_dir: float
	var diff: float
	image_speed = 0.5
	direct = -1.0
	decender = 0.0
	gravity = 0.0
	if GM.instance_exists(A.obj_mario):
		move_towards_point(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 16.0), 0.6)
		new_dir = GM.point_direction(x, y, GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 16.0))
		diff = GM.angle_difference(direction, new_dir)
		direction -= minf((1.0 * GM.gm_sign(diff)), absf(diff))
	else:
		move_towards_point(GM.instance_find(A.obj_levelmanager, 0).x, GM.instance_find(A.obj_levelmanager, 0).y, 0.6)
		new_dir = GM.point_direction(x, y, GM.instance_find(A.obj_levelmanager, 0).x, GM.instance_find(A.obj_levelmanager, 0).y)
		diff = GM.angle_difference(direction, new_dir)
		direction -= minf((1.0 * GM.gm_sign(diff)), absf(diff))


# from objects/obj_NSMBU_bowser_fire/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_smokespin
	instance_destroy()


# from objects/obj_NSMBU_bowser_fire/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, direction, GM.c_white, 1.0)
