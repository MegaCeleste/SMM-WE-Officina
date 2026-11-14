extends "res://objects/obj_parent_resource.gd"


# from objects/obj_drybones_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 17.0
	wings_y = 25.0
	para_x = 3.0
	para_y = 16.0


# from objects/obj_drybones_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_drybones_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 56.0
		inst.index_object2 = 57.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_drybones_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell_drybones_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()
