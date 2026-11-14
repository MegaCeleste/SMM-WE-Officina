extends "res://objects/obj_parent_resource.gd"


# from objects/obj_big_pplant_b_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	grid_selected = A.spr_grid_selected_96x96
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0


# from objects/obj_big_pplant_b_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		#
		#    image_index = global.apariencia
		#    if ((!collision_rectangle(bbox_left, (bbox_bottom + 1), bbox_right, (bbox_bottom + 1), obj_ground, 0, 0)) && (!collision_rectangle(bbox_left, (bbox_bottom + 1), bbox_right, (bbox_bottom + 1), obj_parent_resource_block, 0, 0)))
		#    {
		#        if (place_meeting(x, (y - 16), obj_ground) || place_meeting(x, (y - 16), obj_parent_resource_block))
		#        {
		#            inup = 1
		#            wings = 0
		#            paracaidas = 0
		#        }
		#        else if (place_meeting((x - 16), y, obj_ground) || place_meeting((x - 16), y, obj_parent_resource_block))
		#        {
		#            inup = 2
		#            wings = 0
		#            paracaidas = 0
		#        }
		#        else if (place_meeting((x + 16), y, obj_ground) || place_meeting((x + 16), y, obj_parent_resource_block))
		#        {
		#            inup = 3
		#            wings = 0
		#            paracaidas = 0
		#        }
		#        else
		#            inup = 0
		#    }
		#    else
		#        inup = 0
		#
		pass


# from objects/obj_big_pplant_b_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 0.0
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_big_pplant_b_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
	GM.instance_create(x, (y + 16.0), A.obj_big_pplant_res)
	instance_destroy()


# from objects/obj_big_pplant_b_res/Other_14.gml
func _user_4() -> void:
	return


# from objects/obj_big_pplant_b_res/Draw_0.gml
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
