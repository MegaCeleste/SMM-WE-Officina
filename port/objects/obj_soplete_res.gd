extends "res://objects/obj_parent_resource.gd"

var sprite: float = 0.0
var index: float = 0.0
var R: float = 0.0


# from objects/obj_soplete_res/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_soplete_res
	index = 0.0
	direct_t = 0.0
	rotacion = 0.0
	R = 0.0
	sprout = G.soplete


# from objects/obj_soplete_res/Step_2.gml
func _step_end() -> void:
	match sprout:
		0.0:
			sprite = A.spr_soplete_res
		1.0:
			sprite = A.spr_soplete_invert_res
	index = G.apariencia


# from objects/obj_soplete_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 166.0
		inst.index_object2 = 43.0
		if self.sprout == 0.0:
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
		else:
			inst.selected_1 = 0.0
			inst.selected_2 = 1.0
		inst.number = 2.1


# from objects/obj_soplete_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	if sprout == 0.0:
		sprout = 1.0
	else:
		sprout = 0.0
	G.soplete = sprout
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_soplete_res:
				if self.sprout == 1.0:
					inst.obj_draw = 43.0
				else:
					inst.obj_draw = 166.0


# from objects/obj_soplete_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite, index, (x_draw + 8.0), (y_draw + 8.0), 1.0, 1.0, rotacion, GM.c_white, 1.0)
	if drag == 0.0:
		GM.draw_sprite_ext(A.spr_button_change_32x32, 0.0, (x + 8.0), (y + 8.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_soplete_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_layout, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_layout)):
		if G.editor_activity == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not place_meeting(x, y, A.obj_creator_jugar_editar)) and (not place_meeting(x, y, A.obj_panel_expand)):
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + 4.0) and GM.mouse_x < (x + 12.0) and GM.mouse_y > (y + 4.0) and GM.mouse_y < (y + 12.0):
						GM.audio_play_sound(A.snd_change_arrow, 0.0, false)
						if direct_t == 3.0:
							direct_t = 0.0
						else:
							direct_t += 1.0
						match direct_t:
							0.0:
								rotacion = 0.0
							1.0:
								rotacion = -90.0
							2.0:
								rotacion = 180.0
							3.0:
								rotacion = 90.0
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
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(A.obj_cursor):
							inst.event_user(0)
						GM.other = _o
						if not GM.instance_exists(A.obj_effect_touch):
							GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
						G.resource_move = object_index
						alarm[0] = 1.0
