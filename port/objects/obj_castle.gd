# from objects/obj_castle（第 7 批移植，已核对）
extends GMObject


# from objects/obj_castle/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_castle_dooropen
		1.0:
			sprite_index = A.spr_SMB3_castle_dooropen
		2.0:
			sprite_index = A.spr_castle_opendoor
		3.0:
			sprite_index = A.spr_NSMBU_castle_dooropen
	image_speed = 0.0
	image_index = 0.0
	GM.instance_create((x + 48.0), y, A.obj_castle_front)


# from objects/obj_castle/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_castle_front):
		for inst in GM.with_list(A.obj_castle_front):
			inst.instance_destroy()


# from objects/obj_castle/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_player_goal_smw_castle) and GM.instance_exists(A.obj_castle_front):
		var _g: GMObject = GM.instance_find(A.obj_player_goal_smw_castle, 0)  # PORT: obj_player_goal_smw_castle.x 等（第一个实例），外层已判断存在
		if _g.y == (y + 16.0) and _g.x > (x + 37.0) and _g.x < (x + 40.0) and _g.vspeed == 0.0:
			for inst in GM.with_list(A.obj_castle_front):
				inst.depth = -10.0
			if G.apariencia == 3.0:
				for inst in GM.with_list(A.obj_player_goal_smw_castle):
					inst.h = 0.0
			else:
				for inst in GM.with_list(A.obj_player_goal_smw_castle):
					inst.h = 0.0


# from objects/obj_castle/Alarm_0.gml
func _alarm_0() -> void:
	image_speed = 0.15


# from objects/obj_castle/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 2.0


# from objects/obj_castle/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(A.spr_castle, (G.apariencia + 2.0), x, y)
	draw_self()
