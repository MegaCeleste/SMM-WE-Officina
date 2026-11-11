extends "res://objects/obj_parent_save.gd"

var expand: float = 0.0
var expand2: float = 0.0
var expand3: float = 0.0
var xx: float = 0.0
var yy: float = 0.0
var item_inside: float = 0.0
var mydepth: float = 0.0
var drag: float = 0.0
var drop_lock: float = 0.0
var unlocked: float = 0.0
var laller: float = 0.0
var x_start: float = 0.0
var y_start: float = 0.0
var x_draw = null
var y_draw = null
var posx: float = 0.0
var posy: float = 0.0
var prev_x: float = 0.0
var prev_y: float = 0.0
var play_sound: float = 0.0
var exepcion: float = 0.0
var grid_selected: int = 0  ## sprite 编号
var mouse_up: float = 0.0
var sprout = null
var inup: float = 0.0
var rotacion: float = 0.0
var s_scalex: float = 0.0
var s_scaley: float = 0.0
var ventana: float = 0.0
var wings: float = 0.0
var w_sprite: int = 0  ## sprite 编号
var wings_x: float = 0.0
var wings_y = null
var paracaidas: float = 0.0
var p_sprite: int = 0  ## sprite 编号
var para_x: float = 0.0
var para_y: float = 0.0
var size: float = 0.0
var color: float = 0.0
var direct_t: float = 0.0
var transform: float = 0.0
var progresivo: float = 0.0
var modo_water: float = 0.0
var key: float = 0.0
var pos_cal: float = 0.0
var m_alpha: float = 0.0
var warp = null  # 仅子类赋值(warp)


# from objects/obj_parent_resource/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	expand = 0.0
	expand2 = 0.0
	expand3 = 0.0
	xx = 0.0
	yy = 0.0
	item_inside = 0.0
	mydepth = -60.0
	drag = 0.0
	drop_lock = 0.0
	if object_index == A.obj_oneway_res or object_index == A.obj_nube_res or object_index == A.obj_grinder or object_index == A.obj_vine_res or object_index == A.obj_bumper_res or object_index == A.obj_semisolid_platform1 or object_index == A.obj_mushroom_platform_res or object_index == A.obj_platform_res or object_index == A.obj_platform_blue_res or object_index == A.obj_puente_res:
		unlocked = 1.0
	else:
		unlocked = 0.0
	laller = depth
	x_start = 0.0
	y_start = 0.0
	x_draw = x
	y_draw = y
	posx = 0.0
	posy = 0.0
	prev_x = (floorf((x / 16.0)) * 16.0)
	prev_y = (floorf((y / 16.0)) * 16.0)
	play_sound = 0.0
	exception = 0.0
	exepcion = 0.0
	grid_selected = A.spr_grid_selected_16x16
	mouse_up = 0.0
	sprout = 0.0
	inup = 0.0
	rotacion = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	ventana = 0.0
	wings = 0.0
	w_sprite = A.spr_wings_editor
	wings_x = 0.0
	wings_y = 0.0
	paracaidas = 0.0
	p_sprite = A.spr_paracaidas_editor
	para_x = 0.0
	para_y = 16.0
	size = 0.0
	color = 0.0
	direct_t = 0.0
	transform = 0.0
	progresivo = 0.0
	inup = 0.0
	modo_water = 0.0
	key = 0.0
	pos_cal = 1.0
	if object_index == A.obj_ground:
		alarm[6] = 5.0
	else:
		alarm[5] = 5.0
	m_alpha = 1.0


# from objects/obj_parent_resource/Step_1.gml
func _step_begin() -> void:
	if object_index != A.obj_mushroom_platform_res and object_index != A.obj_semisolid_platform1:
		if expand == 1.0:
			s_scalex += 0.2
			s_scaley += 0.2
			if s_scalex > 1.4:
				expand = 2.0
		elif expand == 2.0:
			s_scalex -= 0.2
			s_scaley -= 0.2
			if s_scalex < 1.0:
				expand = 0.0
				s_scalex = 1.0
				s_scaley = 1.0
		if expand2 == 1.0:
			s_scalex += 0.1
			s_scaley += 0.1
			if s_scalex > 1.1:
				s_scalex = 1.1
				s_scaley = 1.1
		elif expand2 == 2.0:
			s_scalex -= 0.1
			s_scaley -= 0.1
			if s_scalex < 1.0:
				expand2 = 0.0
				s_scalex = 1.0
				s_scaley = 1.0
		if expand3 == 1.0:
			s_scalex -= 0.2
			s_scaley -= 0.2
			if s_scalex < 0.8:
				expand3 = 2.0
		elif expand3 == 2.0:
			s_scalex += 0.2
			s_scaley += 0.2
			if s_scalex >= 1.0:
				expand3 = 0.0
				s_scalex = 1.0
				s_scaley = 1.0
	if drag == 1.0 and (x >= GM.room_width or x < 0.0 or y >= GM.room_height or y < 0.0):
		m_alpha = 0.5
	else:
		m_alpha = 1.0
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and drag == 0.0 and (x >= GM.room_width or x < 0.0 or y >= GM.room_height or y < 0.0):
		instance_destroy()


# from objects/obj_parent_resource/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		if (object_index == A.obj_egg_res or object_index == A.obj_egg_red_res) and G.apariencia < 2.0:
			image_speed = 0.0
			image_index = 0.0
		var _prev: GMObject = GM.instance_find(A.obj_creation_preview, 0)
		if (place_meeting(_prev.x, _prev.y, A.obj_parent_resource) and (not place_meeting(_prev.x, _prev.y, self)) and unlocked == 0.0) or place_meeting(x, y, A.obj_arrow_lock):
			drop_lock = 1.0
		else:
			drop_lock = 0.0
		depth = -19.0
		x_draw = (GM.mouse_x + xx)
		y_draw = (GM.mouse_y + yy)
		x = (GM.mouse_x + xx)
		y = (GM.mouse_y + yy)
		move_snap(16.0, 16.0)
		if play_sound == 0.0 and (x != x_start or y != y_start):
			GM.audio_play_sound(A.snd_drag, 0.0, false)
			play_sound = 1.0
		if GM.instance_find(A.obj_persistent, 0).modo_android == 1.0 and GM.instance_find(A.obj_cursor, 0).get("move_view") == 0.0:
			for inst in GM.with_list(A.obj_cursor):
				inst.set("move_view", 1.0)
			for inst in GM.with_list(A.obj_editormanager):
				inst.set("expand_open", 2.0)
		if x != prev_x or y != prev_y:
			GM.audio_stop_sound(A.snd_move_object)
			GM.audio_play_sound(A.snd_move_object, 0.0, false)
			prev_x = x
			prev_y = y
			if GM.instance_exists(A.obj_ventana):
				for inst in GM.with_list(A.obj_ventana):
					inst.set("can_anim2", 1.0)
		if ventana > 0.0 and x == x_start and y == y_start:
			ventana += 0.5
			if ventana >= 14.0:
				event_user(0)
				ventana = 0.0
		else:
			ventana = 0.0
		G.editor_lock = 1.0
		alarm[0] = 1.0
	else:
		if (object_index == A.obj_egg_res or object_index == A.obj_egg_red_res) and G.apariencia < 2.0:
			image_speed = 0.25
		else:
			image_speed = 0.0
		if drop_lock == 1.0:
			GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
			x = x_start
			y = y_start
		elif x != x_start or y != y_start:
			GM.audio_play_sound(A.snd_mario_add, 0.0, false)
		move_snap(16.0, 16.0)
		drop_lock = 0.0
		ventana = 0.0
		if GM.instance_find(A.obj_persistent, 0).modo_android == 1.0:
			for inst in GM.with_list(A.obj_cursor):
				inst.set("move_view", 0.0)
			for inst in GM.with_list(A.obj_editormanager):
				inst.speed = 0.0
			if GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0:
				for inst in GM.with_list(A.obj_editormanager):
					inst.set("expand_open", 0.0)
		depth = laller
		play_sound = 0.0
		x_draw = x
		y_draw = y
		if object_index != A.obj_tuberia_res:
			expand3 = 1.0
		x_start = x
		y_start = y
		G.editor_lock = 0.0
		G.resource_block = 0.0
		if x >= GM.room_width or x < 0.0 or y >= GM.room_height or y < 0.0:
			instance_destroy()
		if object_index == A.obj_tuberia_res and warp > 0.0:
			event_user(5)


# from objects/obj_parent_resource/Alarm_5.gml
func _alarm_5() -> void:
	pos_cal = 0.0


# from objects/obj_parent_resource/Collision_obj_key_res.gml
func _collision_obj_key_res(other: GMObject) -> void:
	if drag == 0.0 and other.get("drag") == 0.0:
		if object_index == A.obj_bowser_res or object_index == A.obj_bowserjr_res or object_index == A.obj_koopa_res or object_index == A.obj_koopa_red_res or object_index == A.obj_koopa_b_res or object_index == A.obj_koopa_red_b_res or object_index == A.obj_goomba_res or object_index == A.obj_goomba_b_res or object_index == A.obj_goombrat_res or object_index == A.obj_boomboom_res or object_index == A.obj_boomboom_b_res:
			GM.audio_play_sound(A.snd_SMB3_getkey, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.image_speed = 0.21
				if G.apariencia < 2.0:
					inst.sprite_index = A.spr_SMB3_sparkles_keys
				else:
					inst.sprite_index = A.spr_sparkles_keys
			key = 1.0
			for inst in GM.with_list(other):
				inst.instance_destroy()
		elif object_index == A.obj_qblock_res or object_index == A.obj_block_hidden_res or object_index == A.obj_block_res or object_index == A.obj_noteblock_res:
			GM.audio_play_sound(A.snd_colocar_item_bloque, 0.0, false)
			sprout = Scr.scr_sprite_get_constant_res(self, other.sprite_index)
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_parent_resource/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if pos_cal == 1.0 and other != self and GM.object_get_parent(other.object_index) != A.obj_parent_sounds:
		# with 块内调用了 event_user：GM.other 设为外层 self（§3.3 第 17 条）
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index == A.obj_slopes:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res and inst.object_index != A.obj_door_res and inst.object_index != A.obj_door_exit_res and inst.object_index != A.obj_door_switch_res and inst.object_index != A.obj_door_switch_exit_res and inst.object_index != A.obj_door_lock_res and inst.object_index != A.obj_door_lock_exit_res and inst.object_index != A.obj_oneway_res and inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_nube_res:
				inst.instance_destroy()
		GM.other = _o


# from objects/obj_parent_resource/Other_0.gml
func _outside_room() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and drag == 0.0:
		instance_destroy()


# from objects/obj_parent_resource/Other_12.gml
func _user_2() -> void:
	if G.cursor == 2.0 and not place_meeting(x, y, A.obj_erase):
		GM.audio_stop_sound(A.snd_erase_clean)
		GM.audio_play_sound(A.snd_erase_clean, 0.0, false)
	if not place_meeting(x, y, A.obj_erase):
		instance_destroy()


# from objects/obj_parent_resource/Other_14.gml
func _user_4() -> void:
	if wings == 0.0:
		GM.audio_play_sound(A.snd_agregar_wings, 0.0, false)
		wings = 1.0
	else:
		GM.audio_play_sound(A.snd_remove_wings, 0.0, false)
		for inst in GM.with_list(GM.instance_create((x + wings_x), ((y - wings_y) + 16.0), A.obj_wings_dead)):
			inst.set("direct", -1.0)
		wings = 0.0


# from objects/obj_parent_resource/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0 or Scr.outside_view(self) > 0.5:
		return
	if drag == 1.0:
		GM.draw_sprite_ext(grid_selected, drop_lock, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	elif mouse_up == 1.0 and G.cursor == 0.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(p_sprite, G.apariencia, (x_draw + para_x), (y_draw - para_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
	if wings == 1.0:
		GM.draw_sprite_ext(w_sprite, G.apariencia, (x_draw + wings_x), (y_draw - wings_y), s_scalex, s_scaley, 1.0, GM.c_white, m_alpha)
	if mouse_up == 1.0 and drag == 0.0 and G.cursor == 2.0:
		GM.draw_sprite_ext(grid_selected, 0.0, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)


# from objects/obj_parent_resource/Mouse_0.gml
func _mouse_0() -> void:
	if G.resource_create == 0.0 and Scr.scr_insideview(self) > 0.5 and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).get("zoom") == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 2.0:
				_user_2()


# from objects/obj_parent_resource/Mouse_1.gml
func _mouse_1() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.os_type != GM.os_android and Scr.scr_insideview(self) > 0.5 and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).get("zoom") == 0.0:
		if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
			if G.cursor == 2.0:
				_user_2()


# from objects/obj_parent_resource/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and Scr.scr_insideview(self) > 0.5 and G.resource_create == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).get("zoom") == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).get("dont_move") == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
					xx = (x - GM.mouse_x)
					yy = (y - GM.mouse_y)
					for inst in GM.with_list(A.obj_creation_preview):
						inst.set("xx", xx)
						inst.set("yy", yy)
					x_start = x
					y_start = y
					G.resource_block = 1.0
					drag = 1.0
					for inst in GM.with_list(A.obj_cursor):
						inst.set("move", 1.0)
					ventana = 1.0
					G.cursor = 1.0
					# with (obj_cursor) event_user(0)：GM.other 设为外层 self（§3.3 第 17 条）
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_cursor):
						inst.event_user(0)
					GM.other = _o
					if not GM.instance_exists(A.obj_effect_touch):
						GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
					G.resource_move = object_index
					alarm[0] = 1.0


# from objects/obj_parent_resource/Mouse_7.gml
func _mouse_7() -> void:
	drag = 0.0
	for inst in GM.with_list(A.obj_cursor):
		inst.set("move", 0.0)
	G.resource_block = 0.0
	if G.cursor != 2.0:
		G.cursor = 0.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_cursor):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_parent_resource/Mouse_10.gml
func _mouse_10() -> void:
	if drag == 0.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0:
		mouse_up = 1.0


# from objects/obj_parent_resource/Mouse_11.gml
func _mouse_11() -> void:
	mouse_up = 0.0
