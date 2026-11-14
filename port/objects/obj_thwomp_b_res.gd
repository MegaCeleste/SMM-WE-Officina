extends "res://objects/obj_parent_resource.gd"

var poder_girar: float = 0.0


# from objects/obj_thwomp_b_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_64x64_2
	rotacion = 0.0
	poder_girar = 0.0
	direct_t = 1.0
	wings_x = 17.0
	wings_y = 25.0
	p_sprite = A.spr_paracaidas_editor
	para_x = 8.0
	para_y = 16.0


# from objects/obj_thwomp_b_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_thwomp_b_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 132.0
		inst.index_object2 = 217.0
		inst.s_hongo_1 = 1.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.number = 13.0


# from objects/obj_thwomp_b_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.grrrol = 1.0
	GM.instance_create(x, (y - 16.0), A.obj_grrrol_res)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_thwomp_res:
				inst.obj = A.obj_grrrol_res
				inst.obj_draw = 217.0
	instance_destroy()


# from objects/obj_thwomp_b_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
		inst.girar = 1.0
		inst.sprite_index = A.spr_mushroon_deads
		inst.image_index = G.apariencia
		inst.hspeed = 1.0
	for inst in GM.with_list(GM.instance_create((x), (y), A.obj_thwomp_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	instance_destroy()


# from objects/obj_thwomp_b_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite(p_sprite, G.apariencia, (x_draw + para_x), (y_draw - para_y))
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, 0.0, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y))
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if drag == 0.0:
		GM.draw_sprite_ext(A.spr_button_change_thwomp, 0.0, x, y + 32.0, 1.0, 1.0, rotacion, GM.c_white, 1.0)


# from objects/obj_thwomp_b_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and G.resource_create == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + -11.0) and GM.mouse_y > (y + 14.0) and GM.mouse_x < (x + 18.0) and GM.mouse_y < (y + 50.0):
						GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
						if direct_t == 1.0:
							direct_t = 2.0
							rotacion = 270.0
						elif direct_t == 2.0:
							direct_t = 3.0
							rotacion = 90.0
						elif direct_t == 3.0:
							direct_t = 1.0
							rotacion = 0.0
					else:
						GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
						xx = (x - GM.mouse_x)
						yy = (y - GM.mouse_y)
						for inst in GM.with_list(A.obj_creation_preview):
							inst.xx = self.xx
							inst.yy = self.yy
						x_start = x
						y_start = y
						G.resource_block = 1.0
						drag = 1.0
						for inst in GM.with_list(A.obj_cursor):
							inst.move = 1.0
						ventana = 1.0
						G.cursor = 1.0
						var _other_with_1: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(A.obj_cursor):
							inst.event_user(0)
						GM.other = _other_with_1
						if not GM.instance_exists(A.obj_effect_touch):
							GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
						G.resource_move = object_index
						alarm[0] = 1.0
