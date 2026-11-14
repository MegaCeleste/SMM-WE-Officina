extends "res://objects/obj_parent_resource.gd"


# from objects/obj_1up_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0


# from objects/obj_1up_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.modo_noche == 1.0 and G.bg_level == "ground":
			sprite_index = A.spr_rotten_b
			image_index = G.apariencia
		else:
			match G.apariencia:
				0.0:
					sprite_index = A.spr_SMB_1up
				1.0:
					sprite_index = A.spr_SMB3_1up
				2.0:
					sprite_index = A.spr_1up
				3.0:
					sprite_index = A.spr_NSMBU_1up


# from objects/obj_1up_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.number = 2.0


# from objects/obj_1up_res/Other_14.gml
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
