# 第 4 批移植，已核对。
extends GMObject

var sprite = null
var index: float = 0.0
var land: float = 0.0
var blend_star = null
var flashAlpha: float = 0.0
var cp: float = 0.0
var cp_cont: float = 0.0
var color: Array = []
var powerup: float = 0.0
var type_powerup = null
var xx: float = 0.0
var yy: float = 0.0
var direct: float = 0.0
var drag: float = 0.0
var move_velocity: float = 0.0
var x_start = null
var y_start = null
var prev_x: float = 0.0
var prev_y: float = 0.0
var drop_lock: float = 0.0
var laller: float = 0.0
var x_draw = null
var y_draw = null
var ventana: float = 0.0
var clean: float = 0.0
var mouse_up: float = 0.0
var follow = null
var direct_x: float = 0.0
var direct_y: float = 0.0
var drag_draw = null
var follow_x = null
var follow_y = null


# from objects/obj_mario_editor/Create_0.gml
func _create() -> void:
	sprite = sprite_index
	index = 0.0
	image_speed = 0.0
	land = 0.0
	blend_star = GM.c_white
	flashAlpha = 1.0
	cp = 0.0
	cp_cont = 0.0
	GM.aset(color, 0, GM.make_colour_rgb(255.0, 255.0, 72.0))
	GM.aset(color, 1, GM.make_colour_rgb(254.0, 138.0, 139.0))
	GM.aset(color, 2, GM.make_colour_rgb(102.0, 245.0, 157.0))
	powerup = 0.0
	type_powerup = G.powerup_editor
	xx = 0.0
	yy = 0.0
	direct = 1.0
	drag = 0.0
	move_velocity = 0.0
	x_start = 72.0
	y_start = 152.0
	prev_x = x
	prev_y = y
	drop_lock = 0.0
	laller = depth
	x_draw = x
	y_draw = y
	ventana = 0.0
	clean = 0.0
	mouse_up = 0.0
	follow = 0.0
	direct_x = 0.0
	direct_y = 0.0


# from objects/obj_mario_editor/Step_1.gml
func _step_begin() -> void:
	var cal: float = 0.0
	if GM.instance_exists(A.obj_editormanager):
		cal = (GM.sprite_get_yoffset(sprite_index) - GM.sprite_get_bbox_top(sprite_index))
		if bbox_bottom > GM.room_height:
			y = (GM.room_height - 16.0)
			if vspeed > 0.0:
				vspeed = 0.0
		elif (y + cal) <= 0.0:
			y += cal
			if vspeed < 0.0:
				vspeed = 0.0
		if bbox_right > GM.room_width:
			x = (GM.room_width - 16.0)
			if hspeed > 0.0:
				hspeed = 0.0
		elif bbox_left <= 0.0:
			x = 0.0
			if hspeed < 0.0:
				hspeed = 0.0


# from objects/obj_mario_editor/Step_0.gml
func _step() -> void:
	var un: float = 0.0
	var move_velocity: float = 0.0  # 原版 var 局部变量，遮蔽同名实例变量
	var i_cursor = GM.instance_find(A.obj_cursor, 0)
	G.powerup = Scr.scr_powerup_editor(self, type_powerup)
	G.powerup_editor = type_powerup
	if G.star_flash == 1.0:
		if cp_cont == 0.0:
			flashAlpha -= 0.1
			if flashAlpha < 0.2:
				cp_cont = 1.0
				if cp < 2.0:
					cp += 1.0
				else:
					cp = 0.0
		else:
			flashAlpha += 0.1
			if flashAlpha > 0.9:
				cp_cont = 0.0
		blend_star = color[int(cp)]
	if drag == 1.0:
		if G.apariencia == 3.0:
			if G.bg_level == "underwater":
				un = 1.0
			else:
				un = 0.0
			sprite = Scr.scr_NSMBU_walk(self, un)
			index += 1.0
		else:
			sprite = Scr.scr_mariowalk(self)
			index += 0.25
	else:
		if G.apariencia == 3.0:
			if G.bg_level == "underwater":
				sprite = A.spr_NSMBU_mario_editor_water
			else:
				sprite = A.spr_NSMBU_mario_editor
			match G.powerup:
				0.0:
					index = 0.0
				1.0:
					index = 1.0
				2.0:
					index = 2.0
				-30.0:
					index = 3.0
				-43.0:
					index = 4.0
				-38.0:
					index = 5.0
		else:
			sprite = Scr.scr_marioidle(self)
			index = 0.0
		x_draw = x
		y_draw = y
	if G.powerup == 0.0 or G.powerup == -85.0:
		mask_index = A.spr_grid_selected_16x16
	else:
		mask_index = A.spr_grid_selected_16x32
	if collision_rectangle((bbox_left - 4.0), bbox_bottom, (bbox_right + 4.0), bbox_bottom, A.obj_cursor, false, false) != null and GM.instance_find(A.obj_erase, 0).active == 1.0:
		clean = 1.0
	else:
		clean = 0.0
	if i_cursor.move_view == 1.0:
		if GM.mouse_x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 80.0):
			hspeed = 4.0
		elif GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 80.0):
			hspeed = -4.0
		else:
			hspeed = 0.0
		if GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0):
			vspeed = -4.0
		elif GM.mouse_y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) - 48.0):
			vspeed = 4.0
		else:
			vspeed = 0.0
	if i_cursor.move_view == 0.0:
		if (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_water == 1.0) and drag == 0.0 and (not GM.instance_exists(A.obj_ventana_water)):
			if GM.keyboard_check(G.lanzar_agarrar):
				move_velocity = 8.0
			else:
				move_velocity = 0.0
			if GM.keyboard_check(G.arriba) and (not GM.keyboard_check(G.abajo)) and bbox_top > 0.0:
				vspeed = (-4.0 - move_velocity)
			elif GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)) and bbox_bottom < (GM.room_height - 1.0):
				vspeed = (4.0 + move_velocity)
			else:
				vspeed = 0.0
			if GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and bbox_left > 0.0:
				hspeed = (-4.0 - move_velocity)
			elif GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and bbox_right < (GM.room_width - 1.0):
				hspeed = (4.0 + move_velocity)
			else:
				hspeed = 0.0
		else:
			speed = 0.0
	if follow == 1.0:
		drag_draw = 0.0
		_user_2()


# from objects/obj_mario_editor/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		depth = -19.0
		x_draw = (GM.mouse_x + xx)
		y_draw = (GM.mouse_y + yy)
		x = (GM.mouse_x + xx)
		y = (GM.mouse_y + yy)
		move_snap(16.0, 16.0)
		if x != prev_x or y != prev_y:
			GM.audio_stop_sound(A.snd_move_object)
			GM.audio_play_sound(A.snd_move_object, 0.0, false)
			prev_x = x
			prev_y = y
			if GM.instance_exists(A.obj_ventana_mario):
				for inst in GM.with_list(A.obj_ventana_mario):
					inst.can_anim2 = 1.0
		if ventana > 0.0 and x == x_start and y == y_start:
			ventana += 0.5
			if ventana >= 14.0:
				_user_0()
				ventana = 0.0
		else:
			ventana = 0.0
		G.editor_lock = 1.0
		for inst in GM.with_list(A.obj_cursor):
			inst.move_view = 1.0
		alarm[0] = 1.0
	else:
		if x != x_start or y != y_start:
			GM.audio_play_sound(A.snd_mario_add, 0.0, false)
		move_snap(16.0, 16.0)
		drop_lock = 0.0
		ventana = 0.0
		depth = laller
		x_draw = x
		y_draw = y
		x_start = x
		y_start = y
		G.editor_lock = 0.0
		G.resource_block = 0.0


# from objects/obj_mario_editor/Other_10.gml
func _user_0() -> void:
	GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana_mario)


# from objects/obj_mario_editor/Other_11.gml
func _user_1() -> void:
	GM.instance_create(x, y, A.obj_invincibility)
	if (GM.instance_find(A.obj_levelmanager, 0).switchon == 0.0) and (not GM.audio_is_playing(Scr.scr_snd_starman(self))):
		GM.audio_play_sound(Scr.scr_snd_starman(self), 99.0, true)
	for inst in GM.with_list(A.obj_levelmanager):
		inst.alarm[1] = 1.0


# from objects/obj_mario_editor/Other_12.gml
func _user_2() -> void:
	var i_silbido = GM.instance_find(A.obj_silbido, 0)
	if GM.instance_exists(A.obj_silbido) and ((direct_x == 0.0) and (direct_y == 0.0)):
		if x > i_silbido.x:
			direct_x = 1.0
		else:
			direct_x = -1.0
		if y > i_silbido.y:
			direct_y = 1.0
		else:
			direct_y = -1.0
	if (direct_x != 0.0) and (direct_y != 0.0):
		if GM.instance_exists(A.obj_silbido):
			speed = 7.0
			move_towards_point(i_silbido.x, i_silbido.y, speed)
			if ((direct_x == 1.0) and (x < i_silbido.x)) or ((direct_x == -1.0) and (x > i_silbido.x)):
				hspeed = 0.0
				x = i_silbido.x
			if ((direct_y == 1.0) and (y < i_silbido.y)) or ((direct_y == -1.0) and (y > i_silbido.y)):
				vspeed = 0.0
				y = i_silbido.y
			if (hspeed == 0.0) and (vspeed == 0.0):
				if follow == 1.0:
					speed = 0.0
					x_start = follow_x
					y_start = follow_y
					follow = 0.0
					drag_draw = 1.0
					if GM.instance_exists(A.obj_silbido):
						for inst in GM.with_list(A.obj_silbido):
							inst.instance_destroy()
					direct_x = 0.0
					direct_y = 0.0


# from objects/obj_mario_editor/Draw_0.gml
func _gm_draw() -> void:
	if drag == 1.0 or (mouse_up == 1.0 and G.cursor == 0.0):
		GM.draw_sprite_ext(mask_index, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if G.powerup == 3.0:
		GM.draw_sprite_ext(A.spr_cap_stay_start, 0.0, ((x_draw + 8.0) + GM.gm_round(hspeed)), ((y_draw - 15.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, GM.c_white, image_alpha)
	if G.apariencia == 3.0 and drag == 0.0:
		if direct == 1.0:
			GM.draw_sprite_ext(sprite, index, (x_draw + GM.gm_round(hspeed)), ((y_draw + 1.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite, index, ((x_draw + 16.0) + GM.gm_round(hspeed)), ((y_draw + 1.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite, index, ((x_draw + 8.0) + GM.gm_round(hspeed)), ((y_draw - 15.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, GM.c_white, image_alpha)
	if G.star_flash == 1.0 and G.effect_star == 1.0:
		GM.shader_set(A.sha_blendreplace)
		if G.apariencia == 3.0 and drag == 0.0:
			if direct == 1.0:
				GM.draw_sprite_ext(sprite, index, (x_draw + GM.gm_round(hspeed)), ((y_draw + 1.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, blend_star, flashAlpha)
			else:
				GM.draw_sprite_ext(sprite, index, ((x_draw + 16.0) + GM.gm_round(hspeed)), ((y_draw + 1.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, blend_star, flashAlpha)
		else:
			GM.draw_sprite_ext(sprite, index, ((x_draw + 8.0) + GM.gm_round(hspeed)), ((y_draw - 15.0) + GM.gm_round(vspeed)), direct, 1.0, 0.0, blend_star, flashAlpha)
		GM.shader_reset()


# from objects/obj_mario_editor/Mouse_4.gml
func _mouse_4() -> void:
	var i_levelmanager = GM.instance_find(A.obj_levelmanager, 0)
	var i_editormanager = GM.instance_find(A.obj_editormanager, 0)
	var i_creation_preview = GM.instance_find(A.obj_creation_preview, 0)
	var i_parent_resource = GM.instance_find(A.obj_parent_resource, 0)
	if i_levelmanager.editor == 1.0 and G.resource_create == 0.0 and i_editormanager.zoom == 0.0 and (follow == 0.0) and (not GM.instance_exists(A.obj_edit_menu)) and (i_editormanager.expand_open == 0.0 or i_levelmanager.editor_sonidos == 1.0) and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_layout, true, true) == null) and (not place_meeting(i_creation_preview.x, i_creation_preview.y, A.obj_parent_layout)):
		if (not place_meeting(x, y, A.obj_creator_jugar_editar)) and (not place_meeting(x, y, A.obj_panel_expand)):
			if G.cursor == 0.0:
				if (GM.instance_exists(A.obj_parent_resource) and i_parent_resource.alarm[0] == -1.0) or (not GM.instance_exists(A.obj_parent_resource)):
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
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_cursor):
						inst.event_user(0)
					GM.other = _o
					if not GM.instance_exists(A.obj_effect_touch):
						GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
					G.resource_move = object_index
					alarm[0] = 1.0


# from objects/obj_mario_editor/Mouse_7.gml
func _mouse_7() -> void:
	drag = 0.0
	for inst in GM.with_list(A.obj_cursor):
		inst.move = 0.0
	G.resource_block = 0.0
	if G.cursor != 2.0:
		G.cursor = 0.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_cursor):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_mario_editor/Mouse_10.gml
func _mouse_10() -> void:
	if drag == 0.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		mouse_up = 1.0


# from objects/obj_mario_editor/Mouse_11.gml
func _mouse_11() -> void:
	mouse_up = 0.0
