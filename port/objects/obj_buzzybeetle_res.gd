extends "res://objects/obj_parent_resource.gd"


# from objects/obj_buzzybeetle_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 17.0
	wings_y = 18.0


# from objects/obj_buzzybeetle_res/Step_2.gml
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
					if wings == 1.0:
						sprite_index = A.spr_SMB_buzzy_wings_res
						image_index = 1.0
					else:
						sprite_index = A.spr_SMB_buzzybeetle_night_res
				elif wings == 1.0:
					sprite_index = A.spr_SMB_buzzy_wings_res
					image_index = 0.0
				else:
					sprite_index = A.spr_SMB_buzzybeetle_res
			1.0:
				if dark == 1.0:
					if wings == 1.0:
						sprite_index = A.spr_SMB3_buzzy_wings_res
						image_index = 1.0
					else:
						sprite_index = A.spr_SMB3_buzzybeetle_night_res
				elif wings == 1.0:
					sprite_index = A.spr_SMB3_buzzy_wings_res
					image_index = 0.0
				else:
					sprite_index = A.spr_SMB3_buzzybeetle_res
			2.0:
				if wings == 1.0:
					sprite_index = A.spr_buzzy_wings_res
				else:
					sprite_index = A.spr_buzzybeetle_res
			3.0:
				sprite_index = A.spr_NSMBU_buzzybeetle_res
	if (place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_parent_resource_block)) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_ground, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_parent_resource_block, false, false) == null) and wings == 0.0 and paracaidas == 0.0:
		inup = 1.0
	else:
		inup = 0.0


# from objects/obj_buzzybeetle_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			inst.index_object1 = 36.0
			inst.index_object2 = 88.0
		else:
			inst.index_object1 = 35.0
			inst.index_object2 = 87.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_buzzybeetle_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_buzzy_shell_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_buzzybeetle_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 16.0), (y - 16.0), A.obj_buzzybeetle_b_res)):
		inst.paracaidas = self.paracaidas
		inst.wings = self.wings
	instance_destroy()


# from objects/obj_buzzybeetle_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		if drop_lock == 1.0:
			GM.draw_sprite_ext(grid_selected, 1.0, (floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(grid_selected, 0.0, (floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(p_sprite, G.apariencia, (x_draw + para_x), (y_draw - para_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	if inup == 1.0:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, (y_draw + 16.0), 1.0, -1.0, 0.0, GM.c_white, m_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite_ext(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
