extends "res://objects/obj_parent_resource.gd"


# from objects/obj_spiny_shell_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_spiny_shell_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 127.0
		inst.index_object2 = 89.0
		inst.number = 3.1
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_paracaidas = self.paracaidas


# from objects/obj_spiny_shell_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_spiny_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()
