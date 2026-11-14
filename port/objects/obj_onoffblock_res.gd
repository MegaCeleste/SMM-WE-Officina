extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_onoffblock_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_onoffblock_on
			1.0:
				sprite_index = A.spr_SMB3_onoffblock_on
			2.0:
				sprite_index = A.spr_onoffblock_on
			3.0:
				sprite_index = A.spr_NSMBU_onoffblock_on
