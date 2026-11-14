extends "res://objects/obj_parent_resource.gd"

var R: float = 0.0
var poder_girar: float = 0.0


# from objects/obj_skewer_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_64x64
	R = 0.0
	rotacion = 0.0
	poder_girar = 0.0
	direct_t = 1.0
	alarm[1] = 2.0


# from objects/obj_skewer_res/Step_1.gml
func _step_begin() -> void:
	var dark: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		match G.apariencia:
			0.0:
				if dark == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			1.0:
				if dark == 1.0:
					image_index = 3.0
				else:
					image_index = 2.0
			2.0:
				image_index = 4.0
			3.0:
				image_index = 5.0
	if poder_girar == 1.0:
		if rotacion >= (R + 90.0):
			rotacion = (R + 90.0)
			R = rotacion
			poder_girar = 0.0
		else:
			rotacion += 10.0


# from objects/obj_skewer_res/Alarm_1.gml
func _alarm_1() -> void:
	R = rotacion


# from objects/obj_skewer_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scaley, s_scaley, rotacion, GM.c_white, 1.0)
	if drag == 0.0:
		GM.draw_sprite_ext(A.spr_button_change_skewer, 1.0, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_skewer_res/Mouse_4.gml
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
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(A.obj_cursor):
							inst.event_user(0)
						GM.other = _o
						if not GM.instance_exists(A.obj_effect_touch):
							GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
						G.resource_move = object_index
						alarm[0] = 1.0
