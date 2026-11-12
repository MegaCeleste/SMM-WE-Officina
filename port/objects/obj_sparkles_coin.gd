# from objects/obj_sparkles_coin（第 5 批移植，已核对）
extends "res://objects/obj_sparkletrail.gd"


# from objects/obj_sparkles_coin/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB3_sparkles_coin
		1.0:
			sprite_index = A.spr_SMB3_sparkles_coin
		3.0:
			sprite_index = A.spr_NSMBU_sparkles_coin
	if G.apariencia == 3.0:
		image_speed = 0.4
	else:
		image_speed = 0.4
