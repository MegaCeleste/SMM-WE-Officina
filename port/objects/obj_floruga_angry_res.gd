extends "res://objects/obj_parent_resource.gd"


# from objects/obj_floruga_angry_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 20.0
	wings_y = 20.0


# from objects/obj_floruga_angry_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia


# from objects/obj_floruga_angry_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 158.0
		inst.index_object2 = 159.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_floruga_angry_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.floruga = 0.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_floruga_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_floruga_angry_res:
				inst.obj = A.obj_floruga_res
				inst.obj_draw = 158.0
	instance_destroy()
