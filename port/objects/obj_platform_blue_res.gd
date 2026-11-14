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


# from objects/obj_platform_blue_res/Create_0.gml
func _create() -> void:
	super._create()
	index = 0.0
	w_sprite = A.spr_NSMBU_wings_platforms
	anim = 0.0
	crecer_h = 0.0
	crecer_v = 0.0
	size_x = 4.0
	size_y = 3.0
	size_limit_x = 20.0
	size_limit_y = 20.0
	poder_girar = 0.0
	draw_p = 0.0
	alarm[3] = 1.0


# from objects/obj_platform_blue_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_platform_blue
		1.0:
			sprite_index = A.spr_SMB3_platform_blue
		2.0:
			sprite_index = A.spr_platform_blue
		3.0:
			sprite_index = A.spr_NSMBU_platform_blue
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
		for inst in GM.with_list(A.obj_cursor):
			inst.move_tuberia = 0.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_platform_blue_res/Alarm_3.gml
func _alarm_3() -> void:
	mask_index = A.spr_square
	image_xscale = size_x


# from objects/obj_platform_blue_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 111.0
		inst.index_object2 = 112.0
		inst.number = 3.2
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.s_contorno_1 = self.wings


# from objects/obj_platform_blue_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.platform = 0.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_platform_res)):
		inst.size_x = self.size_x
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_platform_blue_res:
				inst.obj = A.obj_platform_res
				inst.obj_draw = 111.0
	instance_destroy()


# from objects/obj_platform_blue_res/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_plataforma_blue)):
		inst.sprite = self.sprite_index
		inst.size_x = self.size_x
		inst.wings = self.wings
		inst.depth = self.depth
		inst.image_xscale = self.size_x


# from objects/obj_platform_blue_res/Other_14.gml
func _user_4() -> void:
	if wings == 0.0:
		GM.audio_play_sound(A.snd_agregar_wings, 0.0, false)
		wings = 1.0
	else:
		GM.audio_play_sound(A.snd_remove_wings, 0.0, false)
		for inst in GM.with_list(GM.instance_create(((x + (size_x * 16.0)) + 8.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0
		wings = 0.0


# from objects/obj_platform_blue_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, 1.0, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(A.spr_wings_editor, G.apariencia, (x_draw - 8.0), (y_draw - 20.0), -1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(A.spr_wings_editor, G.apariencia, ((x_draw + (size_x * 16.0)) + 8.0), (y_draw - 20.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
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


# from objects/obj_platform_blue_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and G.resource_create == 0.0 and Scr.scr_insideview(self) > 0.5 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > (x + ((16.0 * size_x) - 16.0)) and GM.mouse_x < (x + (16.0 * size_x)) and GM.mouse_y > y and GM.mouse_y < (y + 16.0):
						poder_girar = 1.0
						draw_p = 1.0
						for inst in GM.with_list(A.obj_cursor):
							inst.move_tuberia = 1.0
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
