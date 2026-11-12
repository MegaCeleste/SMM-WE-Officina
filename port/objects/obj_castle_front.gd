# from objects/obj_castle_front（第 7 批移植，已核对）
extends GMObject


# from objects/obj_castle_front/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia


# from objects/obj_castle_front/Collision_obj_player_goal_nsmbu.gml
func _collision_obj_player_goal_nsmbu(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.visible = false


# from objects/obj_castle_front/Collision_obj_player_goal_smb1.gml
func _collision_obj_player_goal_smb1(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.visible = false
