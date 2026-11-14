extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_onoffplatform_res/Create_0.gml
func _create() -> void:
	super._create()
	image_index = 1.0


# from objects/obj_onoffplatform_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_onoffplatform
			1.0:
				sprite_index = A.spr_SMB3_onoffplatform
			2.0:
				sprite_index = A.spr_onoffplatform
			3.0:
				sprite_index = A.spr_NSMBU_onoffplatform


# from objects/obj_onoffplatform_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 13.0
		inst.index_object2 = 14.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.number = 2.1


# from objects/obj_onoffplatform_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.onoff = 1.0
	GM.instance_create(x, y, A.obj_onoffplatform_blue_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_onoffplatform_res:
				inst.obj = A.obj_onoffplatform_blue_res
				inst.obj_draw = 14.0
	instance_destroy()
