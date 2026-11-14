extends "res://objects/obj_parent_resource.gd"


# from objects/obj_donut_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_donut_res/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_donut_res
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 5.0
		elif G.bg_level == "snow":
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_donut_res
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 3.0
		elif G.bg_level == "castle":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 2.0:
		sprite_index = A.spr_donut_res
		image_index = 0.0
	elif G.apariencia == 3.0:
		sprite_index = A.spr_donut_res
		image_index = 1.0


# from objects/obj_donut_res/Other_10.gml
func _user_0() -> void:
	pass


# from objects/obj_donut_res/Other_14.gml
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
