# 第 7 批移植，已核对。
extends "res://objects/obj_climb.gd"


# from objects/obj_vine/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_vine
			image_speed = 0.0
			image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_vine
			image_speed = 0.12
		2.0:
			image_speed = 0.12
		3.0:
			sprite_index = A.spr_NSMBU_vine
			image_speed = 0.2
