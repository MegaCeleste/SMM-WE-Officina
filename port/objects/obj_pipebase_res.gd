extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_pipebase_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32


# from objects/obj_pipebase_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			image_index = 0.0
		1.0:
			match G.bg_level:
				"underground", "ghost":
					image_index = 2.0
				"castle":
					image_index = 3.0
				"snow":
					image_index = 4.0 if G.modo_noche == 1.0 else 1.0
				"mountain":
					image_index = 3.0 if G.modo_noche == 1.0 else 1.0
				_:
					image_index = 2.0 if G.modo_noche == 1.0 else 1.0
		2.0:
			image_index = 5.0
		3.0:
			image_index = 6.0
