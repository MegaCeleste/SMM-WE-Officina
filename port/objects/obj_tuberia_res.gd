extends "res://objects/obj_parent_resource_block.gd"

var sprite: float = 0.0
var part: float = 0.0
var right: float = 0.0
var left: float = 0.0
var R = null
var poder_girar: float = 0.0
var crecer: float = 0.0
var draw_p: float = 0.0
var plant = null
var id_pipe = null
var t_x_pos = null
var t_y_pos = null
var t_size = null
var t_rotacion = null
var t_direct_t = null
var t_s_scalex = null
var t_color = null
var t_xscale = null
var t_yscale = null
var anim = null


# from objects/obj_tuberia_res/Create_0.gml
func _create() -> void:
	var dark
	super._create()
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match float(G.apariencia):
		0.0:
			sprite = A.spr_SMB_pipes
			part = A.spr_SMB_pipes_part
		1.0:
			if dark == 1.0:
				sprite = A.spr_SMB3_pipes_night
				part = A.spr_SMB3_pipes_part_night
			else:
				sprite = A.spr_SMB3_pipes
				part = A.spr_SMB3_pipes_part
		2.0:
			sprite = A.spr_pipes
			part = A.spr_pipes_part
		3.0:
			sprite = A.spr_NSMBU_pipes
			part = A.spr_NSMBU_pipes_part
	grid_selected = A.spr_grid_selected_32x32
	color = G.tuberia
	right = 0.0
	left = 0.0
	R = 0.0
	rotacion = 0.0
	poder_girar = 0.0
	size = 0.0
	crecer = 0.0
	draw_p = 0.0
	plant = 0.0
	exception = 1.0
	alarm[2] = 2.0
	warp = 0.0
	id_pipe = null
	t_x_pos = (x + 32.0)
	t_y_pos = y
	t_size = 0.0
	t_rotacion = 0.0
	t_direct_t = 0.0
	t_s_scalex = 1.0
	t_color = 0.0
	t_xscale = 1.0
	t_yscale = 1.0
	alarm[1] = 1.0


# from objects/obj_tuberia_res/Destroy_0.gml
func _destroy() -> void:
	if warp > 0.0:
		GM.instance_activate_object(id_pipe)
		var _with_target2 = id_pipe
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			inst.instance_destroy()
		GM.other = _other1


# from objects/obj_tuberia_res/Step_2.gml
func _step_end() -> void:
	var dark
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match float(G.apariencia):
		0.0:
			sprite = A.spr_SMB_pipes
			part = A.spr_SMB_pipes_part
		1.0:
			if dark == 1.0:
				sprite = A.spr_SMB3_pipes_night
				part = A.spr_SMB3_pipes_part_night
			else:
				sprite = A.spr_SMB3_pipes
				part = A.spr_SMB3_pipes_part
		2.0:
			sprite = A.spr_pipes
			part = A.spr_pipes_part
		3.0:
			sprite = A.spr_NSMBU_pipes
			part = A.spr_NSMBU_pipes_part
	image_index = color
	if left == 1.0:
		if rotacion >= (R + 90.0):
			rotacion = (R + 90.0)
			R = rotacion
			left = 0.0
			if direct_t == 0.0:
				direct_t = 3.0
			else:
				direct_t -= 1.0
			if direct_t == 3.0 or direct_t == 2.0:
				s_scalex = -1.0
			else:
				s_scalex = 1.0
			if not GM.mouse_check_button(GM.mb_left):
				poder_girar = 0.0
		else:
			rotacion += 10.0
		if warp > 0.0:
			_user_5()
	elif right == 1.0:
		if rotacion <= (R - 90.0):
			rotacion = (R - 90.0)
			R = rotacion
			right = 0.0
			if direct_t == 3.0:
				direct_t = 0.0
			else:
				direct_t += 1.0
			if direct_t == 3.0 or direct_t == 2.0:
				s_scalex = -1.0
			else:
				s_scalex = 1.0
			if not GM.mouse_check_button(GM.mb_left):
				poder_girar = 0.0
		else:
			rotacion -= 10.0
		if warp > 0.0:
			_user_5()
	elif crecer == 1.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		match float(direct_t):
			0.0:
				y -= 16.0
				y_draw -= 16.0
				size += 1.0
				image_yscale = (1.0 + (size / 2.0))
			1.0:
				size += 1.0
				image_xscale = (1.0 + (size / 2.0))
			2.0:
				size += 1.0
				image_yscale = (1.0 + (size / 2.0))
			3.0:
				x -= 16.0
				x_draw -= 16.0
				size += 1.0
				image_xscale = (1.0 + (size / 2.0))
		crecer = 0.0
		if warp > 0.0:
			_user_5()
	elif crecer == 2.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		match float(direct_t):
			0.0:
				y += 16.0
				y_draw += 16.0
				size -= 1.0
				image_yscale = (1.0 + (size / 2.0))
			1.0:
				size -= 1.0
				image_xscale = (1.0 + (size / 2.0))
			2.0:
				size -= 1.0
				image_yscale = (1.0 + (size / 2.0))
			3.0:
				x += 16.0
				x_draw += 16.0
				size -= 1.0
				image_xscale = (1.0 + (size / 2.0))
		crecer = 0.0
		if warp > 0.0:
			_user_5()
	if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and poder_girar == 1.0 and right == 0.0 and left == 0.0:
		match float(direct_t):
			0.0:
				if GM.mouse_x > (x + 32.0) and GM.mouse_x < (x + 64.0) and GM.mouse_y > (y + 16.0) and GM.mouse_y < (y + 32.0) and size == 0.0:
					right = 1.0
				elif GM.mouse_x > (x - 32.0) and GM.mouse_x < x and GM.mouse_y > (y + 16.0) and GM.mouse_y < (y + 32.0) and size == 0.0:
					left = 1.0
				elif GM.mouse_x > (x + 5.0) and GM.mouse_x < (x + 27.0) and GM.mouse_y > (y - 16.0) and GM.mouse_y < y and size < 24.0:
					crecer = 1.0
				elif GM.mouse_x > (x + 5.0) and GM.mouse_x < (x + 27.0) and GM.mouse_y > (y + 16.0) and GM.mouse_y < (y + 32.0) and size > 0.0:
					crecer = 2.0
			1.0:
				if GM.mouse_x > (x + (size * 16.0)) and GM.mouse_x < (x + (16.0 + (size * 16.0))) and GM.mouse_y > (y + 32.0) and GM.mouse_y < (y + 64.0) and size == 0.0:
					right = 1.0
				elif GM.mouse_x > (x + (size * 16.0)) and GM.mouse_x < (x + (16.0 + (size * 16.0))) and GM.mouse_y > (y - 32.0) and GM.mouse_y < y and size == 0.0:
					left = 1.0
				elif GM.mouse_x > (x + (32.0 + (size * 16.0))) and GM.mouse_x < (x + (64.0 + (size * 16.0))) and GM.mouse_y > (y + 5.0) and GM.mouse_y < (y + 27.0) and size < 24.0:
					crecer = 1.0
				elif GM.mouse_x > (x - (16.0 + (size * 16.0))) and GM.mouse_x < (x + (16.0 + (size * 16.0))) and GM.mouse_y > (y + 5.0) and GM.mouse_y < (y + 27.0) and size > 0.0:
					crecer = 2.0
			2.0:
				if GM.mouse_x > (x + 32.0) and GM.mouse_x < (x + 64.0) and GM.mouse_y > (y + (size * 16.0)) and GM.mouse_y < (y + (16.0 + (size * 16.0))) and size == 0.0:
					left = 1.0
				elif GM.mouse_x > (x - 32.0) and GM.mouse_x < x and GM.mouse_y > (y + (size * 16.0)) and GM.mouse_y < (y + (16.0 + (size * 16.0))) and size == 0.0:
					right = 1.0
				elif GM.mouse_x > (x + 5.0) and GM.mouse_x < (x + 27.0) and GM.mouse_y > (y + (32.0 + (size * 16.0))) and GM.mouse_y < (y + (64.0 + (size * 16.0))) and size < 24.0:
					crecer = 1.0
				elif GM.mouse_x > (x + 5.0) and GM.mouse_x < (x + 27.0) and GM.mouse_y > (y - (16.0 + (size * 16.0))) and GM.mouse_y < (y + (16.0 + (size * 16.0))) and size > 0.0:
					crecer = 2.0
			3.0:
				if GM.mouse_x > (x + 16.0) and GM.mouse_x < (x + 32.0) and GM.mouse_y > (y - 32.0) and GM.mouse_y < y and size == 0.0:
					right = 1.0
				elif GM.mouse_x > (x + 16.0) and GM.mouse_x < (x + 32.0) and GM.mouse_y > (y + 32.0) and GM.mouse_y < (y + 64.0) and size == 0.0:
					left = 1.0
				elif GM.mouse_x > (x - 32.0) and GM.mouse_x < x and GM.mouse_y > (y + 5.0) and GM.mouse_y < (y + 27.0) and size < 24.0:
					crecer = 1.0
				elif GM.mouse_x > (x + 16.0) and GM.mouse_x < (x + 48.0) and GM.mouse_y > (y + 5.0) and GM.mouse_y < (y + 27.0) and size > 0.0:
					crecer = 2.0
	elif GM.mouse_check_button_released(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and right == 0.0 and left == 0.0:
		poder_girar = 0.0
	if GM.mouse_check_button_released(GM.mb_left) and draw_p == 1.0:
		draw_p = 0.0
		for _obj_write3 in GM.with_list(A.obj_cursor):
			_obj_write3.move_tuberia = 0.0
		pos_cal = 1.0
		alarm[5] = 15.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)
	if poder_girar == 1.0:
		anim += 0.06
	else:
		anim = 0.0


# from objects/obj_tuberia_res/Alarm_1.gml
func _alarm_1() -> void:
	var plant
	if warp == 1.0:
		_user_6()
	elif warp == 2.0 and (GM.room == A.rm_guardabot_play or GM.room == A.rm_title):
		var _with_target5 = GM.instance_create(x, y, A.obj_tuberia)
		var _other4: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target5):
			inst.sprite = self.sprite
			inst.part = self.part
			inst.size = self.size
			inst.direct = self.s_scalex
			inst.direct_t = self.direct_t
			inst.rotacion = self.rotacion
			inst.index = self.color
			inst.image_xscale = self.image_xscale
			inst.image_yscale = self.image_yscale
			inst.warp = self.warp
			inst.w_direct = self.t_direct_t
			match float(self.t_direct_t):
				0.0:
					inst.w_posx = (self.t_x_pos + 16.0)
					inst.w_posy = self.t_y_pos
				1.0:
					inst.w_posx = (self.t_x_pos + (16.0 + (self.t_size * 16.0)))
					inst.w_posy = self.t_y_pos
				2.0:
					inst.w_posx = (self.t_x_pos + 16.0)
					inst.w_posy = (self.t_y_pos + (16.0 + (self.t_size * 16.0)))
				3.0:
					inst.w_posx = (self.t_x_pos + 16.0)
					inst.w_posy = self.t_y_pos
			match self.direct_t:
				0.0:
					inst.m_posx = (inst.x + 16.0)
					inst.m_posy = inst.y
				1.0:
					inst.m_posx = (inst.x + (16.0 + (self.t_size * 16.0)))
					inst.m_posy = inst.y
				2.0:
					inst.m_posx = (inst.x + 16.0)
					inst.m_posy = (inst.y + (16.0 + (self.t_size * 16.0)))
				3.0:
					inst.m_posx = (inst.x + 16.0)
					inst.m_posy = inst.y
			if self.plant == 1.0:
				match self.direct_t:
					0.0:
						plant = GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_piranhaplant)
					1.0:
						plant = GM.instance_create((inst.x + (16.0 + (self.size * 16.0))), (inst.y + 16.0), A.obj_piranhaplant)
					2.0:
						plant = GM.instance_create((inst.x + 16.0), (inst.y + (16.0 + (self.size * 16.0))), A.obj_piranhaplant)
					3.0:
						plant = GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_piranhaplant)
				plant.direct_t = self.direct_t
				plant.rotacion = self.rotacion
		GM.other = _other4
		instance_destroy()


# from objects/obj_tuberia_res/Alarm_2.gml
func _alarm_2() -> void:
	exception = 0.0


# from objects/obj_tuberia_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if pos_cal == 1.0 and other != self:
		var _with_target7 = other
		var _other6: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target7):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res and inst.object_index != A.obj_door_res and inst.object_index != A.obj_door_exit_res and inst.object_index != A.obj_door_switch_res and inst.object_index != A.obj_door_switch_exit_res and inst.object_index != A.obj_door_lock_res and inst.object_index != A.obj_door_lock_exit_res:
				inst.instance_destroy()
		GM.other = _other6


# from objects/obj_tuberia_res/Collision_obj_pplant_res.gml
func _collision_obj_pplant_res(other: GMObject) -> void:
	if drag == 0.0 and other.drag == 0.0 and plant == 0.0 and warp == 0.0:
		GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
		plant = 1.0
		var _with_target9 = other
		var _other8: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target9):
			inst.instance_destroy()
		GM.other = _other8


# from objects/obj_tuberia_res/Other_10.gml
func _user_0() -> void:
	var _with_target11 = GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)
	var _other10: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target11):
		inst.id_object = self
		inst.index_object1 = 134.0
		inst.index_object2 = 135.0
		inst.index_object3 = 136.0
		inst.index_object4 = 137.0
		if self.color == 0.0:
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
			inst.selected_3 = 0.0
			inst.selected_4 = 0.0
		elif self.color == 1.0:
			inst.selected_1 = 0.0
			inst.selected_2 = 1.0
			inst.selected_3 = 0.0
			inst.selected_4 = 0.0
		elif self.color == 2.0:
			inst.selected_1 = 0.0
			inst.selected_2 = 0.0
			inst.selected_3 = 1.0
			inst.selected_4 = 0.0
		elif self.color == 3.0:
			inst.selected_1 = 0.0
			inst.selected_2 = 0.0
			inst.selected_3 = 0.0
			inst.selected_4 = 1.0
		inst.number = 6.0
	GM.other = _other10


# from objects/obj_tuberia_res/Other_11.gml
func _user_1() -> void:
	if transform == 4.0:
		if warp == 0.0 and size == 0.0:
			GM.audio_stop_sound(Scr.scr_snd_pipes(self))
			GM.audio_play_sound(Scr.scr_snd_pipes(self), 0.0, false)
			t_x_pos = (x + 32.0)
			t_y_pos = y
			warp = 1.0
			_user_6()
	else:
		var _with_target13 = GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)
		var _other12: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target13):
			inst.sprite_index = A.spr_effect_transform
			inst.image_speed = 0.3
		GM.other = _other12
		G.tuberia = transform
		color = transform
		if warp == 2.0:
			_user_5()
		if GM.instance_exists(A.obj_card_item):
			var _with_target15 = A.obj_card_item
			var _other14: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target15):
				if inst.obj == A.obj_tuberia_res:
					match self.color:
						0.0:
							inst.obj_draw = 134.0
						1.0:
							inst.obj_draw = 135.0
						2.0:
							inst.obj_draw = 136.0
						3.0:
							inst.obj_draw = 137.0
			GM.other = _other14


# from objects/obj_tuberia_res/Other_15.gml
func _user_5() -> void:
	GM.instance_activate_object(id_pipe)
	if GM.instance_exists(id_pipe):
		id_pipe.t_x_pos = x
		id_pipe.t_y_pos = y
		id_pipe.t_size = size
		id_pipe.t_rotacion = rotacion
		id_pipe.t_direct_t = direct_t
		id_pipe.t_s_scalex = s_scalex
		id_pipe.t_color = color
		id_pipe.t_xscale = image_xscale
		id_pipe.t_yscale = image_yscale
		t_x_pos = id_pipe.x
		t_y_pos = id_pipe.y
		t_direct_t = id_pipe.direct_t
		t_size = id_pipe.size
		t_rotacion = id_pipe.rotacion
		t_s_scalex = id_pipe.s_scalex
		t_color = id_pipe.color
		t_xscale = id_pipe.image_xscale
		t_yscale = id_pipe.image_yscale


# from objects/obj_tuberia_res/Other_16.gml
func _user_6() -> void:
	var pipe
	pipe = GM.instance_create(t_x_pos, t_y_pos, A.obj_tuberia_res)
	pipe.x = t_x_pos
	pipe.y = t_y_pos
	pipe.x_draw = t_x_pos
	pipe.y_draw = t_y_pos
	pipe.size = t_size
	pipe.rotacion = t_rotacion
	pipe.R = t_rotacion
	pipe.direct_t = t_direct_t
	pipe.s_scalex = t_s_scalex
	pipe.color = t_color
	pipe.image_xscale = t_xscale
	pipe.image_yscale = t_yscale
	pipe.warp = 2.0
	id_pipe = pipe
	pipe.id_pipe = self
	pipe.t_x_pos = x
	pipe.t_y_pos = y
	pipe.t_direct_t = direct_t


# from objects/obj_tuberia_res/Draw_0.gml
func _gm_draw() -> void:
	var xx
	var yy
	var i
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	match float(direct_t):
		0.0:
			if plant == 1.0:
				GM.draw_sprite_ext(A.spr_pplant_res, G.apariencia, (x_draw + 8.0), (y_draw - 8.0), 1.0, 1.0, rotacion, GM.c_white, m_alpha)
			GM.draw_sprite_ext(sprite, image_index, (x_draw + 16.0), (y_draw + 16.0), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
			xx = (x_draw + 16.0)
			yy = (y_draw + 16.0)
		1.0:
			if plant == 1.0:
				GM.draw_sprite_ext(A.spr_pplant_res, G.apariencia, (x_draw + (40.0 + (size * 16.0))), (y_draw + 8.0), 1.0, 1.0, rotacion, GM.c_white, m_alpha)
			GM.draw_sprite_ext(sprite, image_index, (x_draw + (16.0 + (size * 16.0))), (y_draw + 16.0), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
			xx = (x_draw + (16.0 + (size * 16.0)))
			yy = (y_draw + 16.0)
		2.0:
			if plant == 1.0:
				GM.draw_sprite_ext(A.spr_pplant_res, G.apariencia, (x_draw + 24.0), (y_draw + (40.0 + (size * 16.0))), 1.0, 1.0, rotacion, GM.c_white, m_alpha)
			GM.draw_sprite_ext(sprite, image_index, (x_draw + 16.0), (y_draw + (16.0 + (size * 16.0))), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
			xx = (x_draw + 16.0)
			yy = (y_draw + (16.0 + (size * 16.0)))
		3.0:
			if plant == 1.0:
				GM.draw_sprite_ext(A.spr_pplant_res, G.apariencia, (x_draw - 8.0), (y_draw + 24.0), 1.0, 1.0, rotacion, GM.c_white, m_alpha)
			GM.draw_sprite_ext(sprite, image_index, (x_draw + 16.0), (y_draw + 16.0), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
			xx = (x_draw + 16.0)
			yy = (y_draw + 16.0)
	if size > 0.0:
		i = 1.0
		while i < (size + 1.0):
			match float(direct_t):
				0.0:
					GM.draw_sprite_ext(part, image_index, (x_draw + 16.0), ((y_draw + 16.0) + (i * 16.0)), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
				1.0:
					GM.draw_sprite_ext(part, image_index, ((x_draw + (16.0 + (size * 16.0))) - (i * 16.0)), (y_draw + 16.0), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
				2.0:
					GM.draw_sprite_ext(part, image_index, (x_draw + 16.0), ((y_draw + (16.0 + (size * 16.0))) - (i * 16.0)), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
				3.0:
					GM.draw_sprite_ext(part, image_index, ((x_draw + 16.0) + (i * 16.0)), (y_draw + 16.0), s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
			i += 1.0
	if drag == 0.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_pipes_move_drag, anim, xx, yy, 1.0, 1.0, rotacion, GM.c_white, 1.0)
		elif mouse_up == 1.0:
			GM.draw_sprite_ext(A.spr_tuberias_move, 0.0, xx, yy, 1.0, 1.0, rotacion, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)


# from objects/obj_tuberia_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if (GM.mouse_x > (x + 9.0) and GM.mouse_x < (x + 23.0) and GM.mouse_y > y and GM.mouse_y < (y + 14.0) and direct_t == 0.0) or (GM.mouse_x > (x + (18.0 + (size * 16.0))) and GM.mouse_x < (x + (32.0 + (size * 16.0))) and GM.mouse_y > (y + 9.0) and GM.mouse_y < (y + 23.0) and direct_t == 1.0) or (GM.mouse_x > (x + 9.0) and GM.mouse_x < (x + 23.0) and GM.mouse_y > (y + (18.0 + (size * 16.0))) and GM.mouse_y < (y + (32.0 + (size * 16.0))) and direct_t == 2.0) or (GM.mouse_x > x and GM.mouse_x < (x + 14.0) and GM.mouse_y > (y + 9.0) and GM.mouse_y < (y + 23.0) and direct_t == 3.0):
						poder_girar = 1.0
						draw_p = 1.0
						for _obj_write16 in GM.with_list(A.obj_cursor):
							_obj_write16.move_tuberia = 1.0
					else:
						GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
						xx = (x - GM.mouse_x)
						yy = (y - GM.mouse_y)
						var _with_target18 = A.obj_creation_preview
						var _other17: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(_with_target18):
							inst.xx = self.xx
							inst.yy = self.yy
						GM.other = _other17
						x_start = x
						y_start = y
						G.resource_block = 1.0
						drag = 1.0
						for _obj_write19 in GM.with_list(A.obj_cursor):
							_obj_write19.move = 1.0
						ventana = 1.0
						G.cursor = 1.0
						var _with_target21 = A.obj_cursor
						var _other20: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(_with_target21):
							inst.event_user(0)
						GM.other = _other20
						if not GM.instance_exists(A.obj_effect_touch):
							GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
						G.resource_move = object_index
						alarm[0] = 1.0
