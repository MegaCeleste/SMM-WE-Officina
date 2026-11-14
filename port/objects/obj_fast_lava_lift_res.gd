extends "res://objects/obj_parent_resource.gd"


# from objects/obj_fast_lava_lift_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_64x16


# from objects/obj_fast_lava_lift_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia


# from objects/obj_fast_lava_lift_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 168.0
		inst.index_object2 = 169.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.number = 2.1


# from objects/obj_fast_lava_lift_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.lava_lift = 0.0
	GM.instance_create(x, y, A.obj_lava_lift_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_fast_lava_lift_res:
				inst.obj = A.obj_lava_lift_res
				inst.obj_draw = 168.0
	instance_destroy()
