extends GMObject

var can_move: float = 0.0
var velocidad: float = 0.0
var move_velocity: float = 0.0
var expand_open: float = 0.0
var anim_goma: float = 0.0
var card1: float = 0.0
var card2: float = 0.0
var card3: float = 0.0
var card4: float = 0.0
var card5: float = 0.0
var card6: float = 0.0
var card7: float = 0.0
var card8: float = 0.0
var card9: float = 0.0
var card10: float = 0.0
var card11: float = 0.0
var card12: float = 0.0
var card1_s: float = 0.0
var card2_s: float = 0.0
var card3_s: float = 0.0
var zoom: float = 0.0
var OW: float = 0.0
var OH: float = 0.0
var panel_circle = null
var door_symbol_1: float = 0.0
var door_symbol_2: float = 0.0
var door_symbol_3: float = 0.0
var door_symbol_4: float = 0.0
var door_p_symbol_1: float = 0.0
var door_p_symbol_2: float = 0.0
var door_p_symbol_3: float = 0.0
var door_p_symbol_4: float = 0.0
var door_l_symbol_1: float = 0.0
var door_l_symbol_2: float = 0.0
var door_l_symbol_3: float = 0.0
var door_l_symbol_4: float = 0.0


# from objects/obj_editormanager/Create_0.gml
func _create() -> void:
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 346.0), (GM.camera_get_view_x(GM.view_get_camera(0)) + 100.0), A.obj_expand_panels)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 58.0), (GM.camera_get_view_x(GM.view_get_camera(0)) + 100.0), A.obj_expand_panels_left)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_x(GM.view_get_camera(0)) + 34.0), A.obj_expand_paneles_top)
	can_move = 0.0
	var _with_target2 = A.obj_levelmanager
	var _other1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target2):
		inst.alarm[2] = -1.0
	GM.other = _other1
	GM.camera_set_view_target(GM.view_get_camera(0), self)
	G.modojuego = 0.0
	velocidad = 4.0
	move_velocity = 0.0
	expand_open = 0.0
	anim_goma = 0.0
	card1 = 0.0
	card2 = 0.0
	card3 = 0.0
	card4 = 0.0
	card5 = 0.0
	card6 = 0.0
	card7 = 0.0
	card8 = 0.0
	card9 = 0.0
	card10 = 0.0
	card11 = 0.0
	card12 = 0.0
	card1_s = 0.0
	card2_s = 0.0
	card3_s = 0.0
	GM.audio_stop_sound(A.snd_music_ground)
	G.timer = 0.0
	G.mariostart = 0.0
	G.carrieditem = -4.0
	G.carriedsprite = -4.0
	G.shallihold = 0.0
	G.pswitch = 0.0
	G.star = 0.0
	G.onoffblock = 0.0
	G.died = 0.0
	zoom = 0.0
	OW = GM.camera_get_view_width(GM.view_get_camera(0))
	OH = GM.camera_get_view_height(GM.view_get_camera(0))
	panel_circle = 0.0
	door_symbol_1 = 0.0
	door_symbol_2 = 0.0
	door_symbol_3 = 0.0
	door_symbol_4 = 0.0
	door_p_symbol_1 = 0.0
	door_p_symbol_2 = 0.0
	door_p_symbol_3 = 0.0
	door_p_symbol_4 = 0.0
	door_l_symbol_1 = 0.0
	door_l_symbol_2 = 0.0
	door_l_symbol_3 = 0.0
	door_l_symbol_4 = 0.0
	alarm[2] = 1.0


# from objects/obj_editormanager/Step_1.gml
func _step_begin() -> void:
	var R  # 局部变量提升（GML 的 var 是函数作用域）
	if G.instance_deactivate == 0.0:
		if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			GM.instance_activate_object(A.obj_levelmanager)
		GM.instance_activate_object(A.obj_player_trail)
		GM.instance_activate_object(A.obj_solidtop)
		GM.instance_activate_object(A.obj_deactivation)
		GM.instance_activate_object(A.obj_parent_save)
		GM.instance_activate_object(A.obj_parent_sound_o)
	if zoom == 0.0:
		if x < (Scr.__view_get(self, (int(0) << int(0)), 0.0) + (Scr.__view_get(self, (int(2) << int(0)), 0.0) / 2.0)):
			x = (Scr.__view_get(self, (int(0) << int(0)), 0.0) + (Scr.__view_get(self, (int(2) << int(0)), 0.0) / 2.0))
			if hspeed < 0.0:
				hspeed = 0.0
		elif x > ((Scr.__view_get(self, (int(0) << int(0)), 0.0) + Scr.__view_get(self, (int(2) << int(0)), 0.0)) - (Scr.__view_get(self, (int(2) << int(0)), 0.0) / 2.0)):
			x = ((Scr.__view_get(self, (int(0) << int(0)), 0.0) + Scr.__view_get(self, (int(2) << int(0)), 0.0)) - (Scr.__view_get(self, (int(2) << int(0)), 0.0) / 2.0))
			if hspeed > 0.0:
				hspeed = 0.0
		if y < (Scr.__view_get(self, (int(1) << int(0)), 0.0) + (Scr.__view_get(self, (int(3) << int(0)), 0.0) / 2.0)):
			y = (Scr.__view_get(self, (int(1) << int(0)), 0.0) + (Scr.__view_get(self, (int(3) << int(0)), 0.0) / 2.0))
			if vspeed < 0.0:
				vspeed = 0.0
		elif y > ((Scr.__view_get(self, (int(1) << int(0)), 0.0) + Scr.__view_get(self, (int(3) << int(0)), 0.0)) - (Scr.__view_get(self, (int(3) << int(0)), 0.0) / 2.0)):
			y = ((Scr.__view_get(self, (int(1) << int(0)), 0.0) + Scr.__view_get(self, (int(3) << int(0)), 0.0)) - (Scr.__view_get(self, (int(3) << int(0)), 0.0) / 2.0))
			if vspeed > 0.0:
				vspeed = 0.0
	elif zoom == 2.0:
		if x < (Scr.__view_get(self, (int(0) << int(0)), 0.0) + 80.0):
			x = (Scr.__view_get(self, (int(0) << int(0)), 0.0) + 80.0)
			if hspeed < 0.0:
				hspeed = 0.0
		elif x > ((Scr.__view_get(self, (int(0) << int(0)), 0.0) + Scr.__view_get(self, (int(2) << int(0)), 0.0)) - 80.0):
			x = ((Scr.__view_get(self, (int(0) << int(0)), 0.0) + Scr.__view_get(self, (int(2) << int(0)), 0.0)) - 80.0)
			if hspeed > 0.0:
				hspeed = 0.0
		if y < (Scr.__view_get(self, (int(1) << int(0)), 0.0) + 48.0):
			y = (Scr.__view_get(self, (int(1) << int(0)), 0.0) + 48.0)
			if vspeed < 0.0:
				vspeed = 0.0
		elif y > ((Scr.__view_get(self, (int(1) << int(0)), 0.0) + Scr.__view_get(self, (int(3) << int(0)), 0.0)) - 48.0):
			y = ((Scr.__view_get(self, (int(1) << int(0)), 0.0) + Scr.__view_get(self, (int(3) << int(0)), 0.0)) - 48.0)
			if vspeed > 0.0:
				vspeed = 0.0
	if expand_open != 0.0:
		hspeed = 0.0
		vspeed = 0.0
	match zoom:
		1.0:
			R = (Scr.__view_get(self, (int(14) << int(0)), 0.0) / Scr.__view_get(self, (int(13) << int(0)), 0.0))
			if Scr.__view_get(self, (int(2) << int(0)), 0.0) >= 704.0:
				Scr.__view_set(self, (int(2) << int(0)), 0.0, (Scr.__view_get(self, (int(2) << int(0)), 0.0) + 8.0))
				Scr.__view_set(self, (int(3) << int(0)), 0.0, (Scr.__view_get(self, (int(3) << int(0)), 0.0) + (8.0 * R)))
			else:
				Scr.__view_set(self, (int(2) << int(0)), 0.0, (Scr.__view_get(self, (int(2) << int(0)), 0.0) + 16.0))
				Scr.__view_set(self, (int(3) << int(0)), 0.0, (Scr.__view_get(self, (int(3) << int(0)), 0.0) + (16.0 * R)))
			if Scr.__view_get(self, (int(2) << int(0)), 0.0) >= 768.0:
				Scr.__view_set(self, (int(2) << int(0)), 0.0, 768.0)
				Scr.__view_set(self, (int(3) << int(0)), 0.0, 432.0)
				zoom = 2.0
				if not GM.instance_exists(A.obj_zoomclose):
					GM.instance_create(((Scr.__view_get(self, (int(0) << int(0)), 0.0) + Scr.__view_get(self, (int(2) << int(0)), 0.0)) - 40.0), (Scr.__view_get(self, (int(1) << int(0)), 0.0) + 8.0), A.obj_zoomclose)
		3.0:
			R = (Scr.__view_get(self, (int(14) << int(0)), 0.0) / Scr.__view_get(self, (int(13) << int(0)), 0.0))
			if Scr.__view_get(self, (int(2) << int(0)), 0.0) <= 256.0:
				Scr.__view_set(self, (int(2) << int(0)), 0.0, (Scr.__view_get(self, (int(2) << int(0)), 0.0) - 8.0))
				Scr.__view_set(self, (int(3) << int(0)), 0.0, (Scr.__view_get(self, (int(3) << int(0)), 0.0) - (8.0 * R)))
			else:
				Scr.__view_set(self, (int(2) << int(0)), 0.0, (Scr.__view_get(self, (int(2) << int(0)), 0.0) - 16.0))
				Scr.__view_set(self, (int(3) << int(0)), 0.0, (Scr.__view_get(self, (int(3) << int(0)), 0.0) - (16.0 * R)))
			if Scr.__view_get(self, (int(2) << int(0)), 0.0) <= 384.0:
				Scr.__view_set(self, (int(2) << int(0)), 0.0, 384.0)
				Scr.__view_set(self, (int(3) << int(0)), 0.0, 216.0)
				zoom = 0.0
				G.play_lock = 0.0
				var _with_target4 = A.obj_cursor
				var _other3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target4):
					if inst.cont_panel_right == 3.0:
						inst.cont_panel_right = 2.0
					if inst.cont_panel_left == 3.0:
						inst.cont_panel_left = 2.0
					if inst.cont_panel_top == 3.0:
						inst.cont_panel_top = 2.0
					inst.cont_panel_creator = 2.0
				GM.other = _other3
				if GM.instance_exists(A.obj_zoomclose):
					var _with_target6 = A.obj_zoomclose
					var _other5: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(_with_target6):
						inst.instance_destroy()
					GM.other = _other5


# from objects/obj_editormanager/Step_0.gml
func _step() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_exists(A.obj_mario_editor):
		GM.camera_set_view_target(GM.view_get_camera(0), self)
		if GM.instance_exists(A.obj_levelmanager):
			var _with_target8 = A.obj_levelmanager
			var _other7: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target8):
				inst.x = self.x
				inst.y = self.y
				inst.fallow_mario = 1.0
				inst.fallw = 1.0
			GM.other = _other7
		if GM.instance_find(A.obj_cursor, 0).move_view == 1.0:
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
		if (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_water == 1.0) and GM.instance_exists(A.obj_mario_editor) and (not GM.instance_exists(A.obj_ventana_water)):
			if GM.keyboard_check(G.lanzar_agarrar):
				move_velocity = 8.0
			else:
				move_velocity = 0.0
			if GM.keyboard_check(G.arriba) and (not GM.keyboard_check(G.abajo)) and GM.instance_find(A.obj_mario_editor, 0).y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0):
				vspeed = (-4.0 - move_velocity)
			elif GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)) and GM.instance_find(A.obj_mario_editor, 0).y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) - 48.0):
				vspeed = (4.0 + move_velocity)
			else:
				vspeed = 0.0
				var _with_target10 = A.obj_mario_editor
				var _other9: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target10):
					inst.vspeed = 0.0
				GM.other = _other9
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and GM.instance_find(A.obj_mario_editor, 0).x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 80.0):
				hspeed = (4.0 + move_velocity)
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and GM.instance_find(A.obj_mario_editor, 0).x < ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 80.0):
				hspeed = (-4.0 - move_velocity)
			else:
				hspeed = 0.0
				var _with_target12 = A.obj_mario_editor
				var _other11: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target12):
					inst.hspeed = 0.0
				GM.other = _other11
	else:
		GM.camera_set_view_target(GM.view_get_camera(0), A.obj_levelmanager)
	if GM.keyboard_check_pressed(GM.vk_space) and GM.instance_find(A.obj_persistent, 0).modo_android == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_water == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not GM.instance_exists(A.obj_panelparent)) and (not GM.instance_exists(A.obj_ventana)) and GM.room_width >= 768.0 and (not place_meeting(GM.mouse_x, GM.mouse_y, A.obj_dog)) and (not place_meeting(GM.mouse_x, GM.mouse_y, A.obj_creator_jugar_editar)):
		if zoom == 0.0:
			G.play_lock = 1.0
			zoom = 1.0
			var _with_target14 = A.obj_cursor
			var _other13: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target14):
				inst.anim_right = 0.0
				inst.anim_left = 0.0
				inst.anim_top = 0.0
				inst.cont_panel_right = 0.0
				inst.cont_panel_left = 0.0
				inst.cont_panel_top = 0.0
				inst.event_user(3)
			GM.other = _other13
		elif zoom == 2.0:
			zoom = 3.0
			if GM.instance_exists(A.obj_zoomclose):
				var _with_target16 = A.obj_zoomclose
				var _other15: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target16):
					inst.instance_destroy()
				GM.other = _other15
	if GM.instance_exists(A.obj_erase):
		if GM.instance_find(A.obj_erase, 0).active == 1.0:
			anim_goma += 0.1
		else:
			anim_goma = 0.0


# from objects/obj_editormanager/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.instance_exists(A.obj_panel_save_load):
		for _obj_write17 in GM.with_list(A.obj_editormanager):
			_obj_write17.expand_open = 0.0


# ORIG-BUG: clown speed branches take abs of a boolean; drybones branch reads shoe offset.
# from objects/obj_editormanager/Alarm_1.gml
func _alarm_1() -> void:
	var rastro  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		if GM.instance_exists(A.obj_yoshi2) and GM.instance_exists(A.obj_mario):
			if GM.instance_number(A.obj_player_trail) > 30:
				var _with_target19 = GM.instance_furthest(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other18: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target19):
					inst.instance_destroy()
				GM.other = _other18
			if (GM.instance_find(A.obj_yoshi2, 0).visible == true and (absf(GM.instance_find(A.obj_mario, 0).hspeed) > 0.5 or absf(GM.instance_find(A.obj_mario, 0).vspeed) > 0.25)) or (GM.instance_find(A.obj_yoshi2, 0).visible == true and GM.instance_exists(A.obj_clown) and GM.instance_find(A.obj_clown, 0).inmario == 1.0 and ((absf(float(GM.instance_find(A.obj_clown, 0).hspeed > 0.5)) > 0.5) or (absf(float(GM.instance_find(A.obj_clown, 0).vspeed > 0.25)) > 0.5))):
				var _with_target21 = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other20: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target21):
					inst.sprite_index = GM.instance_find(A.obj_yoshi2, 0).sprite_index
					inst.image_index = GM.instance_find(A.obj_yoshi2, 0).image_index
					inst.image_xscale = GM.instance_find(A.obj_yoshi2, 0).direct
					inst.y_draw = (inst.y + 16.0)
					inst.image_speed = 0.0
					inst.sprite_m_yoshi = GM.instance_find(A.obj_yoshi2, 0).sprite_mario
					inst.index_m_yoshi = GM.instance_find(A.obj_yoshi2, 0).index_mario
					inst.x_m_yoshi = GM.instance_find(A.obj_yoshi2, 0).x_mario
					inst.y_m_yoshi = GM.instance_find(A.obj_yoshi2, 0).y_mario
					if GM.instance_exists(A.obj_cap_mario) and GM.instance_find(A.obj_cap_mario, 0).visible == true:
						inst.sprite_capa = GM.instance_find(A.obj_cap_mario, 0).sprite_index
						inst.index_capa = GM.instance_find(A.obj_cap_mario, 0).image_index
						inst.direct_capa = GM.instance_find(A.obj_cap_mario, 0).direct
						inst.depth_capa = 1.0
				GM.other = _other20
		elif GM.instance_exists(A.obj_kuriboshoe) and GM.instance_exists(A.obj_mario):
			if GM.instance_number(A.obj_player_trail) > 30:
				var _with_target23 = GM.instance_furthest(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other22: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target23):
					inst.instance_destroy()
				GM.other = _other22
			if (GM.instance_find(A.obj_kuriboshoe, 0).visible == true and (absf(GM.instance_find(A.obj_mario, 0).hspeed) > 0.5 or absf(GM.instance_find(A.obj_mario, 0).vspeed) > 0.25)) or (GM.instance_find(A.obj_kuriboshoe, 0).visible == true and GM.instance_exists(A.obj_clown) and GM.instance_find(A.obj_clown, 0).inmario == 1.0 and ((absf(float(GM.instance_find(A.obj_clown, 0).hspeed > 0.5)) > 0.5) or (absf(float(GM.instance_find(A.obj_clown, 0).vspeed > 0.25)) > 0.5))):
				var _with_target25 = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other24: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target25):
					inst.drybones = 1.0
					inst.sprite_index = GM.instance_find(A.obj_kuriboshoe, 0).sprite_index
					inst.image_index = GM.instance_find(A.obj_kuriboshoe, 0).image_index
					inst.image_xscale = GM.instance_find(A.obj_mario, 0).direct
					inst.y_draw = ((inst.y + 16.0) - GM.instance_find(A.obj_kuriboshoe, 0).offset)
					inst.image_speed = 0.0
					inst.sprite_m_yoshi = GM.instance_find(A.obj_kuriboshoe, 0).m_sprite
					inst.index_m_yoshi = GM.instance_find(A.obj_kuriboshoe, 0).m_subimagen
					inst.x_m_yoshi = GM.instance_find(A.obj_kuriboshoe, 0).x
					if G.powerup == -77.0:
						inst.y_m_yoshi = ((GM.instance_find(A.obj_kuriboshoe, 0).y - 32.0) - GM.instance_find(A.obj_kuriboshoe, 0).offset)
					else:
						inst.y_m_yoshi = ((GM.instance_find(A.obj_kuriboshoe, 0).y - 16.0) - GM.instance_find(A.obj_kuriboshoe, 0).offset)
				GM.other = _other24
		elif GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_exists(A.obj_mario):
			if GM.instance_number(A.obj_player_trail) > 30:
				var _with_target27 = GM.instance_furthest(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other26: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target27):
					inst.instance_destroy()
				GM.other = _other26
			if (GM.instance_find(A.obj_kuribo_drybones, 0).visible == true and (absf(GM.instance_find(A.obj_mario, 0).hspeed) > 0.5 or absf(GM.instance_find(A.obj_mario, 0).vspeed) > 0.25)) or (GM.instance_find(A.obj_kuribo_drybones, 0).visible == true and GM.instance_exists(A.obj_clown) and GM.instance_find(A.obj_clown, 0).inmario == 1.0 and ((absf(float(GM.instance_find(A.obj_clown, 0).hspeed > 0.5)) > 0.5) or (absf(float(GM.instance_find(A.obj_clown, 0).vspeed > 0.25)) > 0.5))):
				var _with_target29 = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other28: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target29):
					inst.drybones = 1.0
					inst.sprite_index = GM.instance_find(A.obj_kuribo_drybones, 0).sprite_index
					inst.image_index = GM.instance_find(A.obj_kuribo_drybones, 0).image_index
					inst.image_xscale = GM.instance_find(A.obj_mario, 0).direct
					inst.y_draw = ((inst.y + 16.0) - GM.instance_find(A.obj_kuriboshoe, 0).offset)
					inst.image_speed = 0.0
					inst.sprite_m_yoshi = GM.instance_find(A.obj_kuribo_drybones, 0).m_sprite
					inst.index_m_yoshi = GM.instance_find(A.obj_kuribo_drybones, 0).m_subimagen
					inst.x_m_yoshi = GM.instance_find(A.obj_kuribo_drybones, 0).x
					if G.powerup == -77.0:
						inst.y_m_yoshi = ((GM.instance_find(A.obj_kuribo_drybones, 0).y - 32.0) - GM.instance_find(A.obj_kuribo_drybones, 0).offset)
					else:
						inst.y_m_yoshi = ((GM.instance_find(A.obj_kuribo_drybones, 0).y - 16.0) - GM.instance_find(A.obj_kuribo_drybones, 0).offset)
					if GM.instance_exists(A.obj_cap_mario) and GM.instance_find(A.obj_cap_mario, 0).visible == true:
						inst.sprite_capa = GM.instance_find(A.obj_cap_mario, 0).sprite_index
						inst.index_capa = GM.instance_find(A.obj_cap_mario, 0).image_index
						inst.direct_capa = GM.instance_find(A.obj_cap_mario, 0).direct
				GM.other = _other28
		elif GM.instance_exists(A.obj_mario_pballon) and GM.instance_exists(A.obj_mario):
			if GM.instance_number(A.obj_player_trail) > 30:
				var _with_target31 = GM.instance_furthest(GM.instance_find(A.obj_mario_pballon, 0).x, GM.instance_find(A.obj_mario_pballon, 0).y, A.obj_player_trail)
				var _other30: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target31):
					inst.instance_destroy()
				GM.other = _other30
			if GM.instance_find(A.obj_mario_pballon, 0).visible == true and (absf(GM.instance_find(A.obj_mario_pballon, 0).hspeed) > 0.5 or absf(GM.instance_find(A.obj_mario_pballon, 0).vspeed) > 0.25):
				var _with_target33 = GM.instance_create(GM.instance_find(A.obj_mario_pballon, 0).x, GM.instance_find(A.obj_mario_pballon, 0).y, A.obj_player_trail)
				var _other32: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target33):
					inst.sprite_index = GM.instance_find(A.obj_mario_pballon, 0).sprite_index
					inst.image_index = GM.instance_find(A.obj_mario_pballon, 0).image_index
					inst.image_angle = GM.instance_find(A.obj_mario_pballon, 0).image_angle
					inst.image_speed = 0.0
				GM.other = _other32
		elif GM.instance_exists(A.obj_mario) and (GM.instance_exists(A.obj_link_atack) or GM.instance_exists(A.obj_link_dash_atack) or GM.instance_exists(A.obj_link_down_atack)):
			if GM.instance_exists(A.obj_link_atack):
				rastro = A.obj_link_atack
			elif GM.instance_exists(A.obj_link_dash_atack):
				rastro = A.obj_link_dash_atack
			elif GM.instance_exists(A.obj_link_down_atack):
				rastro = A.obj_link_down_atack
			if GM.instance_number(A.obj_player_trail) > 30:
				var _with_target35 = GM.instance_furthest(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other34: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target35):
					inst.instance_destroy()
				GM.other = _other34
			if absf(GM.instance_find(A.obj_mario, 0).hspeed) > 0.5 or absf(GM.instance_find(A.obj_mario, 0).vspeed) > 0.25:
				var ras = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _with_target37 = ras
				var _other36: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target37):
					inst.image_xscale = GM.instance_find(A.obj_mario, 0).direct
					inst.image_speed = 0.0
				GM.other = _other36
				ras.sprite_index = GM.instance_find(int(rastro), 0).sprite_index
				ras.image_index = GM.instance_find(int(rastro), 0).image_index
		elif GM.instance_exists(A.obj_mario):
			if GM.instance_number(A.obj_player_trail) > 30:
				var _with_target39 = GM.instance_furthest(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other38: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target39):
					inst.instance_destroy()
				GM.other = _other38
			if (GM.instance_find(A.obj_mario, 0).visible == true and (absf(GM.instance_find(A.obj_mario, 0).hspeed) > 0.5 or absf(GM.instance_find(A.obj_mario, 0).vspeed) > 0.25)) or (GM.instance_find(A.obj_mario, 0).visible == true and GM.instance_exists(A.obj_clown) and GM.instance_find(A.obj_clown, 0).inmario == 1.0 and ((absf(float(GM.instance_find(A.obj_clown, 0).hspeed > 0.5)) > 0.5) or (absf(float(GM.instance_find(A.obj_clown, 0).vspeed > 0.25)) > 0.5))):
				var _with_target41 = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_trail)
				var _other40: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target41):
					inst.sprite_index = GM.instance_find(A.obj_mario, 0).sprite_index
					inst.image_index = GM.instance_find(A.obj_mario, 0).image_index
					inst.image_xscale = GM.instance_find(A.obj_mario, 0).direct
					inst.image_speed = 0.0
					if GM.instance_exists(A.obj_cap_mario) and GM.instance_find(A.obj_cap_mario, 0).visible == true:
						inst.sprite_capa = GM.instance_find(A.obj_cap_mario, 0).sprite_index
						inst.index_capa = GM.instance_find(A.obj_cap_mario, 0).image_index
						inst.direct_capa = GM.instance_find(A.obj_cap_mario, 0).direct
				GM.other = _other40
		if G.powerup == -82.0:
			alarm[1] = 30.0
		else:
			alarm[1] = 10.0
	else:
		alarm[1] = -1.0


# from objects/obj_editormanager/Alarm_2.gml
func _alarm_2() -> void:
	if G.instance_deactivate == 1.0:
		if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			GM.instance_deactivate_object(A.obj_ground2)
			GM.instance_deactivate_object(A.obj_solidtop)
			GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0), -96.0, ((GM.camera_get_view_width(GM.view_get_camera(0)) + 128.0) + 128.0), (GM.room_height + 192.0), true)
			GM.instance_deactivate_object(A.obj_deactivation)
			GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0), -96.0, ((GM.camera_get_view_width(GM.view_get_camera(0)) + 128.0) + 128.0), (GM.room_height + 192.0), true)
			GM.instance_deactivate_object(A.obj_modelbgo)
			GM.instance_deactivate_object(A.obj_parent_sound_o)
			GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 32.0), ((GM.camera_get_view_width(GM.view_get_camera(0)) + 32.0) + 32.0), ((GM.camera_get_view_height(GM.view_get_camera(0)) + 32.0) + 32.0), true)
			GM.instance_deactivate_object(A.obj_parent_save)
		else:
			var _with_target43 = A.obj_parent_save
			var _other42: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target43):
				if inst.exception == 0.0:
					if GM.object_is_ancestor(inst.object_index, A.obj_parent_resource):
						if inst.drag == 0.0:
							GM.instance_deactivate_object(inst)
					else:
						GM.instance_deactivate_object(inst)
			GM.other = _other42
			GM.instance_deactivate_object(A.obj_ground)
			GM.instance_deactivate_object(A.obj_slopes)
			GM.instance_deactivate_object(A.obj_ground2)
			GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 32.0), ((GM.camera_get_view_width(GM.view_get_camera(0)) + 32.0) + 32.0), ((GM.camera_get_view_height(GM.view_get_camera(0)) + 32.0) + 32.0), true)
	alarm[2] = 2.0


# from objects/obj_editormanager/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_physicsparent):
		var _with_target45 = A.obj_physicsparent
		var _other44: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target45):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
		GM.other = _other44
	if GM.instance_exists(A.obj_holdparent):
		var _with_target47 = A.obj_holdparent
		var _other46: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target47):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
		GM.other = _other46
	if GM.instance_exists(A.obj_spike):
		var _with_target49 = A.obj_spike
		var _other48: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target49):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
			inst.alarm[0] = -1.0
		GM.other = _other48
	if GM.instance_exists(A.obj_key_appear):
		var _with_target51 = A.obj_key_appear
		var _other50: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target51):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.alarm[1] = -1.0
		GM.other = _other50
	if GM.instance_exists(A.obj_magikoopa):
		var _with_target53 = A.obj_magikoopa
		var _other52: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target53):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
		GM.other = _other52
	if GM.instance_exists(A.obj_boomboom):
		var _with_target55 = A.obj_boomboom
		var _other54: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target55):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
		GM.other = _other54
	if GM.instance_exists(A.obj_icecoin):
		var _with_target57 = A.obj_icecoin
		var _other56: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target57):
			inst.image_speed = 0.0
			inst.image_index = 0.0
		GM.other = _other56
	if GM.instance_exists(A.obj_pink_coin):
		var _with_target59 = A.obj_pink_coin
		var _other58: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target59):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other58
	if GM.instance_exists(A.obj_key):
		var _with_target61 = A.obj_key
		var _other60: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target61):
			inst.speed = 0.0
			inst.image_index = 0.0
			inst.image_speed = 0.0
		GM.other = _other60
	if GM.instance_exists(A.obj_egg):
		var _with_target63 = A.obj_egg
		var _other62: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target63):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[2] = -1.0
			inst.alarm[10] = -1.0
		GM.other = _other62
	if GM.instance_exists(A.obj_cheepcheep):
		var _with_target65 = A.obj_cheepcheep
		var _other64: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target65):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[1] = -1.0
		GM.other = _other64
	if GM.instance_exists(A.obj_cheepcheep2):
		var _with_target67 = A.obj_cheepcheep
		var _other66: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target67):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[1] = -1.0
		GM.other = _other66
	if GM.instance_exists(A.obj_chain_chomp_free):
		var _with_target69 = A.obj_chain_chomp_free
		var _other68: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target69):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.fallow_chomp = 0.0
			inst.alarm[10] = -1.0
		GM.other = _other68
	if GM.instance_exists(A.obj_1up):
		var _with_target71 = A.obj_1up
		var _other70: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target71):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
		GM.other = _other70
	if GM.instance_exists(A.obj_torbellino):
		var _with_target73 = A.obj_torbellino
		var _other72: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target73):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[10] = -1.0
		GM.other = _other72
	if GM.instance_exists(A.obj_bullebill_base):
		var _with_target75 = A.obj_bullebill_base
		var _other74: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target75):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other74
	if GM.instance_exists(A.obj_galoomba):
		var _with_target77 = A.obj_galoomba
		var _other76: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target77):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other76
	if GM.instance_exists(A.obj_plant_fire):
		var _with_target79 = A.obj_plant_fire
		var _other78: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target79):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[2] = -1.0
		GM.other = _other78
	if GM.instance_exists(A.obj_jumppiranha):
		var _with_target81 = A.obj_jumppiranha
		var _other80: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target81):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other80
	if GM.instance_exists(A.obj_hammerbro):
		var _with_target83 = A.obj_hammerbro
		var _other82: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target83):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
			inst.image_speed = 0.0
		GM.other = _other82
	if GM.instance_exists(A.obj_firebro):
		var _with_target85 = A.obj_firebro
		var _other84: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target85):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
			inst.image_speed = 0.0
		GM.other = _other84
	if GM.instance_exists(A.obj_sledgebro):
		var _with_target87 = A.obj_sledgebro
		var _other86: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target87):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[3] = -1.0
			inst.image_speed = 0.0
		GM.other = _other86
	if GM.instance_exists(A.obj_bobomb_ready):
		var _with_target89 = A.obj_bobomb_ready
		var _other88: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target89):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[1] = -1.0
		GM.other = _other88
	if GM.instance_exists(A.obj_banzaibill):
		var _with_target91 = A.obj_banzaibill
		var _other90: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target91):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[10] = -1.0
		GM.other = _other90
	if GM.instance_exists(A.obj_smoke):
		var _with_target93 = A.obj_smoke
		var _other92: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target93):
			inst.image_speed = 0.0
		GM.other = _other92
	if GM.instance_exists(A.obj_rotten_signal):
		var _with_target95 = A.obj_rotten_signal
		var _other94: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target95):
			inst.vspeed = 0.0
			inst.image_speed = 0.0
		GM.other = _other94
	if GM.instance_exists(A.obj_blockparent):
		var _with_target97 = A.obj_blockparent
		var _other96: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target97):
			inst.image_speed = 0.0
			inst.speed = 0.0
		GM.other = _other96
	if GM.instance_exists(A.obj_cap):
		var _with_target99 = A.obj_cap
		var _other98: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target99):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other98
	if GM.instance_exists(A.obj_coin):
		var _with_target101 = A.obj_coin
		var _other100: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target101):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.speed = 0.0
		GM.other = _other100
	if GM.instance_exists(A.obj_coin10):
		var _with_target103 = A.obj_coin10
		var _other102: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target103):
			inst.image_speed = 0.0
		GM.other = _other102
	if GM.instance_exists(A.obj_drybones):
		var _with_target105 = A.obj_drybones
		var _other104: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target105):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other104
	if GM.instance_exists(A.obj_clown):
		var _with_target107 = A.obj_clown
		var _other106: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target107):
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
		GM.other = _other106
	if GM.instance_exists(A.obj_bumper):
		var _with_target109 = A.obj_bumper
		var _other108: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target109):
			inst.alarm[0] = -1.0
		GM.other = _other108
	if GM.instance_exists(A.obj_checkpoint):
		var _with_target111 = A.obj_checkpoint
		var _other110: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target111):
			inst.image_speed = 0.0
		GM.other = _other110
	if GM.instance_exists(A.obj_pinchos):
		var _with_target113 = A.obj_pinchos
		var _other112: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target113):
			inst.image_speed = 0.0
		GM.other = _other112
	if GM.instance_exists(A.obj_cinta):
		var _with_target115 = A.obj_cinta
		var _other114: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target115):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
		GM.other = _other114
	if GM.instance_exists(A.obj_meteorites):
		var _with_target117 = A.obj_meteorites
		var _other116: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target117):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.image_speed = 0.0
		GM.other = _other116
	if GM.instance_exists(A.obj_meteorites_big):
		var _with_target119 = A.obj_meteorites_big
		var _other118: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target119):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.image_speed = 0.0
		GM.other = _other118


# from objects/obj_editormanager/Other_12.gml
func _user_2() -> void:
	GM.instance_activate_all()
	if GM.instance_exists(A.obj_enemyparent):
		var _with_target121 = A.obj_enemyparent
		var _other120: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target121):
			inst.image_speed = 0.15
			inst.alarm[10] = 1.0
		GM.other = _other120
	if GM.instance_exists(A.obj_monty_chase):
		var _with_target123 = A.obj_monty_chase
		var _other122: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target123):
			inst.image_speed = 0.2
		GM.other = _other122
	if GM.instance_exists(A.obj_spike):
		var _with_target125 = A.obj_spike
		var _other124: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target125):
			inst.alarm[10] = 1.0
			inst.alarm[0] = 2.0
			inst.image_speed = 0.15
		GM.other = _other124
	if GM.instance_exists(A.obj_magikoopa):
		var _with_target127 = A.obj_magikoopa
		var _other126: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target127):
			inst.alarm[10] = -1.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
			inst.image_speed = 0.0
			inst.hspeed = 0.0
		GM.other = _other126
	if GM.instance_exists(A.obj_boomboom):
		var _with_target129 = A.obj_boomboom
		var _other128: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target129):
			inst.alarm[10] = 1.0
		GM.other = _other128
	if GM.instance_exists(A.obj_boomboom_b):
		var _with_target131 = A.obj_boomboom_b
		var _other130: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target131):
			inst.alarm[10] = 1.0
		GM.other = _other130
	if GM.instance_exists(A.obj_icecoin):
		var _with_target133 = A.obj_icecoin
		var _other132: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target133):
			inst.image_speed = 0.15
		GM.other = _other132
	if GM.instance_exists(A.obj_pink_coin):
		var _with_target135 = A.obj_pink_coin
		var _other134: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target135):
			inst.alarm[0] = 1.0
			inst.image_speed = 0.15
		GM.other = _other134
	if GM.instance_exists(A.obj_chain_chomp_free):
		var _with_target137 = A.obj_chain_chomp_free
		var _other136: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target137):
			inst.alarm[10] = 2.0
		GM.other = _other136
	if GM.instance_exists(A.obj_key):
		var _with_target139 = A.obj_key
		var _other138: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target139):
			inst.image_speed = 0.18
		GM.other = _other138
	if GM.instance_exists(A.obj_egg):
		var _with_target141 = A.obj_egg
		var _other140: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target141):
			inst.image_speed = 0.0
			if G.apariencia == 1.0:
				inst.alarm[2] = 7.0
				inst.alarm[10] = 2.0
		GM.other = _other140
	if GM.instance_exists(A.obj_torbellino):
		var _with_target143 = A.obj_torbellino
		var _other142: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target143):
			inst.image_speed = 0.15
			inst.alarm[0] = 5.0
			inst.alarm[10] = 1.0
		GM.other = _other142
	if GM.instance_exists(A.obj_plant_fire):
		var _with_target145 = A.obj_plant_fire
		var _other144: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target145):
			inst.image_speed = 0.1
			inst.alarm[10] = 1.0
			inst.alarm[2] = 120.0
		GM.other = _other144
	if GM.instance_exists(A.obj_angrysun):
		var _with_target147 = A.obj_angrysun
		var _other146: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target147):
			inst.image_speed = 0.15
			inst.alarm[10] = -1.0
			inst.hspeed = 0.0
		GM.other = _other146
	if GM.instance_exists(A.obj_sledgebro):
		var _with_target149 = A.obj_sledgebro
		var _other148: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target149):
			inst.image_speed = 0.125
			inst.alarm[0] = 70.0
			inst.alarm[1] = 300.0
			inst.alarm[3] = 60.0
		GM.other = _other148
	if GM.instance_exists(A.obj_podoboo):
		var _with_target151 = A.obj_podoboo
		var _other150: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target151):
			inst.image_speed = 0.2
			inst.gravity = 0.2
			inst.hspeed = 0.0
			inst.alarm[10] = -1.0
		GM.other = _other150
	if GM.instance_exists(A.obj_grinder):
		var _with_target153 = A.obj_grinder
		var _other152: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target153):
			inst.image_speed = 0.45
			inst.hspeed = 0.0
		GM.other = _other152
	if GM.instance_exists(A.obj_banzaibill):
		var _with_target155 = A.obj_banzaibill
		var _other154: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target155):
			inst.alarm[10] = 1.0
		GM.other = _other154
	if GM.instance_exists(A.obj_bobomb_ready):
		var _with_target157 = A.obj_bobomb_ready
		var _other156: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target157):
			inst.image_speed = 0.2
			inst.alarm[1] = 360.0
			inst.alarm[10] = 1.0
		GM.other = _other156
	if GM.instance_exists(A.obj_galoomba):
		var _with_target159 = A.obj_galoomba
		var _other158: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target159):
			inst.alarm[0] = 120.0
		GM.other = _other158
	if GM.instance_exists(A.obj_jumppiranha):
		var _with_target161 = A.obj_jumppiranha
		var _other160: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target161):
			if G.apariencia == 1.0:
				inst.image_speed = 0.125
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_jumppiranha_falll
				inst.image_speed = 0.55
				inst.alarm[0] = 180.0
			inst.alarm[10] = -1.0
			inst.hspeed = 0.0
		GM.other = _other160
	if GM.instance_exists(A.obj_thwomp):
		var _with_target163 = A.obj_thwomp
		var _other162: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target163):
			inst.image_speed = 0.0
		GM.other = _other162
	if GM.instance_exists(A.obj_bullebill_base):
		var _with_target165 = A.obj_bullebill_base
		var _other164: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target165):
			inst.alarm[0] = 180.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
			inst.hspeed = 0.0
		GM.other = _other164
	if GM.instance_exists(A.obj_hammerbro):
		var _with_target167 = A.obj_hammerbro
		var _other166: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target167):
			inst.image_speed = 0.125
			inst.alarm[0] = 50.0
			inst.alarm[1] = 152.0
			inst.alarm[2] = 17.0
		GM.other = _other166
	if GM.instance_exists(A.obj_firebro):
		var _with_target169 = A.obj_firebro
		var _other168: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target169):
			inst.image_speed = 0.125
			inst.alarm[0] = 50.0
			inst.alarm[1] = 152.0
			inst.alarm[2] = 17.0
		GM.other = _other168
	if GM.instance_exists(A.obj_cap):
		var _with_target171 = A.obj_cap
		var _other170: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target171):
			inst.alarm[0] = 1.0
		GM.other = _other170
	if GM.instance_exists(A.obj_muncher):
		var _with_target173 = A.obj_muncher
		var _other172: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target173):
			inst.image_speed = 0.15
		GM.other = _other172
	if GM.instance_exists(A.obj_fireflower):
		var _with_target175 = A.obj_fireflower
		var _other174: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target175):
			inst.image_speed = 0.15
		GM.other = _other174
	if GM.instance_exists(A.obj_pinchos):
		var _with_target177 = A.obj_pinchos
		var _other176: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target177):
			inst.image_speed = 0.1
		GM.other = _other176
	if GM.instance_exists(A.obj_holdparent):
		var _with_target179 = A.obj_holdparent
		var _other178: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target179):
			inst.image_speed = 0.0
		GM.other = _other178
	if GM.instance_exists(A.obj_block):
		var _with_target181 = A.obj_block
		var _other180: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target181):
			inst.image_speed = 0.15
		GM.other = _other180
	if GM.instance_exists(A.obj_flipblock):
		if G.apariencia == 1.0:
			var _with_target183 = A.obj_flipblock
			var _other182: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target183):
				inst.image_speed = 0.15
			GM.other = _other182
	if GM.instance_exists(A.obj_noteblock):
		var _with_target185 = A.obj_noteblock
		var _other184: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target185):
			inst.image_speed = 0.15
		GM.other = _other184
	if GM.instance_exists(A.obj_coin):
		var _with_target187 = A.obj_coin
		var _other186: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target187):
			inst.image_speed = 0.15
		GM.other = _other186
	if GM.instance_exists(A.obj_coin10):
		var _with_target189 = A.obj_coin10
		var _other188: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target189):
			inst.image_speed = 0.15
		GM.other = _other188
	if GM.instance_exists(A.obj_mushroom):
		var _with_target191 = A.obj_mushroom
		var _other190: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target191):
			inst.hspeed = 1.1
		GM.other = _other190
	if GM.instance_exists(A.obj_1up):
		var _with_target193 = A.obj_1up
		var _other192: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target193):
			inst.alarm[10] = 2.0
		GM.other = _other192
	if GM.instance_exists(A.obj_star):
		var _with_target195 = A.obj_star
		var _other194: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target195):
			inst.alarm[10] = 1.0
			inst.image_speed = 0.3
		GM.other = _other194
	if GM.instance_exists(A.obj_drybones):
		var _with_target197 = A.obj_drybones
		var _other196: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target197):
			inst.alarm[0] = 180.0
		GM.other = _other196
	if GM.instance_exists(A.obj_clown):
		var _with_target199 = A.obj_clown
		var _other198: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target199):
			inst.image_speed = 0.4
			inst.alarm[0] = 120.0
		GM.other = _other198
	if GM.instance_exists(A.obj_bumper):
		var _with_target201 = A.obj_bumper
		var _other200: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target201):
			inst.alarm[0] = 120.0
		GM.other = _other200
	if GM.instance_exists(A.obj_pswitch):
		var _with_target203 = A.obj_pswitch
		var _other202: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target203):
			inst.image_speed = 0.15
		GM.other = _other202
	if GM.instance_exists(A.obj_block_pow_hold):
		var _with_target205 = A.obj_block_pow_hold
		var _other204: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target205):
			inst.image_speed = 0.15
		GM.other = _other204
	if GM.instance_exists(A.obj_onoffblock):
		var _with_target207 = A.obj_onoffblock
		var _other206: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target207):
			inst.image_speed = 0.09
		GM.other = _other206
	if GM.instance_exists(A.obj_checkpoint):
		if G.apariencia == 2.0:
			var _with_target209 = A.obj_checkpoint
			var _other208: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target209):
				inst.image_speed = 0.15
			GM.other = _other208
	if GM.instance_exists(A.obj_goalcard):
		var _with_target211 = A.obj_goalcard
		var _other210: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target211):
			inst.alarm[0] = 10.0
		GM.other = _other210
	if GM.instance_exists(A.obj_goalgate_tape):
		var _with_target213 = A.obj_goalgate_tape
		var _other212: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target213):
			inst.instance_destroy()
		GM.other = _other212
		GM.instance_create((GM.instance_find(A.obj_goalgate, 0).x + 8.0), (GM.instance_find(A.obj_goalgate, 0).y + 8.0), A.obj_goalgate_tape)
	var _with_target215 = A.obj_creator_jugar_editar
	var _other214: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target215):
		inst.alarm[0] = 5.0
	GM.other = _other214


# from objects/obj_editormanager/Other_13.gml
func _user_3() -> void:
	GM.instance_activate_all()
	if GM.instance_exists(A.obj_physicsparent):
		var _with_target217 = A.obj_physicsparent
		var _other216: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target217):
			if inst.object_index != A.obj_player_goal_smw and inst.object_index != A.obj_player_goal_smb1:
				inst.instance_destroy()
		GM.other = _other216
	var _with_target219 = A.obj_invincibility
	var _other218: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target219):
		inst.instance_destroy()
	GM.other = _other218
	var _with_target221 = A.obj_powerupsprout
	var _other220: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target221):
		inst.instance_destroy()
	GM.other = _other220
	var _with_target223 = A.obj_foo_fog
	var _other222: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target223):
		inst.instance_destroy()
	GM.other = _other222
	var _with_target225 = A.obj_ninji
	var _other224: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target225):
		inst.instance_destroy()
	GM.other = _other224
	var _with_target227 = A.obj_cooligan
	var _other226: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target227):
		inst.instance_destroy()
	GM.other = _other226
	var _with_target229 = A.obj_NSMBU_ninji
	var _other228: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target229):
		inst.instance_destroy()
	GM.other = _other228
	var _with_target231 = A.obj_link_arrow
	var _other230: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target231):
		inst.instance_destroy()
	GM.other = _other230
	var _with_target233 = A.obj_bouncycloud
	var _other232: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target233):
		inst.instance_destroy()
	GM.other = _other232
	var _with_target235 = A.obj_cloud_lakitu
	var _other234: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target235):
		inst.instance_destroy()
	GM.other = _other234
	var _with_target237 = A.obj_doormario
	var _other236: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target237):
		inst.instance_destroy()
	GM.other = _other236
	var _with_target239 = A.obj_doormario_exit
	var _other238: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target239):
		inst.instance_destroy()
	GM.other = _other238
	var _with_target241 = A.obj_player_warp
	var _other240: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target241):
		inst.instance_destroy()
	GM.other = _other240
	var _with_target243 = A.obj_boomerang
	var _other242: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target243):
		inst.instance_destroy()
	GM.other = _other242
	var _with_target245 = A.obj_claw
	var _other244: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target245):
		inst.instance_destroy()
	GM.other = _other244
	var _with_target247 = A.obj_efecto_sonido
	var _other246: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target247):
		inst.instance_destroy()
	GM.other = _other246
	var _with_target249 = A.obj_efecto_musica
	var _other248: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target249):
		inst.instance_destroy()
	GM.other = _other248
	var _with_target251 = A.obj_efecto_musica_bonus
	var _other250: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target251):
		inst.instance_destroy()
	GM.other = _other250
	var _with_target253 = A.obj_bowser_fire_down
	var _other252: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target253):
		inst.instance_destroy()
	GM.other = _other252
	var _with_target255 = A.obj_soplete_global
	var _other254: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target255):
		inst.instance_destroy()
	GM.other = _other254
	var _with_target257 = A.obj_soplete_invert_global
	var _other256: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target257):
		inst.instance_destroy()
	GM.other = _other256
	var _with_target259 = A.obj_bowser_dead
	var _other258: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target259):
		inst.instance_destroy()
	GM.other = _other258
	var _with_target261 = A.obj_pipebase
	var _other260: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target261):
		inst.instance_destroy()
	GM.other = _other260
	var _with_target263 = A.obj_frozenmario
	var _other262: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target263):
		inst.instance_destroy()
	GM.other = _other262
	if GM.instance_exists(A.obj_firebar):
		var _with_target265 = A.obj_firebar
		var _other264: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target265):
			inst.instance_destroy()
		GM.other = _other264
	if GM.instance_exists(A.obj_shard):
		var _with_target267 = A.obj_shard
		var _other266: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target267):
			inst.instance_destroy()
		GM.other = _other266
	if GM.instance_exists(A.obj_flipblock_anim):
		var _with_target269 = A.obj_flipblock_anim
		var _other268: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target269):
			inst.instance_destroy()
		GM.other = _other268
	if GM.instance_exists(A.obj_soplete):
		var _with_target271 = A.obj_soplete
		var _other270: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target271):
			inst.instance_destroy()
		GM.other = _other270
	if GM.instance_exists(A.obj_cap_mario):
		var _with_target273 = A.obj_cap_mario
		var _other272: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target273):
			inst.instance_destroy()
		GM.other = _other272
	var _with_target275 = A.obj_helmet
	var _other274: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target275):
		inst.instance_destroy()
	GM.other = _other274
	var _with_target277 = A.obj_brickhelmet
	var _other276: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target277):
		inst.instance_destroy()
	GM.other = _other276
	var _with_target279 = A.obj_skewer
	var _other278: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target279):
		inst.instance_destroy()
	GM.other = _other278
	var _with_target281 = A.obj_skewertrunk
	var _other280: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target281):
		inst.instance_destroy()
	GM.other = _other280
	if GM.instance_exists(A.obj_parent_sound_o):
		var _with_target283 = A.obj_parent_sound_o
		var _other282: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target283):
			inst.instance_destroy()
		GM.other = _other282
	if GM.instance_exists(A.obj_curtainin):
		var _with_target285 = A.obj_curtainin
		var _other284: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target285):
			inst.instance_destroy()
		GM.other = _other284
	if GM.instance_exists(A.obj_modelsizable):
		var _with_target287 = A.obj_modelsizable
		var _other286: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target287):
			inst.instance_destroy()
		GM.other = _other286
	if GM.instance_exists(A.obj_alert_condicion):
		var _with_target289 = A.obj_alert_condicion
		var _other288: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target289):
			inst.instance_destroy()
		GM.other = _other288
	if GM.instance_exists(A.obj_lava_lift):
		var _with_target291 = A.obj_lava_lift
		var _other290: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target291):
			inst.instance_destroy()
		GM.other = _other290
	if GM.instance_exists(A.obj_timeup):
		var _with_target293 = A.obj_timeup
		var _other292: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target293):
			inst.instance_destroy()
		GM.other = _other292
	if GM.instance_exists(A.obj_enemy_dead):
		var _with_target295 = A.obj_enemy_dead
		var _other294: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target295):
			inst.instance_destroy()
		GM.other = _other294
	if GM.instance_exists(A.obj_big_plant_dead):
		var _with_target297 = A.obj_big_plant_dead
		var _other296: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target297):
			inst.instance_destroy()
		GM.other = _other296
	if GM.instance_exists(A.obj_enemy_dead_castle):
		var _with_target299 = A.obj_enemy_dead_castle
		var _other298: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target299):
			inst.instance_destroy()
		GM.other = _other298
	if GM.instance_exists(A.obj_smoke):
		var _with_target301 = A.obj_smoke
		var _other300: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target301):
			inst.instance_destroy()
		GM.other = _other300
	if GM.instance_exists(A.obj_bubble):
		var _with_target303 = A.obj_bubble
		var _other302: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target303):
			inst.instance_destroy()
		GM.other = _other302
	if GM.instance_exists(A.obj_wings_dead):
		var _with_target305 = A.obj_wings_dead
		var _other304: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target305):
			inst.instance_destroy()
		GM.other = _other304
	if GM.instance_exists(A.obj_espina):
		var _with_target307 = A.obj_espina
		var _other306: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target307):
			inst.instance_destroy()
		GM.other = _other306
	if GM.instance_exists(A.obj_score):
		var _with_target309 = A.obj_score
		var _other308: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target309):
			inst.instance_destroy()
		GM.other = _other308
	if GM.instance_exists(A.obj_superball):
		var _with_target311 = A.obj_superball
		var _other310: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target311):
			inst.instance_destroy()
		GM.other = _other310
	if GM.instance_exists(A.obj_superball_trail):
		var _with_target313 = A.obj_superball_trail
		var _other312: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target313):
			inst.instance_destroy()
		GM.other = _other312
	if GM.instance_exists(A.obj_shell_trail):
		var _with_target315 = A.obj_shell_trail
		var _other314: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target315):
			inst.instance_destroy()
		GM.other = _other314
	if GM.instance_exists(A.obj_modelbgo):
		var _with_target317 = A.obj_modelbgo
		var _other316: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target317):
			inst.instance_destroy()
		GM.other = _other316
	if GM.instance_exists(A.obj_modelsolid):
		var _with_target319 = A.obj_modelsolid
		var _other318: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target319):
			inst.instance_destroy()
		GM.other = _other318
	if GM.instance_exists(A.obj_slopeparent):
		var _with_target321 = A.obj_slopeparent
		var _other320: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target321):
			inst.instance_destroy()
		GM.other = _other320
	if GM.instance_exists(A.obj_onewaygate_right):
		var _with_target323 = A.obj_onewaygate_right
		var _other322: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target323):
			inst.instance_destroy()
		GM.other = _other322
	if GM.instance_exists(A.obj_onewaygate_left):
		var _with_target325 = A.obj_onewaygate_left
		var _other324: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target325):
			inst.instance_destroy()
		GM.other = _other324
	if GM.instance_exists(A.obj_onewaygate_top):
		var _with_target327 = A.obj_onewaygate_top
		var _other326: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target327):
			inst.instance_destroy()
		GM.other = _other326
	if GM.instance_exists(A.obj_onewaygate_bottom):
		var _with_target329 = A.obj_onewaygate_bottom
		var _other328: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target329):
			inst.instance_destroy()
		GM.other = _other328
	if GM.instance_exists(A.obj_beanstalk):
		var _with_target331 = A.obj_beanstalk
		var _other330: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target331):
			inst.instance_destroy()
		GM.other = _other330
	if GM.instance_exists(A.obj_vine):
		var _with_target333 = A.obj_vine
		var _other332: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target333):
			inst.instance_destroy()
		GM.other = _other332
	if GM.instance_exists(A.obj_vine_green):
		var _with_target335 = A.obj_vine_green
		var _other334: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target335):
			inst.instance_destroy()
		GM.other = _other334
	if GM.instance_exists(A.obj_pblock):
		var _with_target337 = A.obj_pblock
		var _other336: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target337):
			inst.instance_destroy()
		GM.other = _other336
	if GM.instance_exists(A.obj_icecoin):
		var _with_target339 = A.obj_icecoin
		var _other338: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target339):
			inst.instance_destroy()
		GM.other = _other338
	if GM.instance_exists(A.obj_bowser_fire):
		var _with_target341 = A.obj_bowser_fire
		var _other340: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target341):
			inst.instance_destroy()
		GM.other = _other340
	if GM.instance_exists(A.obj_pink_coin):
		var _with_target343 = A.obj_pink_coin
		var _other342: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target343):
			inst.instance_destroy()
		GM.other = _other342
	if GM.instance_exists(A.obj_key):
		var _with_target345 = A.obj_key
		var _other344: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target345):
			inst.instance_destroy()
		GM.other = _other344
	if GM.instance_exists(A.obj_key_appear):
		var _with_target347 = A.obj_key_appear
		var _other346: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target347):
			inst.instance_destroy()
		GM.other = _other346
	if GM.instance_exists(A.obj_key_fallow):
		var _with_target349 = A.obj_key_fallow
		var _other348: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target349):
			inst.instance_destroy()
		GM.other = _other348
	if GM.instance_exists(A.obj_icicle):
		var _with_target351 = A.obj_icicle
		var _other350: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target351):
			inst.instance_destroy()
		GM.other = _other350
	if GM.instance_exists(A.obj_tuberia):
		var _with_target353 = A.obj_tuberia
		var _other352: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target353):
			inst.instance_destroy()
		GM.other = _other352
	if GM.instance_exists(A.obj_enemyparent_lava):
		var _with_target355 = A.obj_enemyparent_lava
		var _other354: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target355):
			inst.instance_destroy()
		GM.other = _other354
	if GM.instance_exists(A.obj_kuriboshoe):
		var _with_target357 = A.obj_kuriboshoe
		var _other356: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target357):
			inst.instance_destroy()
		GM.other = _other356
	if GM.instance_exists(A.obj_torbellino):
		var _with_target359 = A.obj_torbellino
		var _other358: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target359):
			inst.instance_destroy()
		GM.other = _other358
	if GM.instance_exists(A.obj_egg_hatch):
		var _with_target361 = A.obj_egg_hatch
		var _other360: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target361):
			inst.instance_destroy()
		GM.other = _other360
	if GM.instance_exists(A.obj_yoshi2):
		var _with_target363 = A.obj_yoshi2
		var _other362: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target363):
			inst.instance_destroy()
		GM.other = _other362
	if GM.instance_exists(A.obj_plantfire):
		var _with_target365 = A.obj_plantfire
		var _other364: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target365):
			inst.instance_destroy()
		GM.other = _other364
	if GM.instance_exists(A.obj_bumper):
		var _with_target367 = A.obj_bumper
		var _other366: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target367):
			inst.instance_destroy()
		GM.other = _other366
	if GM.instance_exists(A.obj_door):
		var _with_target369 = A.obj_door
		var _other368: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target369):
			inst.instance_destroy()
		GM.other = _other368
	if GM.instance_exists(A.obj_door_exit):
		var _with_target371 = A.obj_door_exit
		var _other370: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target371):
			inst.instance_destroy()
		GM.other = _other370
	if GM.instance_exists(A.obj_door_switch):
		var _with_target373 = A.obj_door_switch
		var _other372: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target373):
			inst.instance_destroy()
		GM.other = _other372
	if GM.instance_exists(A.obj_door_switch_exit):
		var _with_target375 = A.obj_door_switch_exit
		var _other374: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target375):
			inst.instance_destroy()
		GM.other = _other374
	if GM.instance_exists(A.obj_door_lock):
		var _with_target377 = A.obj_door_lock
		var _other376: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target377):
			inst.instance_destroy()
		GM.other = _other376
	if GM.instance_exists(A.obj_door_lock_exit):
		var _with_target379 = A.obj_door_lock_exit
		var _other378: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target379):
			inst.instance_destroy()
		GM.other = _other378
	if GM.instance_exists(A.obj_wrench):
		var _with_target381 = A.obj_wrench
		var _other380: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target381):
			inst.instance_destroy()
		GM.other = _other380
	if GM.instance_exists(A.obj_magic):
		var _with_target383 = A.obj_magic
		var _other382: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target383):
			inst.instance_destroy()
		GM.other = _other382
	if GM.instance_exists(A.obj_brohammer):
		var _with_target385 = A.obj_brohammer
		var _other384: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target385):
			inst.instance_destroy()
		GM.other = _other384
	if GM.instance_exists(A.obj_brohammer_yoshi):
		var _with_target387 = A.obj_brohammer_yoshi
		var _other386: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target387):
			inst.instance_destroy()
		GM.other = _other386
	if GM.instance_exists(A.obj_onoffplatform):
		var _with_target389 = A.obj_onoffplatform
		var _other388: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target389):
			inst.instance_destroy()
		GM.other = _other388
	if GM.instance_exists(A.obj_onoffplatform_blue):
		var _with_target391 = A.obj_onoffplatform_blue
		var _other390: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target391):
			inst.instance_destroy()
		GM.other = _other390
	if GM.instance_exists(A.obj_donut):
		var _with_target393 = A.obj_donut
		var _other392: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target393):
			inst.instance_destroy()
		GM.other = _other392
	if GM.instance_exists(A.obj_block_hidden):
		var _with_target395 = A.obj_block_hidden
		var _other394: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target395):
			inst.instance_destroy()
		GM.other = _other394
	if GM.instance_exists(A.obj_blockparent):
		var _with_target397 = A.obj_blockparent
		var _other396: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target397):
			inst.instance_destroy()
		GM.other = _other396
	if GM.instance_exists(A.obj_plataforma):
		var _with_target399 = A.obj_plataforma
		var _other398: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target399):
			inst.instance_destroy()
		GM.other = _other398
	if GM.instance_exists(A.obj_plataforma_blue):
		var _with_target401 = A.obj_plataforma_blue
		var _other400: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target401):
			inst.instance_destroy()
		GM.other = _other400
	if GM.instance_exists(A.obj_block_rock):
		var _with_target403 = A.obj_block_rock
		var _other402: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target403):
			inst.instance_destroy()
		GM.other = _other402
	if GM.instance_exists(A.obj_block_ice):
		var _with_target405 = A.obj_block_ice
		var _other404: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target405):
			inst.instance_destroy()
		GM.other = _other404
	if GM.instance_exists(A.obj_checkpoint):
		var _with_target407 = A.obj_checkpoint
		var _other406: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target407):
			inst.instance_destroy()
		GM.other = _other406
	if GM.instance_exists(A.obj_nube):
		var _with_target409 = A.obj_nube
		var _other408: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target409):
			inst.instance_destroy()
		GM.other = _other408
	if GM.instance_exists(A.obj_pinchos):
		var _with_target411 = A.obj_pinchos
		var _other410: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target411):
			inst.instance_destroy()
		GM.other = _other410
	if GM.instance_exists(A.obj_coin):
		var _with_target413 = A.obj_coin
		var _other412: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target413):
			inst.instance_destroy()
		GM.other = _other412
	if GM.instance_exists(A.obj_coin10):
		var _with_target415 = A.obj_coin10
		var _other414: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target415):
			inst.instance_destroy()
		GM.other = _other414
	if GM.instance_exists(A.obj_arrow):
		var _with_target417 = A.obj_arrow
		var _other416: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target417):
			inst.instance_destroy()
		GM.other = _other416
	if GM.instance_exists(A.obj_goalcard_get):
		var _with_target419 = A.obj_goalcard_get
		var _other418: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target419):
			inst.instance_destroy()
		GM.other = _other418
	if GM.instance_exists(A.obj_cinta_parent):
		var _with_target421 = A.obj_cinta_parent
		var _other420: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target421):
			inst.instance_destroy()
		GM.other = _other420
	var _with_target423 = A.obj_creator_jugar_editar
	var _other422: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target423):
		inst.alarm[0] = 5.0
	GM.other = _other422


# from objects/obj_editormanager/Draw_0.gml
func _gm_draw() -> void:
	var offsetx
	if GM.instance_exists(A.obj_erase):
		if GM.instance_find(A.obj_erase, 0).active == 1.0 and zoom == 0.0:
			GM.draw_sprite(A.spr_bg_goma_de_borrar, anim_goma, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
	GM.draw_sprite_ext(A.spr_panel_right, 0.0, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 35.0) + GM.instance_find(A.obj_cursor, 0).anim_right), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_banner, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), (GM.camera_get_view_y(GM.view_get_camera(0)) - GM.instance_find(A.obj_cursor, 0).anim_top), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if GM.instance_exists(A.obj_erase) and GM.instance_find(A.obj_erase, 0).active == 1.0 and zoom == 0.0:
		if G.idioma == 1.0:
			offsetx = GM.string_width(Scr.scr_language(self, 156.0))
		elif G.idioma == 2.0:
			offsetx = (GM.string_width(Scr.scr_language(self, 156.0)) - 23.0)
		elif G.idioma == 3.0:
			offsetx = 16.0
		elif G.idioma == 4.0:
			offsetx = (GM.string_width(Scr.scr_language(self, 156.0)) - 12.0)
		else:
			offsetx = 0.0
		GM.draw_sprite(A.spr_minitabs_en, 3.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 60.0) - GM.instance_find(A.obj_cursor, 0).anim_left), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 34.0) - GM.instance_find(A.obj_cursor, 0).anim_top))
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(GM.c_white)
		GM.draw_set_halign(GM.fa_left)
		GM.draw_text(((GM.camera_get_view_x(GM.view_get_camera(0)) + 27.0) + GM.sprite_get_width(A.spr_minitabs_en) / 2.0 + offsetx - GM.instance_find(A.obj_cursor, 0).anim_left), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 33.0) - GM.instance_find(A.obj_cursor, 0).anim_top), Scr.scr_language(self, 156.0))
	GM.draw_set_halign(GM.fa_left)
