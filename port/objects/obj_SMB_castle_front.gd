# from objects/obj_SMB_castle_front（第 7 批移植，已核对）
extends GMObject


# from objects/obj_SMB_castle_front/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_castle_front
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
				# ORIG-BUG: 夜晚 mountain 这里是 6（obj_SMB_castle、obj_flagpole 同样情况是 8）。照搬
				image_index = 6.0
		elif G.modo_noche == 1.0:
			image_index = 9.0
		else:
			image_index = 0.0
	elif G.bg_level == "snow":
		image_index = 1.0
	else:
		image_index = 0.0


# from objects/obj_SMB_castle_front/Collision_obj_player_goal_nsmbu.gml
func _collision_obj_player_goal_nsmbu(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.visible = false


# from objects/obj_SMB_castle_front/Collision_obj_player_goal_smb1.gml
func _collision_obj_player_goal_smb1(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.visible = false


# from objects/obj_SMB_castle_front/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, image_angle, image_blend, image_alpha)
