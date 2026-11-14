extends "res://objects/obj_parent_resource.gd"


# from objects/obj_bowserjr_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 19.0
	wings_y = 22.0
	para_x = 3.0
	para_y = 16.0


# from objects/obj_bowserjr_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia
		if G.apariencia == 3.0:
			wings_x = 22.0
			wings_y = 26.0
		else:
			wings_x = 19.0
			wings_y = 22.0


# from objects/obj_bowserjr_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 0.0
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0
