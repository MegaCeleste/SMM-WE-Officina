extends "res://objects/obj_parent_resource.gd"


# from objects/obj_blooper_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia
