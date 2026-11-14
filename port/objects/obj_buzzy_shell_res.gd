extends "res://objects/obj_parent_resource.gd"


# from objects/obj_buzzy_shell_res/Step_2.gml
func _step_end() -> void:
	var dark: float = 0.0
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level in ["castle", "ghost", "underground"] or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		match G.apariencia:
			0.0:
				if dark == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			1.0:
				if dark == 1.0:
					image_index = 3.0
				else:
					image_index = 2.0
			2.0:
				image_index = 4.0
			3.0:
				image_index = 5.0


# from objects/obj_buzzy_shell_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			inst.index_object1 = 36.0
			inst.index_object2 = 88.0
		else:
			inst.index_object1 = 35.0
			inst.index_object2 = 87.0
		inst.number = 3.1
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_paracaidas = self.paracaidas


# from objects/obj_buzzy_shell_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_buzzybeetle_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()
