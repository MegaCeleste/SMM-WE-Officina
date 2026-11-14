extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_noteblock_s_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_noteblock_s_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 102.0
		inst.index_object2 = 140.0
		inst.index_object3 = 216.0
		inst.selected_1 = 0.0
		inst.selected_2 = 0.0
		inst.selected_3 = 1.0
		inst.number = 7.0


# from objects/obj_noteblock_s_res/Other_11.gml
func _user_1() -> void:
	if transform != 2.0:
		if transform == 0.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.noteblock = 0.0
			GM.instance_create(x, y, A.obj_noteblock_res)
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_noteblock_s_res:
						inst.obj = A.obj_noteblock_res
						inst.obj_draw = 102.0
			instance_destroy()
		elif transform == 1.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.noteblock = 1.0
			GM.instance_create(x, y, A.obj_musicblock_res)
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_noteblock_s_res:
						inst.obj = A.obj_musicblock_res
						inst.obj_draw = 140.0
			instance_destroy()
