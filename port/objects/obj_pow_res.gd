extends "res://objects/obj_parent_resource.gd"


# from objects/obj_pow_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_pow
			1.0:
				sprite_index = A.spr_SMB3_pow
			2.0:
				sprite_index = A.spr_block_pow
			3.0:
				sprite_index = A.spr_NSMBU_pow
				image_speed = 0.0
				if G.modo_noche == 1.0 or G.bg_level == "underground":
					image_index = 1.0
				elif G.bg_level == "airship" or G.bg_level == "sky":
					image_index = 4.0
				elif G.bg_level == "ghost":
					image_index = 3.0
				elif G.bg_level == "castle":
					image_index = 2.0
				else:
					image_index = 0.0
