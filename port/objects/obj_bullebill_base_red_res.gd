extends "res://objects/obj_parent_resource.gd"

var index: float = 0.0
var anim: float = 0.0
var crecer_v: float = 0.0
var crecer_v2: float = 0.0
var size_x: float = 0.0
var size_y: float = 0.0
var size_limit_x: float = 0.0
var size_limit_y: float = 0.0
var poder_girar: float = 0.0
var draw_p: float = 0.0
var v = null


# from objects/obj_bullebill_base_red_res/Create_0.gml
func _create() -> void:
	super._create()
	index = 0.0
	anim = 0.0
	crecer_v = 0.0
	crecer_v2 = 0.0
	size_x = 2.0
	size_y = 2.0
	size_limit_x = 13.0
	size_limit_y = 13.0
	poder_girar = 0.0
	draw_p = 0.0
	sprout = 0.0
	color = 0.0
	alarm[3] = 1.0
	pos_cal = 1.0
	alarm[5] = 15.0


# from objects/obj_bullebill_base_red_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bulletbill_base_red
		1.0:
			sprite_index = A.spr_SMB3_bullebill_base_red
		2.0:
			sprite_index = A.spr_bullebill_base_red
		3.0:
			sprite_index = A.spr_NSMBU_bullebill_base_red
	if poder_girar == 1.0:
		anim += 0.06
	else:
		anim = 0.0
	if crecer_v == 1.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_y += 1.0
		y -= 16.0
		y_draw = y
		image_yscale = size_y
		mask_index = A.spr_square
		crecer_v = 0.0
	elif crecer_v == 2.0:
		GM.audio_stop_sound(A.snd_rieles)
		GM.audio_play_sound(A.snd_rieles, 0.0, false)
		size_y -= 1.0
		y += 16.0
		y_draw = y
		image_yscale = size_y
		mask_index = A.spr_square
		crecer_v = 0.0
	if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and poder_girar == 1.0 and crecer_v == 0.0:
		if GM.mouse_y > (y - 16.0) and GM.mouse_y < y and size_y < (size_limit_y + 1.0):
			crecer_v = 1.0
		elif GM.mouse_y < (y + 32.0) and GM.mouse_y > (y + 16.0) and size_y > 2.0:
			crecer_v = 2.0
	elif GM.mouse_check_button_released(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and draw_p == 1.0:
		poder_girar = 0.0
		draw_p = 0.0
		for inst in GM.with_list(A.obj_cursor):
			inst.move_tuberia = 0.0
		pos_cal = 1.0
		alarm[5] = 15.0
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_bullebill_base_red_res/Alarm_3.gml
func _alarm_3() -> void:
	image_yscale = size_y


# from objects/obj_bullebill_base_red_res/Alarm_5.gml
func _alarm_5() -> void:
	pos_cal = 0.0


# from objects/obj_bullebill_base_red_res/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	var other_resource = other
	if pos_cal == 1.0 and other != self:
		var _previous_other: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res:
				inst.instance_destroy()
		GM.other = _previous_other
	elif drag == 0.0 and other_resource.drag == 0.0:
		if other.object_index == A.obj_mushroom_res or other.object_index == A.obj_fireflower_res or other.object_index == A.obj_superflower_res or other.object_index == A.obj_hen_mushroom_res or other.object_index == A.obj_cap_res or other.object_index == A.obj_1up_res or other.object_index == A.obj_star_res or other.object_index == A.obj_egg_res or other.object_index == A.obj_egg_red_res or other.object_index == A.obj_buzzy_shell_res or other.object_index == A.obj_spiny_shell_res or other.object_index == A.obj_coin_res or other.object_index == A.obj_spring_res or other.object_index == A.obj_pswitch_res or other.object_index == A.obj_pow_res or other.object_index == A.obj_buzzy_shell_res or other.object_index == A.obj_spiny_shell_res or other.object_index == A.obj_koopa_res or other.object_index == A.obj_koopa_red_res or other.object_index == A.obj_buzzybeetle_res or other.object_index == A.obj_spiny_res or other.object_index == A.obj_cheepcheep_res or other.object_index == A.obj_cheepcheep2_res or other.object_index == A.obj_goomba_res or other.object_index == A.obj_goombrat_res or other.object_index == A.obj_bobomb_res or other.object_index == A.obj_bobomb_ready_res or other.object_index == A.obj_hammerbro_res or other.object_index == A.obj_monty_res or other.object_index == A.obj_pplant_res or other.object_index == A.obj_plant_fire_res or other.object_index == A.obj_drybones_res or other.object_index == A.obj_sledgebro or other.object_index == A.obj_frogsuit_res or other.object_index == A.obj_koopa_b_res or other.object_index == A.obj_koopa_red_b_res:
			GM.audio_play_sound(A.snd_colocar_item_bloque, 0.0, false)
			color = Scr.scr_sprite_get_constant_res(self, other.sprite_index)
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_bullebill_base_red_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			inst.index_object1 = 6.0
		else:
			inst.index_object1 = 5.0
		inst.index_object2 = 7.0
		inst.selected_1 = 0.0
		inst.selected_2 = 1.0
		inst.number = 2.1


# from objects/obj_bullebill_base_red_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.bulletbill_base = 0.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_bullebill_base_res)):
		inst.sprout = self.sprout
		inst.size_y = self.size_y
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_bullebill_base_red_res:
				inst.obj = A.obj_bullebill_base_res
				if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
					inst.obj_draw = 6.0
				else:
					inst.obj_draw = 5.0
	instance_destroy()


# from objects/obj_bullebill_base_red_res/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_bullebill_base_red)):
		inst.sprite = self.sprite_index
		inst.size_y = self.size_y
		inst.image_yscale = self.size_y
		inst.sprout = self.color


# from objects/obj_bullebill_base_red_res/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	v = 0.0
	while v < size_y:
		if v == 0.0:
			index = 0.0
		elif v == 1.0:
			index = 1.0
		else:
			index = 2.0
		GM.draw_sprite(sprite_index, index, x_draw, (y_draw + (v * 16.0)))
		v += 1.0
	if drag == 0.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_move_lianas, anim, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
		elif mouse_up == 1.0:
			GM.draw_sprite_ext(A.spr_move_lianas, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 1.0)
	if color != 0.0:
		GM.draw_sprite(A.spr_icon_hidden, 0.0, x_draw, (y_draw + 16.0))


# from objects/obj_bullebill_base_red_res/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and Scr.scr_insideview(self) > 0.5 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					if GM.mouse_x > x and GM.mouse_x < (x + 16.0) and GM.mouse_y > y and GM.mouse_y < (y + 16.0):
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
