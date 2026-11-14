extends "res://objects/obj_parent_resource.gd"


# from objects/obj_pswitch_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0


# from objects/obj_pswitch_res/Step_0.gml
func _step() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if inup == 1.0:
			wings = 0.0


# from objects/obj_pswitch_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_pswitch
			1.0:
				sprite_index = A.spr_SMB3_pswitch
			2.0:
				sprite_index = A.spr_pswitch
			3.0:
				sprite_index = A.spr_NSMBU_pswitch
	if (place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_parent_resource_block)) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_ground, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_parent_resource_block, false, false) == null):
		inup = 1.0
	else:
		inup = 0.0


# from objects/obj_pswitch_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.s_contorno_1 = self.wings
		inst.sprite_index = A.spr_windows_1
		inst.number = 9.0


# from objects/obj_pswitch_res/Other_14.gml
func _user_4() -> void:
	if inup != 1.0:
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


# from objects/obj_pswitch_res/Draw_0.gml
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
	if inup == 1.0:
		GM.draw_sprite_ext(sprite_index, image_index, (x_draw + 16.0), (y_draw + 16.0), 1.0, 1.0, 180.0, GM.c_white, m_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, image_xscale, 1.0, 0.0, GM.c_white, m_alpha)
	if wings == 1.0 and inup != 1.0:
		GM.draw_sprite_ext(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
