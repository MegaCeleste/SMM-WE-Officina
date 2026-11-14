extends "res://objects/obj_parent_resource.gd"


# from objects/obj_charginchuck_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32_2
	wings_x = 16.0
	wings_y = 24.0
	para_x = 3.0
	para_y = 16.0


# from objects/obj_charginchuck_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_charginchuck_res/Other_10.gml
func _user_0() -> void:
	pass


# from objects/obj_charginchuck_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_sledgebro_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	instance_destroy()
