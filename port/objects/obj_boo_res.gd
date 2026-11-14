extends "res://objects/obj_parent_resource.gd"


# from objects/obj_boo_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 17.0
	wings_y = 18.0


# from objects/obj_boo_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if inup != 0.0:
			sprite_index = A.spr_boo_stretch_res
			image_index = G.apariencia
		else:
			match G.apariencia:
				0.0:
					sprite_index = A.spr_SMB_boo_res
				1.0:
					sprite_index = A.spr_SMB3_boo_res
				2.0:
					sprite_index = A.spr_boo_res
				3.0:
					if G.bg_level == "ghost":
						sprite_index = A.spr_NSMBU_boo_ghost_res
					else:
						sprite_index = A.spr_NSMBU_boo_overworld_res
			image_index = 0.0
		if (place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_parent_resource_block)) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_ground, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_parent_resource_block, false, false) == null):
			inup = 1.0
			wings = 0.0
		elif place_meeting(x, (y + 16.0), A.obj_ground) or place_meeting(x, (y + 16.0), A.obj_parent_resource_block):
			inup = 2.0
			wings = 0.0
		else:
			inup = 0.0


# from objects/obj_boo_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 or Scr.outside_view(self) > 0.5:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
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
