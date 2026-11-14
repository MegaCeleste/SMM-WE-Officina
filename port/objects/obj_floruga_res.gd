extends "res://objects/obj_parent_resource.gd"


# from objects/obj_floruga_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 20.0
	wings_y = 20.0


# from objects/obj_floruga_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia


# from objects/obj_floruga_res/Other_10.gml
func _user_0() -> void:
	pass


# from objects/obj_floruga_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.floruga = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_floruga_angry_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_floruga_res:
				inst.obj = A.obj_floruga_angry_res
				inst.obj_draw = 159.0
	instance_destroy()
