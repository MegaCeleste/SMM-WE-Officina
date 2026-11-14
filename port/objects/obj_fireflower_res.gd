extends "res://objects/obj_parent_resource.gd"


# from objects/obj_fireflower_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	progresivo = 0.0


# from objects/obj_fireflower_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_fireflower_res
			1.0:
				sprite_index = A.spr_SMB3_fireflower_res
			2.0:
				sprite_index = A.spr_fireflower_res
			3.0:
				sprite_index = A.spr_NSMBU_fireflower_res
		image_index = progresivo


# from objects/obj_fireflower_res/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 0.0:
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
			inst.id_object = self
			inst.index_object1 = 61.0
			inst.index_object2 = 62.0
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
			inst.s_contorno_1 = self.wings
			inst.s_hongo_1 = self.progresivo
			inst.s_paracaidas = self.paracaidas
	else:
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
			inst.sprite_index = A.spr_windows_3
			inst.id_object = self
			inst.s_contorno_1 = self.wings
			inst.s_hongo_1 = self.progresivo
			inst.s_paracaidas = self.paracaidas
			inst.number = 3.0


# from objects/obj_fireflower_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_superflower_res)):
		inst.wings = self.wings
	instance_destroy()


# from objects/obj_fireflower_res/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	if progresivo == 0.0:
		GM.audio_play_sound(A.snd_add_hongo, 0.0, false)
		progresivo = 1.0
	else:
		GM.audio_play_sound(A.snd_remove_hongo, 0.0, false)
		progresivo = 0.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
			inst.girar = 1.0
			inst.sprite_index = A.spr_mushroon_deads
			inst.image_index = G.apariencia
			inst.hspeed = 1.0


# from objects/obj_fireflower_res/Other_14.gml
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
