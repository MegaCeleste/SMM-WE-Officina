extends "res://objects/obj_score.gd"

var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
var limit: float = 0.0  # obj_flagpole 在 instance_create 之后写入


# from objects/obj_score_flag/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_points
		3.0:
			sprite_index = A.spr_NSMBU_points
	image_speed = 0.0
	ready_v = 0.0
	limit = 0.0
	if G.apariencia == 3.0:
		alarm[1] = 150.0
	else:
		alarm[2] = 30.0
		alarm[0] = 1.0


# from objects/obj_score_flag/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_flagpole):
		if y <= limit and ready_v == 0.0:
			vspeed = 0.0
			y = limit
			alarm[1] = 120.0
			ready_v = 1.0
	else:
		instance_destroy()


# from objects/obj_score_flag/Alarm_0.gml
func _alarm_0() -> void:
	if image_index == 8.0:
		x += 8.0


# from objects/obj_score_flag/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_score_flag/Alarm_2.gml
func _alarm_2() -> void:
	vspeed = -1.5


# from objects/obj_score_flag/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, 0.0, GM.c_white, 1.0)
