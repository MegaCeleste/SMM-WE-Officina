extends "res://objects/obj_parent_resource.gd"


# from objects/obj_ninji_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0
	image_speed = 0.0


# from objects/obj_ninji_res/Step_2.gml
func _step_end() -> void:
	# Set sprites
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.apariencia == 0.0:
			sprite_index = A.spr_SMB_ninji_res
		elif G.apariencia == 1.0:
			sprite_index = A.spr_SMB3_ninji_res
		elif G.apariencia == 2.0:
			sprite_index = A.spr_ninji_res
		elif G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_ninji_res
