extends "res://objects/obj_parent_resource.gd"


# from objects/obj_coin30_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32


# from objects/obj_coin30_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB_coin_30_dark
				"ghost", "underground":
					sprite_index = A.spr_SMB_coin_30_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_30_dark
					else:
						sprite_index = A.spr_SMB_coin_30_night if G.modo_noche == 1.0 else A.spr_SMB_coin_30
				_:
					sprite_index = A.spr_SMB_coin_30_night if G.modo_noche == 1.0 else A.spr_SMB_coin_30
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_coin_30_dark
				"ghost", "underground":
					sprite_index = A.spr_SMB3_coin_30_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_30_dark
					else:
						sprite_index = A.spr_SMB3_coin_30_night if G.modo_noche == 1.0 else A.spr_SMB3_coin_30
				_:
					sprite_index = A.spr_SMB3_coin_30_night if G.modo_noche == 1.0 else A.spr_SMB3_coin_30
		2.0:
			sprite_index = A.spr_coin_30
		3.0:
			sprite_index = A.spr_NSMBU_coin_30


# from objects/obj_coin30_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 47.0
		inst.index_object2 = 48.0
		inst.index_object3 = 49.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.selected_3 = 0.0
		inst.number = 7.0


# from objects/obj_coin30_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	match transform:
		0.0:
			G.coin10 = 0.0
			GM.instance_create(x, y, A.obj_coin10_res)
		2.0:
			G.coin10 = 2.0
			GM.instance_create(x, y, A.obj_coin50_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_coin10_res or inst.obj == A.obj_coin30_res or inst.obj == A.obj_coin50_res:
				match self.transform:
					0.0:
						inst.obj = A.obj_coin10_res
						inst.obj_draw = 47.0
					2.0:
						inst.obj = A.obj_coin50_res
						inst.obj_draw = 49.0
	instance_destroy()
