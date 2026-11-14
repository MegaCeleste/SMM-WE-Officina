extends "res://objects/obj_parent_resource.gd"


# from objects/obj_spike_ball_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "snow":
			sprite_index = A.spr_snow_ball_res
			image_index = G.apariencia
		else:
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				sprite_index = A.spr_spike_ball_night_res
			else:
				sprite_index = A.spr_spike_ball_res
			image_index = G.apariencia


# from objects/obj_spike_ball_res/Other_10.gml
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
		inst.s_hongo_1 = 0.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_spike_ball_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_spike_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_spike_ball_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 16.0), (y - 16.0), A.obj_spike_ball_b_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_spike_ball_res/Other_14.gml
func _user_4() -> void:
	return
