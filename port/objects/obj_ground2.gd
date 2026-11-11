extends "res://objects/obj_groundparent.gd"

var size_x: float = 0.0
var size_y: float = 0.0
var arrow_image: float = 0.0
var can_up: float = 0.0
var anim: float = 0.0
var crecer_v: float = 0.0
var size_limit_y: float = 0.0
var poder_girar: float = 0.0
var draw_p: float = 0.0
var variant: float = 0.0
var y_draw = null
var v = null
var h = null


# from objects/obj_ground2/Create_0.gml
func _create() -> void:
	sprite_index = Scr.scr_tiles_ground(self)
	image_speed = 0.0
	image_index = 0.0
	image_xscale = 7.0
	image_yscale = 2.0
	size_x = 7.0
	size_y = 2.0
	arrow_image = 0.0
	can_up = 0.0
	anim = 0.0
	crecer_v = 0.0
	size_y = 2.0
	size_limit_y = 16.0
	poder_girar = 0.0
	draw_p = 0.0
	pos_cal = 0.0
	variant = 0.0
	if GM.room == A.rm_editor:
		GM.instance_create(x, (y - 48.0), A.obj_arrow_lock)
	alarm[1] = 1.0


# from objects/obj_ground2/Step_0.gml
func _step() -> void:
	sprite_index = Scr.scr_tiles_ground_start(self)
	if G.apariencia == 3.0:
		match G.bg_level:
			"snow":
				if G.modo_noche == 1.0:
					arrow_image = 11.0
				else:
					arrow_image = 10.0
			"airship":
				arrow_image = 3.0
			"sky":
				arrow_image = 2.0
			"mountain":
				if G.modo_noche == 1.0:
					arrow_image = 8.0
				else:
					arrow_image = 2.0
			"ghost":
				arrow_image = 4.0
			"underwater":
				arrow_image = 5.0
			"castle":
				if G.modo_noche == 1.0:
					arrow_image = 13.0
				else:
					arrow_image = 14.0
			"underground":
				arrow_image = 1.0
			_:
				if G.modo_noche == 1.0:
					arrow_image = 9.0
				else:
					arrow_image = 0.0
	elif G.bg_level == "snow":
		arrow_image = 1.0
	else:
		arrow_image = 0.0
	image_yscale = size_y
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		if poder_girar == 1.0:
			anim += 0.06
		else:
			anim = 0.0
		if crecer_v == 1.0:
			_user_0()
			size_y += 1.0
			y -= 16.0
			y_draw = y
			can_up = 1.0
			crecer_v = 0.0
			alarm[0] = 2.0
		elif crecer_v == 2.0:
			_user_0()
			size_y -= 1.0
			y += 16.0
			y_draw = y
			can_up = 1.0
			crecer_v = 0.0
			alarm[0] = 2.0
		if GM.mouse_check_button(GM.mb_left) and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and poder_girar == 1.0 and crecer_v == 0.0:
			if GM.mouse_y < y and can_up == 0.0 and size_y < (size_limit_y + 1.0):
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


# from objects/obj_ground2/Alarm_0.gml
func _alarm_0() -> void:
	can_up = 0.0


# from objects/obj_ground2/Alarm_1.gml
func _alarm_1() -> void:
	size_y = (28.0 - (y / 16.0))


# from objects/obj_ground2/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(A.snd_rieles)
	GM.audio_play_sound(A.snd_rieles, 0.0, false)


# from objects/obj_ground2/Draw_0.gml
func _gm_draw() -> void:
	var arrow: int = 0  # UNSURE: GML 里 apariencia 不在 0..3 时 arrow 未定义（会报错）；这里给初值 0
	v = 0.0
	while v < size_y:
		h = 0.0
		while h < size_x:
			if v == 0.0:
				if h == (size_x - 1.0):
					image_index = 10.0
				else:
					image_index = 21.0
			elif h == (size_x - 1.0):
				image_index = 24.0
			else:
				image_index = 47.0
			GM.draw_sprite_ext(sprite_index, image_index, (x + (h * 16.0)), (y + (v * 16.0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			h += 1.0
		v += 1.0
	match G.apariencia:
		0.0:
			arrow = A.spr_SMB_arrow_big
		1.0:
			arrow = A.spr_SMB3_arrow_big
		2.0:
			arrow = A.spr_arrow_big
		3.0:
			arrow = A.spr_NSMBU_arrow_start
	GM.draw_sprite(arrow, arrow_image, (x + 16.0), (y - 48.0))
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		if draw_p == 1.0:
			GM.draw_sprite_ext(A.spr_move_lianas, anim, (x + 96.0), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(A.spr_move_lianas, 0.0, (x + 96.0), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_ground2/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and G.resource_create == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).get("dont_move") == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if (GM.instance_exists(A.obj_parent_resource) and GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0) or (not GM.instance_exists(A.obj_parent_resource)):
					if GM.mouse_x > (x + 96.0) and GM.mouse_x < (x + 112.0) and GM.mouse_y > y and GM.mouse_y < (y + 16.0):
						poder_girar = 1.0
						draw_p = 1.0
						for inst in GM.with_list(A.obj_cursor):
							inst.set("move_tuberia", 1.0)
						if GM.instance_exists(A.obj_card_item):
							for inst in GM.with_list(A.obj_card_item):
								inst.set("active", 0.0)
							G.select_resource = A.obj_resource_empty
