extends "res://objects/obj_parent_resource.gd"


# from objects/obj_chomp_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			sprite_index = A.spr_chainchomp_night_res
		else:
			sprite_index = A.spr_chainchomp_res
		image_index = G.apariencia


# from objects/obj_chomp_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 0.0
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_chomp_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	GM.instance_create(x, (y - 16.0), A.obj_chomp_b_res)
	instance_destroy()


# from objects/obj_chomp_res/Other_14.gml
func _user_4() -> void:
	return
