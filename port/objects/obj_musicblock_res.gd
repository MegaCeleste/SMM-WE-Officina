extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_musicblock_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_musicblock
				match G.bg_level:
					"snow":
						image_index = 4.0 if G.modo_noche == 1.0 else 3.0
					"castle":
						image_index = 2.0
					"ghost", "underground":
						image_index = 1.0
					_:
						image_index = 1.0 if G.modo_noche == 1.0 else 0.0
			1.0:
				sprite_index = A.spr_SMB3_musicblock
				image_index = 0.0
			2.0:
				sprite_index = A.spr_musicblock
				image_index = 0.0
			3.0:
				sprite_index = A.spr_NSMBU_musicblock
				image_index = 0.0


# from objects/obj_musicblock_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 102.0
		inst.index_object2 = 140.0
		inst.index_object3 = 216.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.selected_3 = 0.0
		inst.number = 7.0


# from objects/obj_musicblock_res/Other_11.gml
func _user_1() -> void:
	if transform != 1.0:
		if transform == 0.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.noteblock = 0.0
			GM.instance_create(x, y, A.obj_noteblock_res)
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_musicblock_res:
						inst.obj = A.obj_noteblock_res
						inst.obj_draw = 102.0
			instance_destroy()
		elif transform == 2.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.noteblock = 2.0
			GM.instance_create(x, y, A.obj_noteblock_s_res)
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_musicblock_res:
						inst.obj = A.obj_noteblock_s_res
						inst.obj_draw = 216.0
			instance_destroy()
