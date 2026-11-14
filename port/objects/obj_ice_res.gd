extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_ice_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_blockice
			1.0:
				sprite_index = A.spr_SMB3_block_ice
			2.0:
				sprite_index = A.spr_block_ice
			3.0:
				sprite_index = A.spr_NSMBU_block_ice
