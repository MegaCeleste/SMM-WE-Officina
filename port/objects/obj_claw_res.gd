extends "res://objects/obj_parent_resource.gd"


# from objects/obj_claw_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_16x48


# from objects/obj_claw_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia
