# from objects/obj_coin30（第 5 批移植，已核对）
extends "res://objects/obj_coin10.gd"


# from objects/obj_coin30/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB_coin_30_dark
				"ghost":
					sprite_index = A.spr_SMB_coin_30_night
				"underground":
					sprite_index = A.spr_SMB_coin_30_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_30_night
					else:
						sprite_index = A.spr_SMB_coin_30
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_coin_30_dark
				"ghost":
					sprite_index = A.spr_SMB3_coin_30_night
				"underground":
					sprite_index = A.spr_SMB3_coin_30_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_30_night
					else:
						sprite_index = A.spr_SMB3_coin_30
		2.0:
			sprite_index = A.spr_coin_30
		3.0:
			sprite_index = A.spr_NSMBU_coin_30
	active = 0.0
	image_speed = 0.15
