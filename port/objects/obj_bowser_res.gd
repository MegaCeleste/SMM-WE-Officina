extends "res://objects/obj_parent_resource.gd"


# from objects/obj_bowser_res/Create_0.gml
func _create() -> void:
	super._create()
	exception = 1.0
	grid_selected = A.spr_grid_selected_32x32
	wings_x = 17.0
	wings_y = 18.0


# from objects/obj_bowser_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia
