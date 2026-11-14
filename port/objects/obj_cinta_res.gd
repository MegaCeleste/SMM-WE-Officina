extends "res://objects/obj_parent_resource.gd"

var index: float = 0.0
var anim: float = 0.0
var crecer_h: float = 0.0
var crecer_v: float = 0.0
var size_x: float = 0.0
var size_y: float = 0.0
var size_limit_x: float = 0.0
var size_limit_y: float = 0.0
var poder_girar: float = 0.0
var draw_p: float = 0.0
var h = null


# from objects/obj_cinta_res/Create_0.gml
func _create() -> void:
	super._create()
	#
	# if room = rm_editor
	# 	instance_destroy()
	# 	/*
	index = 0.0
	anim = 0.0
	crecer_h = 0.0
	crecer_v = 0.0
	size_x = 3.0
	size_y = 3.0
	size_limit_x = 9.0
	size_limit_y = 9.0
	poder_girar = 0.0
	draw_p = 0.0
	direct_t = 3.0
	color = G.cintas
	alarm[3] = 1.0
	pos_cal = 1.0
	alarm[5] = 15.0


# from objects/obj_cinta_res/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 0.0:
		if G.bg_level == "castle":
			if color == 0.0:
				sprite_index = A.spr_SMB_cinta_dark_res
			else:
				sprite_index = A.spr_SMB_cinta_fast_dark_res
		elif (G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0)):
			if color == 0.0:
				sprite_index = A.spr_SMB_cinta_night_res
			else:
				sprite_index = A.spr_SMB_cinta_fast_night_res
		elif color == 0.0:
			sprite_index = A.spr_SMB_cinta_res
		else:
			sprite_index = A.spr_SMB_cinta_fast_res
	elif G.apariencia == 1.0:
		if G.bg_level == "castle":
			if color == 0.0:
				sprite_index = A.spr_SMB3_cinta_dark_res
			else:
				sprite_index = A.spr_SMB3_cinta_fast_dark_res
		elif (G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0)):
			if color == 0.0:
				sprite_index = A.spr_SMB3_cinta_night_res
			else:
				sprite_index = A.spr_SMB3_cinta_fast_night_res
		elif color == 0.0:
			sprite_index = A.spr_SMB3_cinta_res
		else:
			sprite_index = A.spr_SMB3_cinta_fast_res
	elif G.apariencia == 2.0:
		if color == 0.0:
			sprite_index = A.spr_cinta_res
		else:
			sprite_index = A.spr_cinta_fast_res
	elif G.apariencia == 3.0:
		if color == 0.0:
			sprite_index = A.spr_NSMBU_cinta_res
		else:
			sprite_index = A.spr_NSMBU_cinta_fast_res
	elif color == 0.0:
		sprite_index = A.spr_SMB_cinta_res
	else:
		sprite_index = A.spr_SMB_cinta_fast_res
	if poder_girar == 1.0:
		anim += 0.06
	else:
		anim = 0.0
	if crecer_h == 1.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_x += 1.0
		image_xscale = size_x
		mask_index = A.spr_square
		crecer_h = 0.0
	elif crecer_h == 2.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_x -= 1.0
		image_xscale = size_x
		mask_index = A.spr_square
		crecer_h = 0.0
	if GM.mouse_check_button(GM.mb_left) and ((GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0) and ((poder_girar == 1.0) and ((crecer_h == 0.0) and (crecer_v == 0.0)))):
		if (GM.mouse_x > (x + (16.0 * size_x))) and ((GM.mouse_x < (x + ((16.0 * size_x) + 16.0))) and (size_x < size_limit_x)):
			crecer_h = 1.0
		elif (GM.mouse_x < (x + ((16.0 * size_x) - 16.0))) and ((GM.mouse_x > (x + ((16.0 * size_x) - 32.0))) and (size_x > 3.0)):
			crecer_h = 2.0
	elif GM.mouse_check_button_released(GM.mb_left) and ((GM.instance_find(A.obj_levelmanager, 0).editor == 1.0) and (draw_p == 1.0)):
		poder_girar = 0.0
		draw_p = 0.0
		for inst in GM.with_list(A.obj_cursor):
			inst.move_tuberia = 0.0
		pos_cal = 1.0
		alarm[5] = 15.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_cinta_res/Alarm_3.gml
func _alarm_3() -> void:
	mask_index = A.spr_square
	image_xscale = size_x


# from objects/obj_cinta_res/Alarm_5.gml
func _alarm_5() -> void:
	pos_cal = 0.0


# from objects/obj_cinta_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if (pos_cal == 1.0) and (other != self):
		var _previous_other: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif (inst.object_index != A.obj_platform_res) and ((inst.object_index != A.obj_platform_blue_res) and ((inst.object_index != A.obj_vine_res) and ((inst.object_index != A.obj_semisolid_platform1) and (inst.object_index != A.obj_mushroom_platform_res)))):
				inst.instance_destroy()
		GM.other = _previous_other


# from objects/obj_cinta_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 42.0
		inst.index_object2 = 40.0
		inst.number = 10.0
		if self.color == 0.0:
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
			inst.s_contorno_1 = 0.0
		else:
			inst.selected_1 = 0.0
			inst.selected_2 = 1.0
			inst.s_contorno_1 = 0.0


# from objects/obj_cinta_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	if color == 0.0:
		G.cintas = 1.0
		color = 1.0
	else:
		G.cintas = 0.0
		color = 0.0
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_cinta_res:
				if self.color == 0.0:
					inst.obj_draw = 42.0
				else:
					inst.obj_draw = 40.0


# from objects/obj_cinta_res/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_cinta)):
		inst.size_x = self.size_x
		inst.direct_t = self.direct_t
		inst.velocidad = self.color
		inst.image_xscale = self.size_x


# from objects/obj_cinta_res/Other_15.gml
func _user_5() -> void:
	GM.audio_play_sound(A.snd_miniwindow_seleccionar, 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_cinta_on_res)):
		inst.size_x = self.size_x
		inst.direct_t = self.direct_t
		inst.color = self.color
	instance_destroy()


# from objects/obj_cinta_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		if drop_lock == 1.0:
			GM.draw_sprite_ext(grid_selected, 1.0, (floorf(((GM.mouse_x + xx) / 16.0)) * 16.0), (floorf(((GM.mouse_y + yy) / 16.0)) * 16.0), image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(grid_selected, 0.0, (floorf(((GM.mouse_x + xx) / 16.0)) * 16.0), (floorf(((GM.mouse_y + yy) / 16.0)) * 16.0), image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif (mouse_up == 1.0) and (G.cursor == 0.0):
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	h = 0.0
	while h < size_x:
		if h == 0.0:
			if direct_t == 1.0:
				index = 0.0
			else:
				index = 3.0
		elif h == (size_x - 1.0):
			if direct_t == 1.0:
				index = 2.0
			else:
				index = 5.0
		elif direct_t == 1.0:
			index = 1.0
		else:
			index = 4.0
		GM.draw_sprite(sprite_index, index, (x_draw + (h * 16.0)), y_draw)
		h += 1.0
	if drag == 0.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_move_puentes, anim, (x + ((16.0 * size_x) - 16.0)), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
		elif mouse_up == 1.0:
			GM.draw_sprite_ext(A.spr_move_puentes, 0.0, (x + ((16.0 * size_x) - 16.0)), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if drag == 0.0:
		if draw_p == 0.0:
			GM.draw_sprite_ext(A.spr_change_direction, direct_t, ((x + ((16.0 * size_x) / 2.0)) - 9.0), (y - 2.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if (mouse_up == 1.0) and ((drag == 0.0) and (G.cursor == 2.0)):
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)


# from objects/obj_cinta_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if (GM.mouse_x > (x + ((16.0 * size_x) - 16.0))) and ((GM.mouse_x < (x + (16.0 * size_x))) and ((GM.mouse_y > y) and (GM.mouse_y < (y + 16.0)))):
						if poder_girar == 0.0:
							GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
							draw_p = 1.0
							for inst in GM.with_list(A.obj_cursor):
								inst.move_tuberia = 1.0
							poder_girar = 1.0
					elif (GM.mouse_x > ((x + ((16.0 * size_x) / 2.0)) - 8.0)) and ((GM.mouse_x < ((x + ((16.0 * size_x) / 2.0)) + 8.0)) and ((GM.mouse_y > y) and (GM.mouse_y < (y + 16.0)))):
						GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
						if direct_t == 3.0:
							direct_t = 1.0
						else:
							direct_t = 3.0
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
