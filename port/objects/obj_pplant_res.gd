extends "res://objects/obj_parent_resource.gd"


# from objects/obj_pplant_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_pplant_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia
		if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_ground, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_parent_resource_block, false, false) == null):
			if place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_parent_resource_block):
				inup = 1.0
				wings = 0.0
				paracaidas = 0.0
			elif place_meeting((x - 16.0), y, A.obj_ground) or place_meeting((x - 16.0), y, A.obj_parent_resource_block):
				inup = 2.0
				wings = 0.0
				paracaidas = 0.0
			elif place_meeting((x + 16.0), y, A.obj_ground) or place_meeting((x + 16.0), y, A.obj_parent_resource_block):
				inup = 3.0
				wings = 0.0
				paracaidas = 0.0
			else:
				inup = 0.0
		else:
			inup = 0.0


# from objects/obj_pplant_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.id_object = self
		inst.index_object1 = 116.0
		inst.index_object2 = 110.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.s_contorno_1 = self.wings
		inst.s_paracaidas = self.paracaidas


# from objects/obj_pplant_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.plant = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_plant_fire_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_pplant_res:
				inst.obj = A.obj_plant_fire_res
				inst.obj_draw = 110.0
	instance_destroy()


# from objects/obj_pplant_res/Other_14.gml
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


# from objects/obj_pplant_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 or Scr.outside_view(self) > 0.5:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(p_sprite, G.apariencia, (x_draw + para_x), (y_draw - para_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	match inup:
		1.0:
			GM.draw_sprite_ext(sprite_index, image_index, x_draw, (y_draw + 16.0), 1.0, -1.0, 0.0, GM.c_white, m_alpha)
		2.0:
			GM.draw_sprite_ext(sprite_index, image_index, (x_draw + 16.0), y_draw, 1.0, 1.0, 270.0, GM.c_white, m_alpha)
		3.0:
			GM.draw_sprite_ext(sprite_index, image_index, x_draw, (y_draw + 16.0), 1.0, 1.0, 90.0, GM.c_white, m_alpha)
		_:
			GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite_ext(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
