extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_rock_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_rock_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_block_rock
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 5.0
					else:
						image_index = 4.0
				"underwater":
					image_index = 3.0
				"castle":
					image_index = 2.0
				"mountain":
					image_index = 0.0
				"airship":
					image_index = 2.0
				"underground":
					image_index = 1.0
				"ghost":
					image_index = 1.0
				_:
					image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_block_rock
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 3.0
				"castle":
					image_index = 2.0
				"underground":
					image_index = 1.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 2.0
					else:
						image_index = 0.0
				"ghost":
					image_index = 1.0
				_:
					image_index = 0.0
		2.0:
			if G.bg_level == "ghost" or G.bg_level == "airship":
				sprite_index = A.spr_madera
			else:
				sprite_index = A.spr_block_rock
		3.0:
			sprite_index = A.spr_NSMBU_block_rock
			match G.bg_level:
				"ghost":
					image_index = 5.0
				"airship":
					if G.modo_noche == 0.0:
						image_index = 0.0
					else:
						image_index = 4.0
				"sky":
					if G.modo_noche == 0.0:
						image_index = 0.0
					else:
						image_index = 4.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 2.0
					else:
						image_index = 0.0
				"underwater":
					image_index = 3.0
				"castle":
					image_index = 2.0
				"underground":
					image_index = 1.0
				_:
					image_index = 0.0


# from objects/obj_rock_res/Other_14.gml
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
