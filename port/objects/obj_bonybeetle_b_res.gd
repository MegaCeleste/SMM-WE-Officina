extends "res://objects/obj_parent_resource.gd"


# from objects/obj_bonybeetle_b_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32
	w_sprite = A.spr_wings_editor_big
	wings_x = 20.0
	wings_y = -8.0
	para_x = 8.0
	para_y = 8.0


# from objects/obj_bonybeetle_b_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_bonybeetle_b_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_hongo_1 = 1.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_bonybeetle_b_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
		inst.girar = 1.0
		inst.sprite_index = A.spr_mushroon_deads
		inst.image_index = G.apariencia
		inst.hspeed = 1.0
	for inst in GM.with_list(GM.instance_create((x - 16.0), (y - 16.0), A.obj_bonybeetle_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_bonybeetle_b_res/Other_14.gml
func _user_4() -> void:
	return


# from objects/obj_bonybeetle_b_res/Draw_0.gml
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
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite_ext(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
