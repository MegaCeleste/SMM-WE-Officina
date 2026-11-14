extends "res://objects/obj_parent_resource_block.gd"


# from objects/obj_noteblock_res/Create_0.gml
func _create() -> void:
	super._create()
	sprout = 0.0
	progresivo = 0.0


# from objects/obj_noteblock_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_noteblock
				match G.bg_level:
					"snow":
						image_index = 4.0 if G.modo_noche == 1.0 else 3.0
					"castle":
						image_index = 2.0
					"ghost", "underground":
						image_index = 1.0
					_:
						image_index = 1.0 if G.modo_noche == 1.0 else 0.0
			1.0:
				match G.bg_level:
					"snow":
						sprite_index = A.spr_SMB3_noteblock_ice if G.modo_noche == 1.0 else A.spr_SMB3_noteblock
					"castle":
						sprite_index = A.spr_SMB3_noteblock_dark
					"ghost", "underground":
						sprite_index = A.spr_SMB3_noteblock_night
					_:
						sprite_index = A.spr_SMB3_noteblock_night if G.modo_noche == 1.0 else A.spr_SMB3_noteblock
			2.0:
				sprite_index = A.spr_noteblock
				image_index = 0.0
			3.0:
				sprite_index = A.spr_NSMBU_noteblock
				image_index = 0.0


# from objects/obj_noteblock_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if other.object_index == A.obj_mushroom_res or other.object_index == A.obj_fireflower_res or other.object_index == A.obj_superflower_res or other.object_index == A.obj_hen_mushroom_res or other.object_index == A.obj_frogsuit_res or other.object_index == A.obj_cap_res or other.object_index == A.obj_1up_res or other.object_index == A.obj_star_res or other.object_index == A.obj_egg_res or other.object_index == A.obj_egg_red_res or other.object_index == A.obj_vine_res or other.object_index == A.obj_coin_res or other.object_index == A.obj_spring_res or other.object_index == A.obj_pswitch_res or other.object_index == A.obj_spring_land_res or other.object_index == A.obj_pow_res or other.object_index == A.obj_clown_res or other.object_index == A.obj_clown_fire_res or other.object_index == A.obj_buzzy_shell_res or other.object_index == A.obj_spiny_shell_res or other.object_index == A.obj_shell_drybones_res or other.object_index == A.obj_key_res or other.object_index == A.obj_koopa_res or other.object_index == A.obj_koopa_red_res or other.object_index == A.obj_buzzybeetle_res or other.object_index == A.obj_spiny_res or other.object_index == A.obj_cheepcheep_res or other.object_index == A.obj_cheepcheep2_res or other.object_index == A.obj_goomba_res or other.object_index == A.obj_goombrat_res or other.object_index == A.obj_bobomb_res or other.object_index == A.obj_bobomb_ready_res or other.object_index == A.obj_hammerbro_res or other.object_index == A.obj_boo_res or other.object_index == A.obj_muncher_res or other.object_index == A.obj_monty_res or other.object_index == A.obj_pplant_res or other.object_index == A.obj_drybones_res or other.object_index == A.obj_plant_fire_res or other.object_index == A.obj_sledgebro or other.object_index == A.obj_podoboo_res:
		var other_resource = other
		if drag == 0.0 and other_resource.drag == 0.0:
			GM.audio_play_sound(A.snd_colocar_item_bloque, 0.0, false)
			sprout = Scr.scr_sprite_get_constant_res(self, other.sprite_index)
			wings = 0.0
			progresivo = 0.0
			for inst in GM.with_list(other):
				if GM.variable_instance_exists(inst, "wings") and inst.wings == 1.0:
					self.wings = 1.0
			if other.object_index == A.obj_fireflower_res or other.object_index == A.obj_superflower_res or other.object_index == A.obj_frogsuit_res or other.object_index == A.obj_hen_mushroom_res or other.object_index == A.obj_cap_res:
				progresivo = other_resource.progresivo
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_noteblock_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 102.0
		inst.index_object2 = 140.0
		inst.index_object3 = 216.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.selected_3 = 0.0
		inst.number = 7.0


# from objects/obj_noteblock_res/Other_11.gml
func _user_1() -> void:
	if transform != 0.0:
		if transform == 1.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.noteblock = 1.0
			GM.instance_create(x, y, A.obj_musicblock_res)
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_noteblock_res:
						inst.obj = A.obj_musicblock_res
						inst.obj_draw = 140.0
			instance_destroy()
		elif transform == 2.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.noteblock = 2.0
			GM.instance_create(x, y, A.obj_noteblock_s_res)
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_noteblock_res:
						inst.obj = A.obj_noteblock_s_res
						inst.obj_draw = 216.0
			instance_destroy()


# from objects/obj_noteblock_res/Other_12.gml
func _user_2() -> void:
	if sprout != 0.0:
		sprout = 0.0
	else:
		GM.audio_play_sound(A.snd_erase_clean, 0.0, false)
		instance_destroy()


# from objects/obj_noteblock_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 or Scr.outside_view(self) > 0.5:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, 1.0)
	if sprout != 0.0:
		GM.draw_sprite(A.spr_icon_hidden, 0.0, x_draw, y_draw)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
