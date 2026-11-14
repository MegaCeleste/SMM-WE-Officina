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


# from objects/obj_puente_res/Create_0.gml
func _create() -> void:
	super._create()
	index = 0.0
	anim = 0.0
	crecer_h = 0.0
	crecer_v = 0.0
	size_x = 3.0
	size_y = 3.0
	size_limit_x = 20.0
	size_limit_y = 20.0
	poder_girar = 0.0
	draw_p = 0.0
	alarm[3] = 1.0


# from objects/obj_puente_res/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 0.0:
		match G.bg_level:
			"snow":
				if G.modo_noche == 1.0:
					sprite_index = A.spr_SMB_puente_snow_night
				else:
					sprite_index = A.spr_SMB_puente_snow
			"ghost":
				sprite_index = A.spr_SMB_puente_ghost
			"castle":
				sprite_index = A.spr_SMB_puente_dark
			"airship":
				sprite_index = A.spr_SMB_puente_dark
			"underground":
				sprite_index = A.spr_SMB_puente_night
			"mountain":
				if G.modo_noche == 1.0:
					sprite_index = A.spr_SMB_puente_night
				else:
					sprite_index = A.spr_SMB_puente
			_:
				sprite_index = A.spr_SMB_puente
	elif G.apariencia == 1.0:
		var _switch_value1 = G.bg_level
		var _switch_case2: int = -1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "snow"):
			_switch_case2 = 0
		if _switch_case2 < 0 and GM.veq(_switch_value1, "castle"):
			_switch_case2 = 1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underground"):
			_switch_case2 = 2
		if _switch_case2 < 0 and GM.veq(_switch_value1, "ghost"):
			_switch_case2 = 3
		if _switch_case2 < 0 and GM.veq(_switch_value1, "mountain"):
			_switch_case2 = 4
		if _switch_case2 < 0:
			_switch_case2 = 5
		while true:
			if _switch_case2 >= 0 and _switch_case2 <= 0:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_SMB3_puente_snow_night
				else:
					sprite_index = A.spr_SMB3_puente_snow
				break
			if _switch_case2 >= 0 and _switch_case2 <= 1:
				sprite_index = A.spr_SMB3_puente_dark
				break
			if _switch_case2 >= 0 and _switch_case2 <= 2:
				sprite_index = A.spr_SMB3_puente_night
				break
			if _switch_case2 >= 0 and _switch_case2 <= 3:
				sprite_index = A.spr_SMB3_puente_night
				break
			if _switch_case2 >= 0 and _switch_case2 <= 4:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_SMB3_puente_dark
				else:
					sprite_index = A.spr_SMB3_puente
				break
			if _switch_case2 >= 0 and _switch_case2 <= 5:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_SMB3_puente_night
					break
				else:
					sprite_index = A.spr_SMB3_puente
			break
	elif G.apariencia == 2.0:
		match G.bg_level:
			"snow":
				if G.modo_noche == 1.0:
					sprite_index = A.spr_puente_snow_night
				else:
					sprite_index = A.spr_puente_snow
			"underground":
				sprite_index = A.spr_puente_night
			"underwater":
				sprite_index = A.spr_puente_night
			"ghost":
				sprite_index = A.spr_puente_night
			"airship":
				sprite_index = A.spr_puente_night
			"castle":
				sprite_index = A.spr_puente_night
			"mountain":
				if G.modo_noche == 1.0:
					sprite_index = A.spr_puente_night
				else:
					sprite_index = A.spr_puente
			_:
				sprite_index = A.spr_puente
	elif G.apariencia == 3.0:
		var _switch_value3 = G.bg_level
		var _switch_case4: int = -1
		if _switch_case4 < 0 and GM.veq(_switch_value3, "snow"):
			_switch_case4 = 0
		if _switch_case4 < 0 and GM.veq(_switch_value3, "forest"):
			_switch_case4 = 1
		if _switch_case4 < 0 and GM.veq(_switch_value3, "airship"):
			_switch_case4 = 2
		if _switch_case4 < 0 and GM.veq(_switch_value3, "underwater"):
			_switch_case4 = 3
		if _switch_case4 < 0 and GM.veq(_switch_value3, "castle"):
			_switch_case4 = 4
		if _switch_case4 < 0 and GM.veq(_switch_value3, "underground"):
			_switch_case4 = 5
		if _switch_case4 < 0 and GM.veq(_switch_value3, "ghost"):
			_switch_case4 = 6
		if _switch_case4 < 0 and GM.veq(_switch_value3, "beach"):
			_switch_case4 = 7
		if _switch_case4 < 0 and GM.veq(_switch_value3, "mountain"):
			_switch_case4 = 8
		if _switch_case4 < 0:
			_switch_case4 = 9
		while true:
			if _switch_case4 >= 0 and _switch_case4 <= 0:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_NSMBU_puente_snow_night
				else:
					sprite_index = A.spr_NSMBU_puente_snow
				break
			if _switch_case4 >= 0 and _switch_case4 <= 1:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_NSMBU_puente_forest_night
				else:
					sprite_index = A.spr_NSMBU_puente_forest
				break
			if _switch_case4 >= 0 and _switch_case4 <= 2:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_NSMBU_puente_airship_night
				else:
					sprite_index = A.spr_NSMBU_puente_airship
				break
			if _switch_case4 >= 0 and _switch_case4 <= 3:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_NSMBU_puente_underwater_night
				else:
					sprite_index = A.spr_NSMBU_puente_underwater
				break
			if _switch_case4 >= 0 and _switch_case4 <= 4:
				sprite_index = A.spr_NSMBU_puente_castle
				break
			if _switch_case4 >= 0 and _switch_case4 <= 5:
				sprite_index = A.spr_NSMBU_puente_underground
				break
			if _switch_case4 >= 0 and _switch_case4 <= 6:
				sprite_index = A.spr_NSMBU_puente_underground
				break
			if _switch_case4 >= 0 and _switch_case4 <= 7:
				sprite_index = A.spr_NSMBU_puente_beach
				break
			if _switch_case4 >= 0 and _switch_case4 <= 8:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_NSMBU_puente_volcano
				else:
					sprite_index = A.spr_NSMBU_puente_overworld
				break
			if _switch_case4 >= 0 and _switch_case4 <= 9:
				if G.modo_noche == 1.0:
					sprite_index = A.spr_NSMBU_puente_overworld_night
					break
				else:
					sprite_index = A.spr_NSMBU_puente_overworld
			break
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
	if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and poder_girar == 1.0 and crecer_h == 0.0 and crecer_v == 0.0:
		if GM.mouse_x > (x + (16.0 * size_x)) and GM.mouse_x < (x + ((16.0 * size_x) + 16.0)) and size_x < (size_limit_x + 1.0):
			crecer_h = 1.0
		elif GM.mouse_x < (x + ((16.0 * size_x) - 16.0)) and GM.mouse_x > (x + ((16.0 * size_x) - 32.0)) and size_x > 3.0:
			crecer_h = 2.0
	elif GM.mouse_check_button_released(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and draw_p == 1.0:
		poder_girar = 0.0
		draw_p = 0.0
		for _obj_write5 in GM.with_list(A.obj_cursor):
			_obj_write5.move_tuberia = 0.0
		pos_cal = 1.0
		alarm[5] = 15.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_puente_res/Alarm_3.gml
func _alarm_3() -> void:
	mask_index = A.spr_square
	image_xscale = size_x


# from objects/obj_puente_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if pos_cal == 1.0 and other != self:
		var _with_target7 = other
		var _other6: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target7):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res and inst.object_index != A.obj_door_res and inst.object_index != A.obj_door_exit_res and inst.object_index != A.obj_door_switch_res and inst.object_index != A.obj_door_switch_exit_res and inst.object_index != A.obj_door_lock_exit_res and inst.object_index != A.obj_door_lock_res and inst.object_index != A.obj_grinder_res:
				inst.instance_destroy()
		GM.other = _other6


# from objects/obj_puente_res/Other_13.gml
func _user_3() -> void:
	var _with_target9 = GM.instance_create(x, y, A.obj_modelsizable)
	var _other8: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target9):
		inst.sprite = self.sprite_index
		inst.size_x = self.size_x
		inst.depth = self.depth
		inst.image_xscale = self.size_x
		inst.type = 2.0
	GM.other = _other8


# from objects/obj_puente_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, 1.0, 0.0, GM.c_white, 1.0)
	h = 0.0
	while h < size_x:
		if h == 0.0:
			index = 0.0
		elif h == (size_x - 1.0):
			index = 2.0
		else:
			index = 1.0
		GM.draw_sprite(sprite_index, index, (x_draw + (h * 16.0)), y_draw)
		h += 1.0
	if drag == 0.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_move_puentes, anim, (x + ((16.0 * size_x) - 16.0)), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
		elif mouse_up == 1.0:
			GM.draw_sprite_ext(A.spr_move_puentes, 0.0, (x + ((16.0 * size_x) - 16.0)), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)


# from objects/obj_puente_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and G.resource_create == 0.0 and (Scr.scr_insideview(self) > 0.5) and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + ((16.0 * size_x) - 16.0)) and GM.mouse_x < (x + (16.0 * size_x)) and GM.mouse_y > y and GM.mouse_y < (y + 16.0):
						poder_girar = 1.0
						draw_p = 1.0
						for _obj_write10 in GM.with_list(A.obj_cursor):
							_obj_write10.move_tuberia = 1.0
					else:
						GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
						xx = (x - GM.mouse_x)
						yy = (y - GM.mouse_y)
						var _with_target12 = A.obj_creation_preview
						var _other11: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(_with_target12):
							inst.xx = self.xx
							inst.yy = self.yy
						GM.other = _other11
						x_start = x
						y_start = y
						G.resource_block = 1.0
						drag = 1.0
						for _obj_write13 in GM.with_list(A.obj_cursor):
							_obj_write13.move = 1.0
						ventana = 1.0
						G.cursor = 1.0
						var _with_target15 = A.obj_cursor
						var _other14: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(_with_target15):
							inst.event_user(0)
						GM.other = _other14
						if not GM.instance_exists(A.obj_effect_touch):
							GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
						G.resource_move = object_index
						alarm[0] = 1.0
