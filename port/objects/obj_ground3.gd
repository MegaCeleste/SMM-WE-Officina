extends "res://objects/obj_groundparent.gd"

var size_x: float = 0.0
var size_y: float = 0.0
var arrow_image: float = 0.0
var can_up: float = 0.0
var anim: float = 0.0
var crecer_v: float = 0.0
var crecer_h: float = 0.0
var size_limit_y: float = 0.0
var poder_girar: float = 0.0
var draw_p: float = 0.0
var variant: float = 0.0
var v = null
var h = null


# from objects/obj_ground3/Create_0.gml
func _create() -> void:
	sprite_index = Scr.scr_tiles_ground(self)
	image_speed = 0.0
	image_index = 0.0
	image_xscale = 10.0
	image_yscale = 2.0
	size_x = 10.0
	size_y = 2.0
	arrow_image = 0.0
	can_up = 0.0
	anim = 0.0
	crecer_v = 0.0
	crecer_h = 0.0
	size_limit_y = 15.0
	pos_cal = 0.0
	poder_girar = 0.0
	draw_p = 0.0
	variant = 0.0
	alarm[1] = 1.0


# from objects/obj_ground3/Step_1.gml
func _step_begin() -> void:
	return


# from objects/obj_ground3/Step_0.gml
func _step() -> void:
	sprite_index = Scr.scr_tiles_ground_start(self)
	image_yscale = size_y
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		if poder_girar == 1.0:
			anim += 0.06
		else:
			anim = 0.0
		if crecer_h == 1.0:
			_user_0()
			x += 16.0
			GM.room_width += 16.0
			can_up = 1.0
			crecer_h = 0.0
			alarm[0] = 2.0
		elif crecer_h == 2.0:
			_user_0()
			x -= 16.0
			GM.room_width -= 16.0
			can_up = 1.0
			crecer_h = 0.0
			alarm[0] = 2.0
		if crecer_v == 1.0:
			_user_0()
			size_y += 1.0
			y -= 16.0
			can_up = 1.0
			crecer_v = 0.0
			alarm[0] = 2.0
		elif crecer_v == 2.0:
			_user_0()
			size_y -= 1.0
			y += 16.0
			can_up = 1.0
			crecer_v = 0.0
			alarm[0] = 2.0
		if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and poder_girar == 1.0 and crecer_h == 0.0 and crecer_v == 0.0:
			if GM.mouse_x > (x + 16.0) and can_up == 0.0 and GM.room_width < 9216.0:
				crecer_h = 1.0
			elif GM.mouse_x < x and can_up == 0.0 and ((GM.room_width > 384.0 and G.bg_level != "castle" and GM.instance_find(A.obj_editormanager, 0).get("zoom") == 0.0) or (GM.room_width > 496.0 and G.bg_level == "castle" and GM.instance_find(A.obj_editormanager, 0).get("zoom") == 0.0) or (GM.room_width > 768.0 and G.bg_level != "castle" and GM.instance_find(A.obj_editormanager, 0).get("zoom") != 0.0) or (GM.room_width > 992.0 and G.bg_level == "castle" and GM.instance_find(A.obj_editormanager, 0).get("zoom") != 0.0)):
				crecer_h = 2.0
			if GM.mouse_y < y and size_y < (size_limit_y + 1.0) and can_up == 0.0:
				crecer_v = 1.0
			elif GM.mouse_y > (y + 16.0) and can_up == 0.0 and size_y > 1.0:
				crecer_v = 2.0
		elif GM.mouse_check_button_released(GM.mb_left) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and poder_girar == 1.0:
			poder_girar = 0.0
			draw_p = 0.0
			for inst in GM.with_list(A.obj_cursor):
				inst.set("move_tuberia", 0.0)
			pos_cal = 1.0
			alarm[2] = 5.0
			GM.audio_stop_sound(A.snd_rieles)
			GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)


# from objects/obj_ground3/Alarm_0.gml
func _alarm_0() -> void:
	can_up = 0.0


# from objects/obj_ground3/Alarm_1.gml
func _alarm_1() -> void:
	size_y = (28.0 - (y / 16.0))


# from objects/obj_ground3/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(A.snd_rieles)
	GM.audio_play_sound(A.snd_rieles, 0.0, false)


# from objects/obj_ground3/Draw_0.gml
func _gm_draw() -> void:
	var castle_index: float = 0.0
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		match G.apariencia:
			0.0:
				if G.bg_level == "snow":
					GM.draw_sprite(A.spr_SMB_meta_res, 0.0, (x - 8.0), (y - 168.0))
					GM.draw_sprite(A.spr_castles_res, 1.0, (x + 80.0), (y - 80.0))
				elif G.bg_level == "castle":
					GM.draw_sprite(A.spr_hacha_res, 0.0, x, y)
					GM.draw_sprite(A.spr_hacha2_res, 0.0, x, y)
					GM.draw_sprite(A.spr_castles_res, 2.0, (x + 80.0), (y - 80.0))
				else:
					GM.draw_sprite(A.spr_SMB_meta_res, 0.0, (x - 8.0), (y - 168.0))
					GM.draw_sprite(A.spr_castles_res, 0.0, (x + 80.0), (y - 80.0))
			1.0:
				if G.bg_level == "castle":
					GM.draw_sprite(A.spr_hacha_res, 1.0, x, y)
					GM.draw_sprite(A.spr_hacha2_res, 1.0, x, y)
					GM.draw_sprite(A.spr_castles_res, 3.0, (x + 80.0), (y - 80.0))
				else:
					GM.draw_sprite(A.spr_SMB3_bg_goal, 0.0, (GM.room_width - 310.0), 0.0)
					GM.draw_sprite(A.spr_SMB3_goal_draw, 0.0, (GM.room_width - 307.0), (y - 97.0))
					GM.draw_sprite(A.spr_SMB3_meta_res, 0.0, x, (y - 95.0))
			2.0:
				if G.bg_level == "castle":
					GM.draw_sprite(A.spr_hacha_res, 2.0, x, y)
					GM.draw_sprite(A.spr_hacha2_res, 2.0, x, y)
					GM.draw_sprite(A.spr_castles_res, 4.0, (x + 80.0), (y - 80.0))
				else:
					GM.draw_sprite(A.spr_SMW_meta_res, 0.0, x, (y - 137.0))
			3.0:
				if G.bg_level == "castle":
					GM.draw_sprite(A.spr_hacha_res, 3.0, x, y)
					GM.draw_sprite(A.spr_hacha2_res, 3.0, x, y)
					GM.draw_sprite(A.spr_castles_res, 5.0, (x + 80.0), (y - 80.0))
				else:
					if G.bg_level == "ground":
						castle_index = 0.0
					elif G.bg_level == "underground":
						castle_index = 1.0
					elif G.bg_level == "sky":
						castle_index = 2.0
					elif G.bg_level == "airship":
						castle_index = 3.0
					elif G.bg_level == "ghost":
						castle_index = 4.0
					elif G.bg_level == "underwater":
						castle_index = 5.0
					elif G.bg_level == "desert":
						castle_index = 6.0
					elif G.bg_level == "forest":
						castle_index = 7.0
					elif G.bg_level == "snow":
						castle_index = 10.0
					elif G.bg_level == "mountain":
						if G.modo_noche == 0.0:
							castle_index = 2.0
						else:
							castle_index = 8.0
					elif G.modo_noche == 1.0:
						castle_index = 9.0
					else:
						castle_index = 0.0
					GM.draw_sprite(A.spr_NSMBU_meta_res, castle_index, (x - 4.0), (y - 168.0))
					GM.draw_sprite(A.spr_NSMBU_castle, castle_index, (x + 80.0), (y - 48.0))
	v = 0.0
	while v < size_y:
		h = 0.0
		while h < size_x:
			if v == 0.0:
				if h == 0.0:
					image_index = 9.0
				else:
					image_index = 21.0
			elif h == 0.0:
				image_index = 18.0
			else:
				image_index = 47.0
			GM.draw_sprite_ext(sprite_index, image_index, (x + (h * 16.0)), (y + (v * 16.0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			h += 1.0
		v += 1.0
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_move_ground3_move, anim, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(A.spr_move_ground3, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_ground3/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and G.resource_create == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).get("dont_move") == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if (GM.instance_exists(A.obj_parent_resource) and GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0) or (not GM.instance_exists(A.obj_parent_resource)):
					if GM.mouse_x > x and GM.mouse_x < (x + 16.0) and GM.mouse_y > y and GM.mouse_y < (y + 16.0):
						poder_girar = 1.0
						draw_p = 1.0
						for inst in GM.with_list(A.obj_cursor):
							inst.set("move_tuberia", 1.0)
						if GM.instance_exists(A.obj_card_item):
							for inst in GM.with_list(A.obj_card_item):
								inst.set("active", 0.0)
							G.select_resource = A.obj_resource_empty
