extends "res://objects/obj_parent_resource.gd"


# from objects/obj_spiny_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 17.0
	wings_y = 18.0


# from objects/obj_spiny_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if wings == 1.0:
			sprite_index = A.spr_spiny_wings_res
			image_index = G.apariencia
			image_speed = 0.0
		else:
			sprite_index = A.spr_spiny_res
			image_index = G.apariencia
	if (place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_parent_resource_block)) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_ground, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_parent_resource_block, false, false) == null) and wings == 0.0 and paracaidas == 0.0:
		inup = 1.0
	else:
		inup = 0.0


# from objects/obj_spiny_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 127.0
		inst.index_object2 = 89.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_spiny_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_spiny_shell_res)):
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_spiny_res/Draw_0.gml
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
		GM.draw_sprite(p_sprite, G.apariencia, (x_draw + para_x), (y_draw - para_y))
	if inup == 1.0:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, (y_draw + 16.0), 1.0, -1.0, 0.0, GM.c_white, m_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y))
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
