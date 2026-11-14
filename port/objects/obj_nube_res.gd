extends "res://objects/obj_parent_resource.gd"


# from objects/obj_nube_res/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_nube
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 5.0
		elif G.bg_level == "snow":
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost":
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_nube
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 2.0:
		sprite_index = A.spr_nube
		if G.bg_level == "underwater":
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_nube
		if G.bg_level == "ghost":
			image_index = 5.0
		elif (G.bg_level == "airship" or G.bg_level == "sky") and G.modo_noche == 0.0:
			image_index = 4.0
		elif G.bg_level == "underwater":
			image_index = 3.0
		elif G.bg_level == "castle":
			image_index = 2.0
		elif G.bg_level == "underground" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0


# from objects/obj_nube_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	return
