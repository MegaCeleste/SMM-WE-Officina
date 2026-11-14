extends "res://objects/obj_parent_resource.gd"


# from objects/obj_clown_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32_2
	s_scalex = -1.0


# from objects/obj_clown_res/Step_1.gml
func _step_begin() -> void:
	pass


# from objects/obj_clown_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_clown
			1.0:
				sprite_index = A.spr_SMB3_clown
			2.0:
				sprite_index = A.spr_clown
			3.0:
				sprite_index = A.spr_NSMBU_clown


# from objects/obj_clown_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 44.0
		inst.index_object2 = 45.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.number = 2.1


# from objects/obj_clown_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.clown = 1.0
	GM.instance_create(x, y, A.obj_clown_fire_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_clown_res:
				inst.obj = A.obj_clown_fire_res
				inst.obj_draw = 45.0
	instance_destroy()


# from objects/obj_clown_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite(p_sprite, G.apariencia, (x_draw + para_x), (y_draw - para_y))
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y))
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
