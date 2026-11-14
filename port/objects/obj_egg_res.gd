extends "res://objects/obj_parent_resource.gd"

var pararacidas = null


# from objects/obj_egg_res/Create_0.gml
func _create() -> void:
	super._create()
	wings = 0.0
	w_sprite = A.spr_wings_editor_16x16
	if G.apariencia < 2.0:
		image_speed = 0.25


# from objects/obj_egg_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_shoe_res
				w_sprite = A.spr_wings_editor
				wings_x = 20.0
				wings_y = 20.0
				wings = 0.0
			1.0:
				sprite_index = A.spr_shoe_res
				w_sprite = A.spr_wings_editor
				wings_x = 20.0
				wings_y = 20.0
				wings = 0.0
			2.0:
				if wings == 0.0:
					sprite_index = A.spr_egg
				else:
					sprite_index = A.spr_egg_blue
				w_sprite = A.spr_wings_editor_16x16
				wings_x = 0.0
				wings_y = 0.0
			3.0:
				sprite_index = A.spr_NSMBU_egg
				w_sprite = A.spr_wings_editor_16x16
				wings_x = 0.0
				wings_y = 0.0


# from objects/obj_egg_res/Other_7.gml
func _animation_end() -> void:
	if G.apariencia != 2.0:
		image_speed = 0.0
		image_index = 4.0


# from objects/obj_egg_res/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 2.0:
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
			inst.sprite_index = A.spr_windows_3
			inst.id_object = self
			inst.s_contorno_1 = self.wings
			inst.s_hongo_1 = G.yoshi_egg
			inst.s_paracaidas = self.paracaidas
			inst.number = 3.0
	else:
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
			inst.id_object = self
			inst.index_object1 = 59.0
			inst.index_object2 = 60.0
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
			inst.s_contorno_1 = self.wings
			inst.s_paracaidas = self.paracaidas


# from objects/obj_egg_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.yoshi_egg = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_egg_red_res)):
		inst.wings = self.wings
		inst.pararacidas = self.paracaidas  # ORIG-BUG: 原版字段拼写如此。
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_egg_res:
				inst.obj = A.obj_egg_red_res
				inst.obj_draw = 60.0
	instance_destroy()


# from objects/obj_egg_res/Other_13.gml
func _user_3() -> void:
	if G.apariencia == 2.0:
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
		G.yoshi_egg = 1.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_egg_red_res)):
			inst.wings = self.wings
			inst.paracaidas = self.paracaidas
		if GM.instance_exists(A.obj_card_item):
			for inst in GM.with_list(A.obj_card_item):
				if inst.obj == A.obj_egg_res:
					inst.obj = A.obj_egg_red_res
					inst.obj_draw = 60.0
		instance_destroy()


# from objects/obj_egg_res/Other_14.gml
func _user_4() -> void:
	if G.apariencia > 1.0:
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
	else:
		return
