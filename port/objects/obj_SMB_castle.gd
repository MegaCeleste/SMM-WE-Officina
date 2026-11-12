# from objects/obj_SMB_castle（第 7 批移植，已核对）
extends GMObject

var active: float = 0.0


# from objects/obj_SMB_castle/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_castle
		if G.bg_level == "ground":
			image_index = 0.0
		elif G.bg_level == "underground":
			image_index = 1.0
		elif G.bg_level == "sky":
			image_index = 2.0
		elif G.bg_level == "airship":
			image_index = 3.0
		elif G.bg_level == "ghost":
			image_index = 4.0
		elif G.bg_level == "underwater":
			image_index = 5.0
		elif G.bg_level == "desert":
			image_index = 6.0
		elif G.bg_level == "forest":
			image_index = 7.0
		elif G.bg_level == "snow":
			image_index = 10.0
		elif G.bg_level == "mountain":
			if G.modo_noche == 0.0:
				image_index = 2.0
			else:
				image_index = 8.0
		elif G.modo_noche == 1.0:
			image_index = 9.0
		else:
			image_index = 0.0
	elif G.bg_level == "snow":
		image_index = 1.0
	else:
		image_index = 0.0
	active = 0.0
	image_speed = 0.0
	GM.instance_create((x + 40.0), y, A.obj_SMB_castle_front)


# from objects/obj_SMB_castle/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_SMB_castle_front):
		for inst in GM.with_list(A.obj_SMB_castle_front):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_mini_flag):
		for inst in GM.with_list(A.obj_mini_flag):
			inst.instance_destroy()


# from objects/obj_SMB_castle/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_player_goal_smb1) and GM.instance_exists(A.obj_SMB_castle_front):
		var _g: GMObject = GM.instance_find(A.obj_player_goal_smb1, 0)  # PORT: obj_player_goal_smb1.x 等（第一个实例，含子类 nsmbu），外层已判断存在
		if _g.y == (y + 16.0) and _g.x > (x + 37.0) and _g.x < (x + 40.0) and _g.vspeed == 0.0:
			for inst in GM.with_list(A.obj_SMB_castle_front):
				inst.depth = -10.0
			if active == 0.0 and G.apariencia != 3.0:
				alarm[0] = 90.0
				active = 1.0


# from objects/obj_SMB_castle/Alarm_0.gml
func _alarm_0() -> void:
	GM.instance_create((x + 33.0), (y - 26.0), A.obj_mini_flag)
