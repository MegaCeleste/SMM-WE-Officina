extends "res://objects/obj_parent_resource.gd"


# from objects/obj_mechakoopa_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 20.0
	wings_y = 20.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_mechakoopa_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_mechakoopa_res/Other_10.gml
func _user_0() -> void:
	pass


# from objects/obj_mechakoopa_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.bobomb = 1.0  # ORIG-BUG: this event transforms mechakoopa into bobomb
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_bobomb_ready_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_bobomb_res:
				inst.obj = A.obj_bobomb_ready_res
				inst.obj_draw = 27.0
	instance_destroy()
