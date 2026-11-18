extends GMObject

var cursor: float = 0.0
var msx: float = 0.0
var msy: float = 0.0
var position_resource: float = 0.0
var dont_move: float = 0.0
var item_add: float = 0.0
var item_add_temp = null
var move: float = 0.0
var move_view: float = 0.0
var anim_touch: float = 0.0
var cont_add: float = 0.0
var move_tuberia: float = 0.0
var active_menu: float = 0.0
var fast_clean: float = 0.0
var can_clean: float = 0.0
var i_index: float = 0.0
var anim_right: float = 0.0
var cont_panel_right: float = 0.0
var anim_left: float = 0.0
var cont_panel_left: float = 0.0
var anim_top: float = 0.0
var cont_panel_top: float = 0.0
var anim_creator: float = 0.0
var cont_panel_creator: float = 0.0
var anim_bottom: float = 0.0
var cont_panel_bottom: float = 0.0
var copy: float = 0.0


# from objects/obj_cursor/Create_0.gml
func _create() -> void:
	match float(G.jugador):
		0.0:
			cursor = A.spr_cursor_mario
		1.0:
			cursor = A.spr_cursor_luigi
		2.0:
			cursor = A.spr_cursor_toad
		3.0:
			cursor = A.spr_cursor_toadette
	msx = 0.0
	msy = 0.0
	position_resource = 0.0
	dont_move = 0.0
	image_speed = 0.0
	image_index = 0.0
	item_add = 0.0
	item_add_temp = 0.0
	move = 0.0
	move_view = 0.0
	anim_touch = 0.0
	cont_add = 0.0
	move_tuberia = 0.0
	active_menu = 0.0
	fast_clean = 0.0
	can_clean = 0.0
	i_index = 0.0
	GM.instance_create(x, y, A.obj_creation_preview)
	G.select_resource = A.obj_resource_empty
	G.size = 1.0
	anim_right = 0.0
	cont_panel_right = 0.0
	anim_left = 0.0
	cont_panel_left = 0.0
	anim_top = 0.0
	cont_panel_top = 0.0
	anim_creator = 0.0
	cont_panel_creator = 0.0
	anim_bottom = 0.0
	cont_panel_bottom = 0.0
	copy = 1.0


# from objects/obj_cursor/Step_1.gml
func _step_begin() -> void:
	x = GM.mouse_x
	y = GM.mouse_y
	if place_meeting(x, y, A.obj_parent_layout):
		dont_move = 1.0
	elif place_meeting(x, y, A.obj_mario_editor):
		dont_move = 2.0
	else:
		dont_move = 0.0
	if GM.room == A.rm_editor and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and G.cursor == 2.0:
		G.cursor = 0.0
		_user_0()
	if GM.mouse_check_button(GM.mb_left) and G.cursor == 2.0 and fast_clean == 0.0:
		i_index = 1.0
	elif G.cursor == 2.0 and fast_clean == 0.0:
		i_index = 0.0
	if GM.instance_exists(A.obj_levelmanager):
		if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 349.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0) and move == 1.0 and anim_right <= 33.0 and cont_panel_right == 0.0:
			if anim_right < 33.0:
				anim_right += 5.5
			else:
				anim_right = 33.0
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 349.0) and cont_panel_right == 0.0 and anim_right > 0.0:
			if anim_right > 0.0:
				anim_right -= 5.5
			else:
				anim_right = 0.0
				GM.audio_play_sound(A.snd_panel_derecho, 0.0, false)
	if cont_panel_right == 1.0 and anim_right <= 33.0:
		if anim_right < 33.0:
			anim_right += 5.5
		else:
			anim_right = 33.0
			cont_panel_right = 3.0
	if cont_panel_right == 2.0 and anim_right >= 0.0:
		if anim_right > 0.0:
			anim_right -= 5.5
		else:
			anim_right = 0.0
			cont_panel_right = 0.0
	if GM.instance_exists(A.obj_levelmanager):
		if (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0) and move == 1.0 and anim_left <= 54.0 and cont_panel_left == 0.0) or (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0) and GM.instance_find(A.obj_erase, 0).active == 1.0 and anim_left <= 54.0 and cont_panel_left == 0.0):
			if anim_left < 54.0:
				anim_left += 9.0
			else:
				anim_left = 54.0
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0) and cont_panel_left == 0.0 and anim_left > 0.0:
			if anim_left > 0.0:
				anim_left -= 9.0
			else:
				anim_left = 0.0
	if cont_panel_left == 1.0 and anim_left <= 54.0:
		if anim_left < 54.0:
			anim_left += 9.0
		else:
			anim_left = 54.0
			cont_panel_left = 3.0
	if cont_panel_left == 2.0 and anim_left >= -2.0:
		if anim_left > 0.0:
			anim_left -= 9.0
		else:
			anim_left = 0.0
			cont_panel_left = 0.0
	if GM.instance_exists(A.obj_levelmanager):
		if (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 36.0) and move == 1.0 and anim_top <= 34.0 and cont_panel_top == 0.0) or (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 36.0) and GM.instance_find(A.obj_erase, 0).active == 1.0 and anim_top <= 34.0 and cont_panel_top == 0.0):
			if anim_top < 34.0:
				anim_top = minf(anim_top + 6.8, 34.0)
			else:
				anim_top = 34.0
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 36.0) and cont_panel_top == 0.0 and anim_top > 0.0:
			if anim_top > 0.0:
				anim_top = maxf(anim_top - 6.8, 0.0)
			else:
				anim_top = 0.0
	if cont_panel_top == 1.0:
		if anim_top < 34.0:
			anim_top = minf(anim_top + 6.8, 34.0)
		else:
			anim_top = 34.0
			cont_panel_top = 3.0
	if cont_panel_top == 2.0:
		if anim_top > 0.0:
			anim_top = maxf(anim_top - 6.8, 0.0)
		else:
			anim_top = 0.0
			cont_panel_top = 0.0
	if GM.instance_exists(A.obj_levelmanager):
		if (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 44.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 180.0) and move == 1.0 and anim_creator <= 59.0 and cont_panel_creator == 0.0) or (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 44.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 180.0) and GM.instance_find(A.obj_erase, 0).active == 1.0 and anim_creator <= 84.0 and cont_panel_creator == 0.0):
			if anim_creator < 84.0:
				anim_creator += 12.0
			else:
				anim_creator = 84.0
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 61.0) and cont_panel_creator == 0.0 and anim_creator > 0.0:
			if anim_creator > 0.0:
				anim_creator -= 12.0
			else:
				anim_creator = 0.0
	if cont_panel_creator == 1.0 and anim_creator <= 84.0:
		if anim_creator < 84.0:
			anim_creator += 12.0
		else:
			anim_creator = 84.0
			cont_panel_creator = 3.0
	if cont_panel_creator == 2.0 and anim_creator >= 0.0:
		if anim_creator > 0.0:
			anim_creator -= 12.0
		else:
			anim_creator = 0.0
			cont_panel_creator = 0.0
	if GM.instance_exists(A.obj_levelmanager):
		if (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 312.0) and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 344.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 192.0) and move == 1.0 and anim_bottom <= 24.0 and cont_panel_bottom == 0.0) or (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 312.0) and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 344.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 192.0) and GM.instance_find(A.obj_erase, 0).active == 1.0 and anim_bottom <= 24.0 and cont_panel_bottom == 0.0):
			if anim_bottom < 24.0:
				anim_bottom += 6.0
			else:
				anim_bottom = 24.0
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 312.0) or x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 344.0) or y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 192.0)) and cont_panel_bottom == 0.0 and anim_bottom > 0.0:
			if anim_bottom > 0.0:
				anim_bottom -= 6.0
			else:
				anim_bottom = 0.0


# from objects/obj_cursor/Alarm_0.gml
func _alarm_0() -> void:
	if item_add_temp != A.obj_angrysun:
		if item_add_temp == A.obj_pink_coin_res and GM.instance_number(A.obj_pink_coin_res) == 5:
			pass
		else:
			G.select_resource = item_add_temp
	item_add_temp = 0.0
	for _obj_write1 in GM.with_list(A.obj_editormanager):
		_obj_write1.expand_open = 0.0


# from objects/obj_cursor/Other_10.gml
func _user_0() -> void:
	if G.cursor == 2.0:
		cursor = A.spr_cursor_clean
		if fast_clean == 1.0:
			i_index = 1.0
		else:
			i_index = 0.0
	else:
		match float(G.jugador):
			0.0:
				cursor = A.spr_cursor_mario
			1.0:
				cursor = A.spr_cursor_luigi
			2.0:
				cursor = A.spr_cursor_toad
			3.0:
				cursor = A.spr_cursor_toadette
		match float(G.cursor):
			0.0:
				i_index = 0.0
			1.0:
				i_index = 1.0


# from objects/obj_cursor/Other_11.gml
func _user_1() -> void:
	if GM.instance_exists(A.obj_levelmanager) and G.resource_create == 1.0 and GM.mouse_y < (GM.room_height - 2.0) and GM.mouse_y > 0.0 and GM.mouse_x > 0.0 and GM.mouse_x < (GM.room_width - 2.0) and (not GM.instance_exists(A.obj_edit_menu)):
		GM.audio_stop_sound(A.snd_mario_add)
		GM.audio_play_sound(A.snd_mario_add, 0.0, false)
		if G.select_resource == A.obj_ground:
			var _with_target3 = GM.instance_create((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), A.obj_ground)
			var _other2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target3):
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
				inst.event_user(8)
			GM.other = _other2
		elif G.select_resource == A.obj_slopes:
			var _with_target5 = GM.instance_create((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), A.obj_slopes)
			var _other4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target5):
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
				inst.event_user(8)
			GM.other = _other4
		else:
			var _with_target7 = GM.instance_create((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), G.select_resource)
			var _other6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target7):
				inst.expand3 = 1.0
			GM.other = _other6


# from objects/obj_cursor/Other_12.gml
func _user_2() -> void:
	GM.instance_create((x - 8.0), (y - 8.0), A.obj_call_mario)


# from objects/obj_cursor/Other_13.gml
func _user_3() -> void:
	item_add = 0.0
	if cont_panel_right == 0.0:
		cont_panel_right = 1.0
	if cont_panel_left == 0.0:
		cont_panel_left = 1.0
	# Reverse an in-progress reveal when switching into a playtest.
	if cont_panel_top == 0.0 or cont_panel_top == 2.0:
		cont_panel_top = 1.0
	cont_panel_creator = 1.0


# from objects/obj_cursor/Other_14.gml
func _user_4() -> void:
	item_add = 0.0
	if cont_panel_right == 3.0:
		cont_panel_right = 2.0
	if cont_panel_left == 3.0:
		cont_panel_left = 2.0
	if cont_panel_top == 3.0:
		cont_panel_top = 2.0
	cont_panel_creator = 1.0


# from objects/obj_cursor/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(cursor, i_index, (GM.mouse_x - 1.0), (GM.mouse_y - 1.0))


# from objects/obj_cursor/Mouse_50.gml
func _mouse_50() -> void:
	if GM.room == A.rm_editor and (Scr.scr_insideview(self) > 0.5) and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0:
		if (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_layout)) and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_groundparent, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_groundparent)):
			if G.cursor == 0.0 and G.editor_activity == 1.0 and G.select_resource != A.obj_resource_empty and (((collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_resource, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_resource))) or collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_sounds, true, true) != null) and GM.instance_find(A.obj_creation_preview, 0).place == 0.0 and (GM.instance_find(A.obj_cursor, 0).dont_move == 0.0 or GM.instance_find(A.obj_cursor, 0).dont_move == 2.0) and (not place_meeting(x, y, A.obj_arrow_lock)) and (G.select_resource == A.obj_ground or G.select_resource == A.obj_block_res or G.select_resource == A.obj_rock_res or G.select_resource == A.obj_ice_res or G.select_resource == A.obj_onoffplatform_res or G.select_resource == A.obj_onoffplatform_blue_res or G.select_resource == A.obj_pblock_res or G.select_resource == A.obj_pblock2_res or G.select_resource == A.obj_qblock_res or G.select_resource == A.obj_block_hidden_res or G.select_resource == A.obj_pinchos_res or G.select_resource == A.obj_coin_res):
				G.resource_create = 1.0
				_user_1()
# from objects/obj_cursor/Mouse_51.gml
func _mouse_51() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0 and GM.os_type != GM.os_android and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0):
		if G.cursor == 0.0 and G.editor_activity == 1.0:
			fast_clean = 1.0
			G.cursor = 2.0
			_user_0()
			var _with_target10 = A.obj_erase
			var _other9: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target10):
				inst.event_user(0)
			GM.other = _other9
	else:
		G.cursor = 0.0
	if GM.instance_exists(A.obj_ventana) and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_ventana, true, true) == null):
		var _with_target12 = A.obj_ventana
		var _other11: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target12):
			inst.can_anim2 = 1.0
		GM.other = _other11


# from objects/obj_cursor/Mouse_53.gml
func _mouse_53() -> void:
	if GM.room == A.rm_editor and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_exists(A.obj_editormanager) and (Scr.scr_insideview(self) > 0.5) and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0 and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0):
		if (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_layout)) and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_ground2, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_ground2)) and (collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_ground3, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_ground3)):
			if G.cursor == 0.0 and G.editor_activity == 1.0 and G.select_resource != A.obj_resource_empty and (((collision_rectangle((floorf((GM.mouse_x / 16.0)) * 16.0), (floorf((GM.mouse_y / 16.0)) * 16.0), ((floorf((GM.mouse_x / 16.0)) * 16.0) + 15.0), ((floorf((GM.mouse_y / 16.0)) * 16.0) + 15.0), A.obj_parent_resource, true, true) == null) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_resource))) or (place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_sounds) and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0)) and (not place_meeting(x, y, A.obj_arrow_lock)) and GM.instance_find(A.obj_creation_preview, 0).place == 0.0 and (GM.instance_find(A.obj_cursor, 0).dont_move == 0.0 or GM.instance_find(A.obj_cursor, 0).dont_move == 2.0) and G.select_resource != A.obj_ground and G.select_resource != A.obj_slopes and G.select_resource != A.obj_block_res and G.select_resource != A.obj_rock_res and G.select_resource != A.obj_ice_res and G.select_resource != A.obj_coin_res and G.select_resource != A.obj_onoffplatform_res and G.select_resource != A.obj_onoffplatform_blue_res and G.select_resource != A.obj_pblock_res and G.select_resource != A.obj_pblock2_res and G.select_resource != A.obj_qblock_res and G.select_resource != A.obj_block_hidden_res and G.select_resource != A.obj_pinchos_res:
				G.resource_create = 1.0
				_user_1()
			elif GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0:
				pass
	if GM.instance_exists(A.obj_ventana):
		var _with_target14 = A.obj_ventana
		var _other13: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target14):
			if inst.can_anim == 0.0:
				inst.can_anim2 = 1.0
		GM.other = _other13
	if GM.instance_exists(A.obj_ventana_mario):
		var _with_target16 = A.obj_ventana_mario
		var _other15: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target16):
			if inst.can_anim == 0.0:
				inst.can_anim2 = 1.0
		GM.other = _other15


# from objects/obj_cursor/Mouse_56.gml
func _mouse_56() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		G.resource_create = 0.0
	if move_view == 1.0:
		move_view = 0.0
		speed = 0.0
		if not GM.instance_exists(A.obj_ventana_mario):
			for _obj_write17 in GM.with_list(A.obj_editormanager):
				_obj_write17.expand_open = 0.0
	if not GM.veq(G.resource_move, A.obj_lighting) and GM.instance_exists(G.resource_move):
		var _with_target19 = G.resource_move
		var _other18: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target19):
			inst.drag = 0.0
			for _obj_write20 in GM.with_list(A.obj_cursor):
				_obj_write20.move = 0.0
			G.resource_block = 0.0
			if G.cursor != 2.0:
				G.cursor = 0.0
				var _with_target22 = A.obj_cursor
				var _other21: GMObject = GM.other
				GM.other = inst
				for inst2 in GM.with_list(_with_target22):
					inst2.event_user(0)
				GM.other = _other21
		GM.other = _other18
		G.resource_move = 0.0
	if GM.instance_exists(A.obj_water_move) and GM.instance_find(A.obj_water_move, 0).drag == 1.0:
		var _with_target24 = A.obj_water_move
		var _other23: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target24):
			inst.drag = 0.0
			G.resource_block = 0.0
			G.cursor = 0.0
			var _with_target26 = A.obj_cursor
			var _other25: GMObject = GM.other
			GM.other = inst
			for inst2 in GM.with_list(_with_target26):
				inst2.event_user(0)
			GM.other = _other25
		GM.other = _other23
	if GM.instance_exists(A.obj_water_move_limit) and GM.instance_find(A.obj_water_move_limit, 0).drag == 1.0:
		var _with_target28 = A.obj_water_move_limit
		var _other27: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target28):
			inst.drag = 0.0
			G.resource_block = 0.0
			G.cursor = 0.0
			var _with_target30 = A.obj_cursor
			var _other29: GMObject = GM.other
			GM.other = inst
			for inst2 in GM.with_list(_with_target30):
				inst2.event_user(0)
			GM.other = _other29
		GM.other = _other27


# from objects/obj_cursor/Mouse_57.gml
func _mouse_57() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.cursor == 2.0 and G.editor_activity == 1.0:
			var _with_target32 = A.obj_erase
			var _other31: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target32):
				inst.event_user(0)
			GM.other = _other31
			fast_clean = 0.0
			G.cursor = 0.0
			_user_0()
	else:
		G.cursor = 0.0
