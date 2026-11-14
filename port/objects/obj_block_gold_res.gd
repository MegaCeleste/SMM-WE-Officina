extends "res://objects/obj_parent_resource.gd"


# from objects/obj_block_gold_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_qblock
				image_index = 5.0
			1.0:
				sprite_index = A.spr_SMB3_qblock_gold
				image_index = 0.0
			2.0:
				sprite_index = A.spr_flipblock_gold
				image_index = 0.0
			3.0:
				sprite_index = A.spr_NSMBU_block_gold
				image_index = 0.0


# from objects/obj_block_gold_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 64.0
		inst.index_object2 = 63.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.number = 2.1


# from objects/obj_block_gold_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	GM.instance_create(x, y, A.obj_block_res)
	instance_destroy()
