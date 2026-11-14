extends "res://objects/obj_parent_resource.gd"

var direct: float = 0.0


# from objects/obj_cooligan_res/Create_0.gml
func _create() -> void:
	super._create()
	# Set sprites
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_cooligan_idle
			1.0:
				if G.modo_noche == 0.0:
					sprite_index = A.spr_SMB3_cooligan_idle
				else:
					sprite_index = A.spr_SMB3_cooligan_idle_n
			2.0:
				sprite_index = A.spr_cooligan_idle
			3.0:
				sprite_index = A.spr_NSMBU_cooligan_res
	grid_selected = A.spr_grid_selected_32x16
	direct = -1.0
	image_speed = 0.0


# from objects/obj_cooligan_res/Step_2.gml
func _step_end() -> void:
	# Set sprites
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_cooligan_idle
			1.0:
				if (G.modo_noche == 0.0) and (G.bg_level != "underground") and (G.bg_level != "ghost"):
					sprite_index = A.spr_SMB3_cooligan_idle
				else:
					sprite_index = A.spr_SMB3_cooligan_idle_n
			2.0:
				sprite_index = A.spr_cooligan_idle
			3.0:
				sprite_index = A.spr_NSMBU_cooligan_res


# from objects/obj_cooligan_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 or Scr.outside_view(self) > 0.5:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if G.apariencia != 3.0:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex * direct, s_scaley, rotacion, GM.c_white, m_alpha)
	else:
		Scr.draw_sprite_custom_origin(self, sprite_index, image_index, x_draw, y_draw, 18.0, -5.0, s_scalex * direct, s_scaley, rotacion, GM.c_white, m_alpha)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
