extends "res://objects/obj_parent_resource.gd"


# from objects/obj_bumper_res/Create_0.gml
func _create() -> void:
	super._create()
	image_index = G.apariencia
	grid_selected = A.spr_grid_selected_48x48


# from objects/obj_bumper_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia
