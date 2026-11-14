extends "res://objects/obj_parent_resource.gd"


# from objects/obj_pink_coin_res/Create_0.gml
func _create() -> void:
	super._create()
	exception = 1.0


# from objects/obj_pink_coin_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pink_coin
		1.0:
			sprite_index = A.spr_SMB3_pink_coin
		2.0:
			sprite_index = A.spr_pink_coin
		3.0:
			sprite_index = A.spr_NSMBU_pink_coin
