extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_icecoin_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_icecoin_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_ice_coin
		1.0:
			match G.bg_level:
				"snow":
					sprite_index = A.spr_SMB3_ice_coin_ice if G.modo_noche == 1.0 else A.spr_SMB3_ice_coin
				"castle", "ghost", "underground":
					sprite_index = A.spr_SMB3_ice_coin_night
				_:
					sprite_index = A.spr_SMB3_ice_coin_night if G.modo_noche == 1.0 else A.spr_SMB3_ice_coin
		2.0:
			sprite_index = A.spr_ice_coin
		3.0:
			sprite_index = A.spr_NSMBU_ice_coin


# from objects/obj_icecoin_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 46.0
		inst.index_object2 = 150.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_contorno_1 = self.wings
		inst.sprite_index = A.spr_windows_3
		inst.number = 3.2


# from objects/obj_icecoin_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.icecoin = 0.0
	GM.instance_create(x, y, A.obj_coin_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_icecoin_res:
				inst.obj = A.obj_coin_res
				inst.obj_draw = 46.0
	instance_destroy()


# from objects/obj_icecoin_res/Other_14.gml
func _user_4() -> void:
	return
