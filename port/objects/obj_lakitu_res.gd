extends "res://objects/obj_parent_resource.gd"


# from objects/obj_lakitu_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = -8.0
	grid_selected = A.spr_grid_selected_16x32_2


# from objects/obj_lakitu_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_lakitu_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if drag == 0.0 and other.drag == 0.0:
		if other.object_index == A.obj_mushroom_res or other.object_index == A.obj_fireflower_res or other.object_index == A.obj_superflower_res or other.object_index == A.obj_hen_mushroom_res or other.object_index == A.obj_cap_res or other.object_index == A.obj_1up_res or other.object_index == A.obj_star_res or other.object_index == A.obj_egg_res or other.object_index == A.obj_egg_red_res or other.object_index == A.obj_buzzy_shell_res or other.object_index == A.obj_spiny_shell_res or other.object_index == A.obj_coin_res or other.object_index == A.obj_hen_mushroom_res or other.object_index == A.obj_frogsuit_res or other.object_index == A.obj_spring_res or other.object_index == A.obj_pswitch_res or other.object_index == A.obj_pow_res or other.object_index == A.obj_koopa_res or other.object_index == A.obj_koopa_red_res or other.object_index == A.obj_buzzybeetle_res or other.object_index == A.obj_cheepcheep_res or other.object_index == A.obj_cheepcheep2_res or other.object_index == A.obj_goomba_res or other.object_index == A.obj_goombrat_res or other.object_index == A.obj_bobomb_res or other.object_index == A.obj_bobomb_ready_res or other.object_index == A.obj_hammerbro_res or other.object_index == A.obj_monty_res or other.object_index == A.obj_pplant_res or other.object_index == A.obj_plant_fire_res or other.object_index == A.obj_drybones_res or other.object_index == A.obj_sledgebro_res or other.object_index == A.obj_podoboo_res:
			GM.audio_play_sound(A.snd_colocar_item_bloque, 0.0, false)
			sprout = Scr.scr_sprite_get_constant_res(self, other.sprite_index)
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_lakitu_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_lakitu_res/Other_14.gml
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


# from objects/obj_lakitu_res/Draw_0.gml
func _gm_draw() -> void:
	var sprite_nube  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	match G.apariencia:
		0.0:
			sprite_nube = A.spr_SMB_cloud_latiku
		1.0:
			sprite_nube = A.spr_SMB3_cloud_latiku
		2.0:
			sprite_nube = A.spr_cloud_latiku
		3.0:
			sprite_nube = A.spr_NSMBU_cloud_latiku
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite_ext(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	GM.draw_sprite_ext(sprite_nube, 0.0, (x_draw + 8.0), (y_draw + 16.0), s_scalex, s_scaley, 0.0, GM.c_white, m_alpha)
	if sprout != 0.0:
		GM.draw_sprite(A.spr_icon_hidden, 0.0, x_draw, (y_draw + 16.0))
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
