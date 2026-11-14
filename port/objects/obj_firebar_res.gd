extends "res://objects/obj_parent_resource_block.gd"

var change: float = 0.0
var index: float = 0.0
var anim: float = 0.0
var move_bar: float = 0.0
var crecer_h: float = 0.0
var crecer_v: float = 0.0
var size_x: float = 0.0
var size_y: float = 0.0
var size_limit_x: float = 0.0
var size_limit_y: float = 0.0
var poder_girar: float = 0.0
var draw_p: float = 0.0
var h = null


# from objects/obj_firebar_res/Create_0.gml
func _create() -> void:
	super._create()
	change = 1.0
	index = 0.0
	anim = 0.0
	move_bar = 0.0
	crecer_h = 0.0
	crecer_v = 0.0
	size_x = 4.0
	size_y = 4.0
	size_limit_x = 18.0
	size_limit_y = 18.0
	poder_girar = 0.0
	draw_p = 0.0


# from objects/obj_firebar_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia
	if poder_girar == 1.0:
		anim += 0.06
	else:
		anim = 0.0
	var xExtra2 = GM.lengthdir_x(((size_x - 1.0) * 8.0), color)
	var yExtra2 = GM.lengthdir_y(((size_x - 1.0) * 8.0), color)
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and G.resource_create == 0.0 and object_index != A.obj_resource_empty and GM.instance_exists(A.obj_cursor) and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or (GM.instance_find(A.obj_editormanager, 0).expand_open == 2.0 and GM.instance_find(A.obj_cursor, 0).move_view == 1.0)) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0 and G.cursor == 0.0 and GM.mouse_check_button_pressed(GM.mb_left) and GM.point_in_rectangle(GM.mouse_x, GM.mouse_y, ((x + xExtra2) - 8.0), ((y + yExtra2) - 8.0), ((x + xExtra2) + 8.0), ((y + yExtra2) + 8.0)):
			move_bar = 1.0
			draw_p = 1.0
			for inst in GM.with_list(A.obj_cursor):
				if inst.move_view == 1.0:
					inst.move_view = 0.0
					inst.speed = 0.0
	if move_bar == 1.0:
		color = GM.point_direction(x, y, GM.mouse_x, GM.mouse_y)
	var exopen = GM.instance_find(A.obj_editormanager, 0).expand_open
	if GM.mouse_check_button_released(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and draw_p == 1.0:
		poder_girar = 0.0
		draw_p = 0.0
		for inst in GM.with_list(A.obj_cursor):
			inst.move_tuberia = 0.0
		move_bar = 0.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_firebar_res/Other_15.gml
func _user_5() -> void:
	GM.audio_stop_sound(A.snd_rieles)
	GM.audio_play_sound(A.snd_rieles, 0.0, false)


# from objects/obj_firebar_res/Draw_0.gml
func _gm_draw() -> void:
	var xExtra
	var yExtra
	var xExtra2
	var yExtra2
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	GM.draw_sprite(A.spr_firebar_base, image_index, x_draw, y_draw)
	h = 0.0
	while h < size_x:
		xExtra = GM.lengthdir_x((h * 8.0), color)
		yExtra = GM.lengthdir_y((h * 8.0), color)
		GM.draw_sprite_ext(A.spr_firebar, G.apariencia, ((x_draw + 8.0) + xExtra), ((y_draw + 8.0) + yExtra), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		h += 1.0
	if drag == 0.0:
		xExtra2 = GM.lengthdir_x(((size_x - 1.0) * 8.0), color)
		yExtra2 = GM.lengthdir_y(((size_x - 1.0) * 8.0), color)
		GM.draw_sprite_ext(A.spr_button_change_firebar, direct_t, (x + 8.0), (y + 8.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(A.spr_firebar_move, draw_p, ((x + 8.0) + xExtra2), ((y + 8.0) + yExtra2), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)


# from objects/obj_firebar_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and Scr.scr_insideview(self) > 0.5 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_layout, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_layout)):
		if G.editor_activity == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not place_meeting(x, y, A.obj_creator_jugar_editar)) and (not place_meeting(x, y, A.obj_panel_expand)):
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + 4.0) and GM.mouse_x < (x + 12.0) and GM.mouse_y > (y + 4.0) and GM.mouse_y < (y + 12.0):
						GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
						if direct_t == 0.0:
							direct_t = 1.0
						else:
							direct_t = 0.0
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
