extends "res://objects/obj_parent_sounds.gd"


# from objects/obj_risas_snd_res/Create_0.gml
func _create() -> void:
	super._create()
	image_index = 2.0


# from objects/obj_risas_snd_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 2.0
		inst.index_object2 = 3.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.number = 2.1


# from objects/obj_risas_snd_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.risas = 1.0
	GM.instance_create(x, y, A.obj_bebe_snd_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_risas_snd_res:
				inst.obj = A.obj_bebe_snd_res
				inst.obj_draw = 3.0
	instance_destroy()


# from objects/obj_risas_snd_res/Other_13.gml
func _user_3() -> void:
	GM.instance_create(x, y, A.obj_risas_or)
