extends "res://objects/obj_parent_resource.gd"


# from objects/obj_bouncycloud_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_64x16_2


# from objects/obj_bouncycloud_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				match G.bg_level:
					"snow":
						image_index = 3.0
					"underwater":
						image_index = 4.0
					"castle":
						image_index = 2.0
					"underground", "ghost":
						image_index = 1.0
					_:
						image_index = 1.0 if G.modo_noche == 1.0 else 0.0
			1.0:
				match G.bg_level:
					"snow":
						image_index = 8.0
					"underwater":
						image_index = 9.0
					"castle":
						image_index = 7.0
					"underground", "ghost":
						image_index = 6.0
					_:
						image_index = 6.0 if G.modo_noche == 1.0 else 5.0
			2.0:
				if G.bg_level == "underwater":
					image_index = 11.0
				else:
					image_index = 10.0
			3.0:
				image_index = 12.0
