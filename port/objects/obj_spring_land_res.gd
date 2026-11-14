extends "res://objects/obj_parent_resource.gd"


# from objects/obj_spring_land_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_spring_land_res/Step_2.gml
func _step_end() -> void:
	sprite_index = A.spr_spring_land_res
	image_index = G.apariencia


# from objects/obj_spring_land_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 128.0
		inst.index_object2 = 129.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas
		inst.sprite_index = A.spr_windows_4
		inst.number = 4.0


# from objects/obj_spring_land_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.spring = 0.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_spring_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_spring_land_res:
				inst.obj = A.obj_spring_res
				inst.obj_draw = 128.0
	instance_destroy()


# from objects/obj_spring_land_res/Other_14.gml
func _user_4() -> void:
	if wings == 0.0:
		GM.audio_play_sound(A.snd_agregar_wings, 0.0, false)
		wings = 1.0
	else:
		GM.audio_play_sound(A.snd_remove_wings, 0.0, false)
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0
		wings = 0.0
