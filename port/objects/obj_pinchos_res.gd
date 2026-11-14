extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_pinchos_res/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 0.0:
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			sprite_index = A.spr_SMB_pinchos_ice
		elif G.bg_level == "snow":
			sprite_index = A.spr_SMB_pinchos_snow
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB_pinchos_dark
		elif (G.bg_level == "mountain") and (G.modo_noche == 1.0):
			sprite_index = A.spr_SMB_pinchos_dark
		elif (G.bg_level == "mountain") and (G.modo_noche == 0.0):
			sprite_index = A.spr_SMB_pinchos
		elif (G.bg_level != "mountain") and (G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0):
			sprite_index = A.spr_SMB_pinchos_night
		else:
			sprite_index = A.spr_SMB_pinchos
	elif G.apariencia == 1.0:
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			sprite_index = A.spr_SMB3_pinchos_ice
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB3_pinchos_dark
		elif (G.bg_level == "mountain") and (G.modo_noche == 1.0):
			sprite_index = A.spr_SMB3_pinchos_dark
		elif (G.bg_level == "mountain") and (G.modo_noche == 0.0):
			sprite_index = A.spr_SMB3_pinchos
		elif (G.bg_level != "mountain") and (G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0):
			sprite_index = A.spr_SMB3_pinchos_night
		if G.bg_level == "underwater":
			sprite_index = A.spr_SMB3_pinchos_swin
		else:
			sprite_index = A.spr_SMB3_pinchos
	elif G.apariencia == 2.0:
		if G.bg_level == "underwater":
			sprite_index = A.spr_pinchos_swin
		else:
			sprite_index = A.spr_pinchos
	elif G.apariencia == 3.0:
		if (G.bg_level != "mountain") and (G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0):
			sprite_index = A.spr_NSMBU_pinchos_night
		elif G.bg_level == "mountain":
			sprite_index = A.spr_NSMBU_pinchos
		else:
			sprite_index = A.spr_NSMBU_pinchos
