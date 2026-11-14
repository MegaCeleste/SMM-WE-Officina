extends "res://objects/obj_parent_resource.gd"


# from objects/obj_cheepcheep2_res/Create_0.gml
func _create() -> void:
	super._create()
	modo_water = 0.0
	wings_x = 17.0
	wings_y = 20.0


# from objects/obj_cheepcheep2_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia
		if GM.instance_exists(A.obj_lava_water) and y >= (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach"):
			modo_water = 1.0
		else:
			modo_water = 0.0


# from objects/obj_cheepcheep2_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 38.0
		inst.index_object2 = 39.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_contorno_1 = self.wings


# from objects/obj_cheepcheep2_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.cheepcheep = 0.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_cheepcheep_res)):
		inst.wings = self.wings
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_cheepcheep2_res:
				inst.obj = A.obj_cheepcheep_res
				inst.obj_draw = 38.0
	instance_destroy()
