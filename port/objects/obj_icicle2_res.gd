extends "res://objects/obj_parent_resource.gd"


# from objects/obj_icicle2_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_16x32_2


# from objects/obj_icicle2_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia


# from objects/obj_icicle2_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_4
		inst.id_object = self
		inst.index_object1 = 213.0
		inst.index_object2 = 214.0
		inst.index_object3 = 138.0
		inst.index_object4 = 139.0
		inst.selected_1 = 0.0
		inst.selected_2 = 0.0
		inst.selected_3 = 0.0
		inst.selected_4 = 1.0
		inst.number = 11.0


# from objects/obj_icicle2_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	match transform:
		0.0:
			G.estalactita = 0.0
			GM.instance_create(x, y, A.obj_mini_icicle_res)
		1.0:
			G.estalactita = 1.0
			GM.instance_create(x, y, A.obj_mini_icicle2_res)
		2.0:
			G.estalactita = 2.0
			GM.instance_create(x, y, A.obj_icicle_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_mini_icicle_res or inst.obj == A.obj_mini_icicle2_res or inst.obj == A.obj_icicle_res or inst.obj == A.obj_icicle2_res:
				match self.transform:
					0.0:
						inst.obj = A.obj_mini_icicle_res
						inst.obj_draw = 213.0
					1.0:
						inst.obj = A.obj_mini_icicle2_res
						inst.obj_draw = 214.0
					2.0:
						inst.obj = A.obj_icicle_res
						inst.obj_draw = 138.0
	instance_destroy()
