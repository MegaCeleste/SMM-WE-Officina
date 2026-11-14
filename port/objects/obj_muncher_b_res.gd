extends "res://objects/obj_parent_resource.gd"


# from objects/obj_muncher_b_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32_2
	w_sprite = A.spr_wings_editor_32x32
	wings_x = -16.0
	wings_y = 8.0
	para_x = -8.0
	para_y = 32.0


# from objects/obj_muncher_b_res/Step_2.gml
func _step_end() -> void:
	var dark: float = 0.0
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		match G.apariencia:
			0.0:
				if dark == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			1.0:
				if dark == 1.0:
					image_index = 3.0
				else:
					image_index = 2.0
			2.0:
				image_index = 4.0
			3.0:
				image_index = 5.0


# from objects/obj_muncher_b_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 1.0
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_muncher_b_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
		inst.girar = 1.0
		inst.sprite_index = A.spr_mushroon_deads
		inst.image_index = G.apariencia
		inst.hspeed = 1.0
	GM.instance_create((x - 16.0), y, A.obj_muncher_res)
	instance_destroy()
