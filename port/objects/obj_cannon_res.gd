extends "res://objects/obj_parent_resource.gd"

var direct: float = 0.0
var u: float = 0.0
var d: float = 0.0
var l: float = 0.0
var r: float = 0.0
var u2: float = 0.0
var d2: float = 0.0
var l2: float = 0.0
var r2: float = 0.0
var ready_v: float = 0.0  # ready 是 Godot 保留名称


# from objects/obj_cannon_res/Create_0.gml
func _create() -> void:
	super._create()
	direct = 0.0
	u = 0.0
	d = 0.0
	l = 0.0
	r = 0.0
	u2 = 0.0
	d2 = 0.0
	l2 = 0.0
	r2 = 0.0
	ready_v = 1.0
	_user_15()


# from objects/obj_cannon_res/Step_2.gml
func _step_end() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		match G.apariencia:
			0.0:
				if dark == 1.0:
					sprite_index = A.spr_SMB_cannon_night
				else:
					sprite_index = A.spr_SMB_cannon
			1.0:
				if dark == 1.0:
					sprite_index = A.spr_SMB3_cannon_night
				else:
					sprite_index = A.spr_SMB3_cannon
			2.0:
				sprite_index = A.spr_cannon
			3.0:
				sprite_index = A.spr_NSMBU_cannon
		image_index = direct
		if drag == 1.0 or (mouse_up == 0.0 and ready_v == 1.0):
			_user_15()


# from objects/obj_cannon_res/Alarm_1.gml
func _alarm_1() -> void:
	ready_v = 1.0


# from objects/obj_cannon_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			inst.index_object1 = 156.0
		else:
			inst.index_object1 = 155.0
		inst.index_object2 = 157.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.number = 2.1


# from objects/obj_cannon_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.cannon = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_cannon_red_res)):
		inst.direct = self.direct
		inst.d = self.d
		inst.u = self.u
		inst.l = self.l
		inst.r = self.r
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_cannon_res:
				inst.obj = A.obj_cannon_red_res
				inst.obj_draw = 157.0
	instance_destroy()


# from objects/obj_cannon_res/Other_24.gml
func _user_14() -> void:
	if place_meeting(x, (y + 16.0), A.obj_ground) or place_meeting(x, (y + 16.0), A.obj_block_res) or place_meeting(x, (y + 16.0), A.obj_qblock_res) or place_meeting(x, (y + 16.0), A.obj_rock_res) or place_meeting(x, (y + 16.0), A.obj_ice_res) or place_meeting(x, (y + 16.0), A.obj_onoffplatform_res) or place_meeting(x, (y + 16.0), A.obj_onoffblock_res) or place_meeting(x, (y + 16.0), A.obj_pinchos_res):
		d2 = 1.0
	else:
		d2 = 0.0
	if place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_block_res) or place_meeting(x, (y - 16.0), A.obj_qblock_res) or place_meeting(x, (y - 16.0), A.obj_rock_res) or place_meeting(x, (y - 16.0), A.obj_ice_res) or place_meeting(x, (y - 16.0), A.obj_onoffblock_res) or place_meeting(x, (y - 16.0), A.obj_onoffplatform_res) or place_meeting(x, (y - 16.0), A.obj_pinchos_res):
		u2 = 1.0
	else:
		u2 = 0.0
	if place_meeting((x - 16.0), y, A.obj_ground) or place_meeting((x - 16.0), y, A.obj_block_res) or place_meeting((x - 16.0), y, A.obj_qblock_res) or place_meeting((x - 16.0), y, A.obj_rock_res) or place_meeting((x - 16.0), y, A.obj_ice_res) or place_meeting((x - 16.0), y, A.obj_onoffblock_res) or place_meeting((x - 16.0), y, A.obj_onoffplatform_res) or place_meeting((x - 16.0), y, A.obj_pinchos_res):
		l2 = 1.0
	else:
		l2 = 0.0
	if place_meeting((x + 16.0), y, A.obj_ground) or place_meeting((x + 16.0), y, A.obj_block_res) or place_meeting((x + 16.0), y, A.obj_qblock_res) or place_meeting((x + 16.0), y, A.obj_rock_res) or place_meeting((x + 16.0), y, A.obj_ice_res) or place_meeting((x + 16.0), y, A.obj_onoffblock_res) or place_meeting((x + 16.0), y, A.obj_onoffplatform_res) or place_meeting((x + 16.0), y, A.obj_pinchos_res):
		r2 = 1.0
	else:
		r2 = 0.0


# from objects/obj_cannon_res/Other_25.gml
func _user_15() -> void:
	if place_meeting(x, (y + 16.0), A.obj_ground) or place_meeting(x, (y + 16.0), A.obj_parent_resource_block) or place_meeting(x, (y + 16.0), A.obj_bullebill_base_res) or place_meeting(x, (y + 16.0), A.obj_muncher_res) or place_meeting(x, (y + 16.0), A.obj_nube_res) or place_meeting(x, (y + 16.0), A.obj_donut_res) or place_meeting(x, (y + 16.0), A.obj_thwomp_res) or place_meeting(x, (y + 16.0), A.obj_icicle_res) or place_meeting(x, (y + 16.0), A.obj_icicle2_res) or place_meeting(x, (y + 16.0), A.obj_mini_icicle_res) or place_meeting(x, (y + 16.0), A.obj_mini_icicle2_res) or place_meeting(x, (y + 16.0), A.obj_spring_land_res):
		u = 0.0
		d = 1.0
		l = 0.0
		r = 0.0
		if direct > 4.0:
			direct = 2.0
	elif place_meeting(x, (y - 16.0), A.obj_ground) or place_meeting(x, (y - 16.0), A.obj_parent_resource_block):
		u = 1.0
		d = 0.0
		l = 0.0
		r = 0.0
		if direct != 0.0 and direct != 4.0 and direct != 5.0 and direct != 6.0 and direct != 7.0:
			direct = 6.0
	elif place_meeting((x - 16.0), y, A.obj_ground) or place_meeting((x - 16.0), y, A.obj_parent_resource_block):
		u = 0.0
		d = 0.0
		l = 1.0
		r = 0.0
		if direct != 0.0 and direct != 1.0 and direct != 2.0 and direct != 6.0 and direct != 7.0:
			direct = 0.0
	elif place_meeting((x + 16.0), y, A.obj_ground) or place_meeting((x + 16.0), y, A.obj_parent_resource_block):
		u = 0.0
		d = 0.0
		l = 0.0
		r = 1.0
		if direct != 2.0 and direct != 3.0 and direct != 4.0 and direct != 5.0 and direct != 6.0:
			direct = 4.0
	else:
		u = 0.0
		d = 1.0
		l = 0.0
		r = 0.0
		if direct > 4.0:
			direct = 2.0


# from objects/obj_cannon_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, 1.0)
	if d == 1.0:
		GM.draw_sprite_ext(sprite_index, 8.0, x_draw, y_draw, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	elif u == 1.0:
		GM.draw_sprite_ext(sprite_index, 9.0, x_draw, y_draw, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	elif r == 1.0:
		GM.draw_sprite_ext(sprite_index, 10.0, x_draw, y_draw, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	elif l == 1.0:
		GM.draw_sprite_ext(sprite_index, 11.0, x_draw, y_draw, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, 12.0, x_draw, y_draw, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	if drag == 0.0:
		GM.draw_sprite_ext(A.spr_button_change_32x32, 0.0, (x + 8.0), (y + 8.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_cannon_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and Scr.scr_insideview(self) > 0.5 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_layout, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_layout)):
		if G.editor_activity == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not place_meeting(x, y, A.obj_creator_jugar_editar)) and (not place_meeting(x, y, A.obj_panel_expand)):
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + 4.0) and GM.mouse_x < (x + 12.0) and GM.mouse_y > (y + 4.0) and GM.mouse_y < (y + 12.0):
						GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
						if d == 1.0:
							if direct == 4.0:
								direct = 0.0
							else:
								direct += 1.0
						elif u == 1.0:
							if direct == 0.0:
								direct = 4.0
							elif direct == 7.0:
								direct = 0.0
							else:
								direct += 1.0
						elif r == 1.0:
							if direct == 6.0:
								direct = 2.0
							else:
								direct += 1.0
						elif l == 1.0:
							if direct == 7.0:
								direct = 0.0
							elif direct == 2.0:
								direct = 6.0
							else:
								direct += 1.0
						expand = 1.0
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
