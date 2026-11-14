extends "res://objects/obj_parent_resource.gd"

var index = null
var anim: float = 0.0
var crecer_h: float = 0.0
var crecer_v: float = 0.0
var size_x: float = 0.0
var size_y: float = 0.0
var size_limit_x: float = 0.0
var size_limit_y: float = 0.0
var poder_girar: float = 0.0
var draw_p: float = 0.0
var v = null
var h = null


# from objects/obj_semisolid_platform1/Create_0.gml
func _create() -> void:
	super._create()
	index = 0.0
	anim = 0.0
	color = G.semisolid_platform
	crecer_h = 0.0
	crecer_v = 0.0
	size_x = 3.0
	size_y = 3.0
	size_limit_x = 20.0
	size_limit_y = 26.0
	poder_girar = 0.0
	draw_p = 0.0
	depth = (271.0 - (GM.gm_round(y) / 16.0))
	alarm[3] = 1.0


# from objects/obj_semisolid_platform1/Step_2.gml
func _step_end() -> void:
	if color == 0.0:
		sprite_index = Scr.scr_semisolid_platform1_sprites(self)
	elif color == 1.0:
		sprite_index = Scr.scr_semisolid_platform2_sprites(self)
	else:
		sprite_index = Scr.scr_semisolid_platform3_sprites(self)
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
		_user_5()
	elif crecer_h == 2.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_x -= 1.0
		image_xscale = size_x
		mask_index = A.spr_square
		crecer_h = 0.0
		_user_5()
	if crecer_v == 1.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_y += 1.0
		y -= 16.0
		y_draw = y
		mask_index = A.spr_square
		crecer_v = 0.0
		_user_5()
	elif crecer_v == 2.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_y -= 1.0
		y += 16.0
		y_draw = y
		mask_index = A.spr_square
		crecer_v = 0.0
		_user_5()
	if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and poder_girar == 1.0 and crecer_h == 0.0 and crecer_v == 0.0:
		if GM.mouse_x > (x + (16.0 * size_x)) and GM.mouse_x < (x + ((16.0 * size_x) + 16.0)) and size_x < (size_limit_x + 1.0):
			crecer_h = 1.0
		elif GM.mouse_x < (x + ((16.0 * size_x) - 16.0)) and GM.mouse_x > (x + ((16.0 * size_x) - 32.0)) and size_x > 3.0:
			crecer_h = 2.0
		if GM.mouse_y > (y - 16.0) and GM.mouse_y < y and size_y < (size_limit_y + 1.0):
			crecer_v = 1.0
		elif GM.mouse_y < (y + 32.0) and GM.mouse_y > (y + 16.0) and size_y > 3.0:
			crecer_v = 2.0
	elif GM.mouse_check_button_released(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and draw_p == 1.0:
		poder_girar = 0.0
		draw_p = 0.0
		for _obj_write1 in GM.with_list(A.obj_cursor):
			_obj_write1.move_tuberia = 0.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_semisolid_platform1/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		image_speed = 0.0
		image_index = 0.0
		if place_meeting(x, y, A.obj_arrow_lock):
			drop_lock = 1.0
		else:
			drop_lock = 0.0
		depth = -19.0
		x_draw = (GM.mouse_x + xx)
		y_draw = (GM.mouse_y + yy)
		x = (GM.mouse_x + xx)
		y = (GM.mouse_y + yy)
		move_snap(16.0, 16.0)
		if play_sound == 0.0 and (x != x_start or y != y_start):
			GM.audio_play_sound(A.snd_drag, 0.0, false)
			play_sound = 1.0
		if x != prev_x or y != prev_y:
			GM.audio_stop_sound(A.snd_move_object)
			GM.audio_play_sound(A.snd_move_object, 0.0, false)
			prev_x = x
			prev_y = y
			if GM.instance_exists(A.obj_ventana):
				var _with_target5 = A.obj_ventana
				var _other4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target5):
					inst.can_anim2 = 1.0
				GM.other = _other4
		if ventana > 0.0 and x == x_start and y == y_start:
			ventana += 0.5
			if ventana >= 14.0:
				_user_0()
				ventana = 0.0
		else:
			ventana = 0.0
		G.editor_lock = 1.0
		alarm[0] = 1.0
	else:
		if drop_lock == 1.0:
			GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
			x = x_start
			y = y_start
		elif x != x_start or y != y_start:
			GM.audio_play_sound(A.snd_mario_add, 0.0, false)
		move_snap(16.0, 16.0)
		drop_lock = 0.0
		ventana = 0.0
		depth = laller
		play_sound = 0.0
		_user_5()
		x_draw = x
		y_draw = y
		x_start = x
		y_start = y
		G.editor_lock = 0.0
		G.resource_block = 0.0


# from objects/obj_semisolid_platform1/Alarm_3.gml
func _alarm_3() -> void:
	mask_index = A.spr_square
	image_xscale = size_x


# from objects/obj_semisolid_platform1/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	return


# from objects/obj_semisolid_platform1/Other_10.gml
func _user_0() -> void:
	var _with_target10 = GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)
	var _other9: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target10):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 50.0
		inst.index_object2 = 51.0
		inst.index_object3 = 52.0
		if self.color == 0.0:
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
			inst.selected_3 = 0.0
		elif self.color == 1.0:
			inst.selected_1 = 0.0
			inst.selected_2 = 1.0
			inst.selected_3 = 0.0
		else:
			inst.selected_1 = 0.0
			inst.selected_2 = 0.0
			inst.selected_3 = 1.0
		inst.number = 7.0
	GM.other = _other9


# from objects/obj_semisolid_platform1/Other_11.gml
func _user_1() -> void:
	var _with_target12 = GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)
	var _other11: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target12):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	GM.other = _other11
	G.semisolid_platform = transform
	color = transform
	if GM.instance_exists(A.obj_card_item):
		var _with_target14 = A.obj_card_item
		var _other13: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target14):
			if inst.obj == A.obj_semisolid_platform1:
				if self.color == 0.0:
					inst.obj_draw = 50.0
				elif self.color == 1.0:
					inst.obj_draw = 51.0
				elif self.color == 2.0:
					inst.obj_draw = 52.0
		GM.other = _other13


# from objects/obj_semisolid_platform1/Other_13.gml
func _user_3() -> void:
	var _with_target16 = GM.instance_create(x, y, A.obj_modelsizable)
	var _other15: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target16):
		inst.sprite = self.sprite_index
		inst.size_x = self.size_x
		inst.size_y = self.size_y
		inst.depth = self.depth
		inst.image_xscale = self.size_x
		inst.type = 0.0
	GM.other = _other15


# from objects/obj_semisolid_platform1/Other_15.gml
func _user_5() -> void:
	depth = (271.0 - (GM.gm_round(y) / 16.0))


# from objects/obj_semisolid_platform1/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, size_y, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, size_y, 0.0, GM.c_white, 1.0)
	var m1 = 3.0
	var m2 = 4.0
	var m3 = 5.0
	v = 0.0
	while v < size_y:
		h = 0.0
		while h < size_x:
			if v == 0.0:
				if h == 0.0:
					index = 0.0
				elif h == (size_x - 1.0):
					index = 2.0
				else:
					index = 1.0
			elif v == (size_y - 1.0):
				if h == 0.0:
					index = 9.0
				elif h == (size_x - 1.0):
					index = 11.0
				else:
					index = 10.0
			elif h == 0.0:
				index = m1
			elif h == (size_x - 1.0):
				index = m3
			else:
				index = m2
			GM.draw_sprite_ext(sprite_index, index, (x_draw + (h * 16.0)), (y_draw + (v * 16.0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			if m1 == 3.0:
				m1 = 6.0
			else:
				m1 = 3.0
			if m2 == 4.0:
				m2 = 7.0
			else:
				m2 = 4.0
			if m3 == 5.0:
				m3 = 8.0
			else:
				m3 = 5.0
			h += 1.0
		if m1 == 3.0:
			m1 = 6.0
		else:
			m1 = 3.0
		if m2 == 4.0:
			m2 = 7.0
		else:
			m2 = 4.0
		if m3 == 5.0:
			m3 = 8.0
		else:
			m3 = 5.0
		v += 1.0
	if drag == 0.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_move_semisolid, anim, (x + ((16.0 * size_x) - 16.0)), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
		elif mouse_up == 1.0:
			GM.draw_sprite_ext(A.spr_move_semisolid, 0.0, (x + ((16.0 * size_x) - 16.0)), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, size_y, 0.0, GM.c_white, 1.0)


# from objects/obj_semisolid_platform1/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and (Scr.scr_insideview(self) > 0.5) and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + ((16.0 * size_x) - 16.0)) and GM.mouse_x < (x + (16.0 * size_x)) and GM.mouse_y > y and GM.mouse_y < (y + 16.0):
						poder_girar = 1.0
						draw_p = 1.0
						for _obj_write17 in GM.with_list(A.obj_cursor):
							_obj_write17.move_tuberia = 1.0
					else:
						GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
						xx = (x - GM.mouse_x)
						yy = (y - GM.mouse_y)
						var _with_target19 = A.obj_creation_preview
						var _other18: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(_with_target19):
							inst.xx = self.xx
							inst.yy = self.yy
						GM.other = _other18
						x_start = x
						y_start = y
						G.resource_block = 1.0
						drag = 1.0
						for _obj_write20 in GM.with_list(A.obj_cursor):
							_obj_write20.move = 1.0
						ventana = 1.0
						G.cursor = 1.0
						var _with_target22 = A.obj_cursor
						var _other21: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(_with_target22):
							inst.event_user(0)
						GM.other = _other21
						if not GM.instance_exists(A.obj_effect_touch):
							GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
						G.resource_move = object_index
						alarm[0] = 1.0
