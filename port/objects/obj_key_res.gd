extends "res://objects/obj_parent_resource.gd"


# from objects/obj_key_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_key
			1.0:
				sprite_index = A.spr_SMB3_key
			2.0:
				sprite_index = A.spr_key
			3.0:
				sprite_index = A.spr_NSMBU_key
