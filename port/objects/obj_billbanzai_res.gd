extends "res://objects/obj_parent_resource.gd"

var R: float = 0.0
var poder_girar: float = 0.0


# from objects/obj_billbanzai_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_64x64
	R = 0.0
	rotacion = 0.0
	poder_girar = 0.0
	direct_t = 1.0
	alarm[1] = 2.0


# from objects/obj_billbanzai_res/Step_1.gml
func _step_begin() -> void:
	pass


# from objects/obj_billbanzai_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_banzaibill
				image_speed = 0.0
				if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			1.0:
				sprite_index = A.spr_SMB3_banzaibill
				image_speed = 0.0
				if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			2.0:
				sprite_index = A.spr_banzaibill
			3.0:
				sprite_index = A.spr_NSMBU_banzaibill
				image_speed = 0.0
				match G.bg_level:
					"airship", "sky":
						image_index = 6.0
					"desert":
						image_index = 5.0
					"forest":
						image_index = 4.0
					"ghost":
						image_index = 3.0
					"castle":
						image_index = 2.0
					"underground":
						image_index = 1.0
					"mountain":
						image_index = 2.0 if G.modo_noche == 1.0 else 6.0
					_:
						image_index = 1.0 if G.modo_noche == 1.0 else 0.0
	if poder_girar == 1.0:
		if rotacion >= (R + 90.0):
			rotacion = (R + 90.0)
			R = rotacion
			poder_girar = 0.0
		else:
			rotacion += 10.0


# from objects/obj_billbanzai_res/Alarm_1.gml
func _alarm_1() -> void:
	R = rotacion


# from objects/obj_billbanzai_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			inst.index_object1 = 3.0
		else:
			inst.index_object1 = 2.0
		inst.index_object2 = 4.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.number = 2.1


# from objects/obj_billbanzai_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.billbanzai = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_billbanzai_red_res)):
		inst.R = self.R
		inst.rotacion = self.rotacion
		inst.direct_t = self.direct_t
		inst.s_scaley = self.s_scaley
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_billbanzai_res:
				inst.obj = A.obj_billbanzai_red_res
				inst.obj_draw = 4.0
	instance_destroy()


# from objects/obj_billbanzai_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, 1.0, s_scaley, rotacion, GM.c_white, 1.0)
	if drag == 0.0:
		GM.draw_sprite_ext(A.spr_button_change, 0.0, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_billbanzai_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x - 11.0) and GM.mouse_y > (y - 11.0) and GM.mouse_x < (x + 11.0) and GM.mouse_y < (y + 11.0):
						if poder_girar == 0.0:
							GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
							if direct_t == 4.0:
								direct_t = 1.0
							else:
								direct_t += 1.0
							if direct_t == 3.0 or direct_t == 4.0:
								s_scaley = -1.0
							else:
								s_scaley = 1.0
							poder_girar = 1.0
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
