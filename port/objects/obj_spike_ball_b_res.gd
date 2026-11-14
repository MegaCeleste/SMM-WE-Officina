extends "res://objects/obj_parent_resource.gd"


# from objects/obj_spike_ball_b_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32
	para_x = 8.0
	para_y = 16.0


# from objects/obj_spike_ball_b_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "snow":
			match G.apariencia:
				0.0:
					image_index = 6.0
				1.0:
					image_index = 7.0
				2.0:
					image_index = 8.0
				3.0:
					image_index = 9.0
		elif G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			match G.apariencia:
				0.0:
					image_index = 1.0
				1.0:
					image_index = 3.0
				2.0:
					image_index = 4.0
				3.0:
					image_index = 5.0
		else:
			match G.apariencia:
				0.0:
					image_index = 0.0
				1.0:
					image_index = 2.0
				2.0:
					image_index = 4.0
				3.0:
					image_index = 5.0


# from objects/obj_spike_ball_b_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 151.0
		match G.bg_level:
			"snow":
				inst.index_object2 = 211.0
			"castle", "ghost", "underground":
				inst.index_object2 = 210.0
			_:
				inst.index_object2 = 210.0 if G.modo_noche == 1.0 else 209.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_hongo_1 = 1.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_spike_ball_b_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create((x + 16.0), (y + 16.0), A.obj_spike_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_spike_ball_b_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
		inst.girar = 1.0
		inst.sprite_index = A.spr_mushroon_deads
		inst.image_index = G.apariencia
		inst.hspeed = 1.0
	for inst in GM.with_list(GM.instance_create((x + 16.0), (y + 16.0), A.obj_spike_ball_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_spike_ball_b_res/Other_14.gml
func _user_4() -> void:
	return
