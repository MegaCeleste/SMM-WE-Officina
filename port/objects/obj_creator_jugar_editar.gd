extends "res://objects/obj_parent_layout.gd"

var rot1: float = 0.0
var rot2: float = 0.0
var moment: float = 0.0
var contador: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0
var anim2: float = 0.0
var music_editor = null


# from objects/obj_creator_jugar_editar/Create_0.gml
func _create() -> void:
	gravity = 0.0
	speed = 0.0
	image_speed = 0.0
	image_index = G.idioma
	rot1 = 0.0
	rot2 = 0.0
	moment = 0.0
	contador = 0.0
	effect_hover = 0.0
	anim = 0.0
	anim2 = 0.0
	match float(G.apariencia):
		0.0:
			music_editor = 20.0
		1.0:
			music_editor = 61.0
		2.0:
			music_editor = 154.0
		3.0:
			music_editor = 390.0


# from objects/obj_creator_jugar_editar/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_cursor):
		x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + 4.0) - GM.instance_find(A.obj_cursor, 0).anim_creator)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0)


# from objects/obj_creator_jugar_editar/Alarm_0.gml
func _alarm_0() -> void:
	if rot2 >= 20.0:
		alarm[8] = 1.0
		alarm[0] = -1.0
	else:
		rot1 -= 5.0
		rot2 += 5.0
		alarm[0] = 1.0
	var _with_target2 = A.obj_mario_transform2
	var _other1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target2):
		inst.instance_destroy()
	GM.other = _other1


# from objects/obj_creator_jugar_editar/Alarm_1.gml
func _alarm_1() -> void:
	var _with_target4 = A.obj_editormanager
	var _other3: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target4):
		inst.event_user(3)
	GM.other = _other3


# from objects/obj_creator_jugar_editar/Alarm_2.gml
func _alarm_2() -> void:
	var _with_target6 = A.obj_editormanager
	var _other5: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target6):
		inst.event_user(2)
	GM.other = _other5


# from objects/obj_creator_jugar_editar/Alarm_3.gml
func _alarm_3() -> void:
	if GM.instance_exists(A.obj_ground):
		var _with_target8 = A.obj_ground
		var _other7: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target8):
			inst.ready_v = 1.0
		GM.other = _other7
	if GM.instance_exists(A.obj_slopes):
		var _with_target10 = A.obj_slopes
		var _other9: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target10):
			inst.ready_v = 1.0
		GM.other = _other9


# from objects/obj_creator_jugar_editar/Alarm_4.gml
func _alarm_4() -> void:
	for _obj_write11 in GM.with_list(A.obj_editormanager):
		_obj_write11.visible = false
	for _obj_write12 in GM.with_list(A.obj_expand_panels):
		_obj_write12.visible = false
	for _obj_write13 in GM.with_list(A.obj_expand_panels_left):
		_obj_write13.visible = false
	if GM.instance_exists(A.obj_panel_left):
		for _obj_write15 in GM.with_list(A.obj_panel_left):
			_obj_write15.visible = false
	sprite_index = A.spr_creator_create
	var _with_target17 = A.obj_cursor
	var _other16: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target17):
		inst.cont_panel_creator = 2.0
	GM.other = _other16


# from objects/obj_creator_jugar_editar/Alarm_5.gml
func _alarm_5() -> void:
	sprite_index = A.spr_creator_play
	var _with_target19 = A.obj_cursor
	var _other18: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target19):
		inst.cont_panel_creator = 2.0
	GM.other = _other18


# from objects/obj_creator_jugar_editar/Alarm_6.gml
func _alarm_6() -> void:
	if not GM.instance_exists(A.obj_mario_transform2):
		_user_3()
	else:
		alarm[6] = 2.0


# from objects/obj_creator_jugar_editar/Alarm_7.gml
func _alarm_7() -> void:
	if not GM.instance_exists(A.obj_mario_transform2):
		_user_3()
		alarm[1] = 2.0
	else:
		alarm[7] = 2.0


# from objects/obj_creator_jugar_editar/Alarm_8.gml
func _alarm_8() -> void:
	if rot2 <= 0.0:
		alarm[8] = -1.0
	else:
		rot1 += 5.0
		rot2 -= 5.0
		alarm[8] = 1.0


# from objects/obj_creator_jugar_editar/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_creator_jugar_editar/Other_10.gml
func _user_0() -> void:
	image_speed = 0.31
	var _with_target21 = A.obj_levelmanager
	var _other20: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target21):
		inst.nopause = 1.0
	GM.other = _other20
	alarm[2] = 30.0


# from objects/obj_creator_jugar_editar/Other_11.gml
func _user_1() -> void:
	image_speed = 0.31
	for _obj_write22 in GM.with_list(A.obj_levelmanager):
		_obj_write22.nopause = 1.0
	alarm[1] = 30.0


# from objects/obj_creator_jugar_editar/Other_12.gml
func _user_2() -> void:
	for _obj_write23 in GM.with_list(A.obj_erase):
		_obj_write23.active = 0.0
	for _obj_write24 in GM.with_list(A.obj_cursor):
		_obj_write24.image_index = 0.0
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		G.instance_deactivate = 0.0
		GM.instance_activate_object(A.obj_parent_save)
		alarm[6] = 2.0
	elif GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		G.instance_deactivate = 0.0
		if GM.instance_exists(A.obj_goalgate):
			var _with_target26 = A.obj_goalgate
			var _other25: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target26):
				inst.alarm[1] = -1.0
			GM.other = _other25
		GM.audio_stop_sound(A.bgm_smwclear)
		alarm[7] = 2.0
	alarm[0] = 1.0


# from objects/obj_creator_jugar_editar/Other_13.gml
func _user_3() -> void:
	var element_obj  # 局部变量提升（GML 的 var 是函数作用域）
	var mario_editor  # 局部变量提升（GML 的 var 是函数作用域）
	var marioU
	var no_instances_above_camera
	G.instance_deactivate = 0.0
	if G.apariencia == 3.0:
		marioU = A.obj_marioU
	else:
		marioU = A.obj_mario
	if moment == 0.0:
		no_instances_above_camera = true
		if GM.instance_exists(A.obj_parent_resource):
			var _with_target28 = A.obj_parent_resource
			var _other27: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target28):
				# Check for items and enemies above the camera
				if inst.y < GM.instance_find(A.obj_levelmanager, 0).cam_top - 8.0:
					no_instances_above_camera = false
					break
			GM.other = _other27
			if no_instances_above_camera:
				var _with_target30 = A.obj_levelmanager
				var _other29: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target30):
					inst.camlock = 1.0
				GM.other = _other29
			else:
				var _with_target32 = A.obj_levelmanager
				var _other31: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target32):
					inst.camlock = 0.0
				GM.other = _other31
		if GM.instance_find(A.obj_ground2, 0).y < (GM.instance_find(A.obj_levelmanager, 0).cam_top - 8.0) or GM.instance_find(A.obj_ground3, 0).y < (GM.instance_find(A.obj_levelmanager, 0).cam_top - 8.0):
			var _with_target34 = A.obj_levelmanager
			var _other33: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target34):
				inst.camlock = 0.0
			GM.other = _other33
		Scr.scr_edit_to_play(self)
		if GM.instance_exists(A.obj_player_trail):
			var _with_target36 = A.obj_player_trail
			var _other35: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target36):
				inst.instance_destroy()
			GM.other = _other35
		match float(G.autoavance):
			1.0:
				var _with_target38 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.room_height - (GM.camera_get_view_height(GM.view_get_camera(0)) / 2.0)), A.obj_autoscroll)
				var _other37: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target38):
					inst.velocidad = 0.6
				GM.other = _other37
			2.0:
				var _with_target40 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.room_height - (GM.camera_get_view_height(GM.view_get_camera(0)) / 2.0)), A.obj_autoscroll)
				var _other39: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target40):
					inst.velocidad = 1.0
				GM.other = _other39
			3.0:
				var _with_target42 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.room_height - (GM.camera_get_view_height(GM.view_get_camera(0)) / 2.0)), A.obj_autoscroll)
				var _other41: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target42):
					inst.velocidad = 1.5
				GM.other = _other41
		if G.condiciones == 1.0 and G.condiciones_type == 0.0:
			G.condiciones_clear = 1.0
			var _with_target44 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 43.0), A.obj_alert_condicion)
			var _other43: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target44):
				inst.start = 1.0
			GM.other = _other43
		if G.player_trail != 0.0:
			var _with_target46 = A.obj_editormanager
			var _other45: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target46):
				inst.alarm[1] = 2.0
			GM.other = _other45
		var _switch_value47 = G.bg_level
		var _switch_case48: int = -1
		if _switch_case48 < 0 and GM.veq(_switch_value47, "airship"):
			_switch_case48 = 0
		if _switch_case48 < 0 and GM.veq(_switch_value47, "sky"):
			_switch_case48 = 1
		while true:
			if _switch_case48 >= 0 and _switch_case48 <= 0:
				if G.apariencia == 3.0:
					if G.modo_noche == 1.0:
						Scr.__background_set(self, (int(11) << int(0)), 1.0, -0.1)
						Scr.__background_set(self, (int(11) << int(0)), 2.0, -0.2)
						Scr.__background_set(self, (int(11) << int(0)), 3.0, -0.3)
						Scr.__background_set(self, (int(11) << int(0)), 4.0, -0.4)
						Scr.__background_set(self, (int(11) << int(0)), 5.0, -0.5)
						Scr.__background_set(self, (int(11) << int(0)), 7.0, -0.6)
				elif G.apariencia != 3.0:
					if G.modo_noche == 0.0:
						Scr.__background_set(self, (int(11) << int(0)), 0.0, -0.3)
					else:
						Scr.__background_set(self, (int(11) << int(0)), 0.0, -1.0)
			if _switch_case48 >= 0 and _switch_case48 <= 1:
				if G.apariencia == 3.0:
					Scr.__background_set(self, Scr.e__BG.HSpeed, 1.0, -0.1)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 2.0, -0.2)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 3.0, -0.3)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 4.0, -0.4)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 5.0, -0.5)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 7.0, -0.6)
				elif G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.HSpeed, 0.0, -0.2)
			break
		if G.bg_level == "airship" and G.modo_noche == 1.0 and G.apariencia != 0.0:
			GM.instance_create(0.0, 0.0, A.obj_rainmaker)
		if G.bg_level == "snow":
			GM.instance_create(0.0, 0.0, A.obj_snowmaker)
		if G.bg_level == "fall":
			GM.instance_create(0.0, 0.0, A.obj_leafmaker)
		if G.bg_level == "castle" and G.apariencia == 3.0:
			GM.instance_create(0.0, 0.0, A.obj_firemaker)
		for _obj_write49 in GM.with_list(A.obj_levelmanager):
			_obj_write49.editor = 0.0
		_set_top_palette_visible(false)
		var _with_target51 = A.obj_cursor
		var _other50: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target51):
			inst.event_user(3)
		GM.other = _other50
		alarm[4] = 25.0
		if GM.instance_exists(A.obj_bg_selection):
			var _with_target53 = A.obj_bg_selection
			var _other52: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target53):
				inst.instance_destroy()
			GM.other = _other52
		if GM.instance_exists(A.obj_time):
			var _with_target55 = A.obj_time
			var _other54: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target55):
				inst.instance_destroy()
			GM.other = _other54
		if GM.instance_exists(A.obj_toast):
			var _with_target57 = A.obj_toast
			var _other56: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target57):
				inst.instance_destroy()
			GM.other = _other56
		GM.audio_play_sound(A.snd_play_start_create, 0.0, false)
		if G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_letsgo, 0.0, false)
		else:
			match float(G.jugador):
				0.0:
					GM.audio_play_sound(A.snd_letsgo, 0.0, false)
				1.0:
					GM.audio_play_sound(A.snd_letsgo_luigi, 0.0, false)
				2.0:
					GM.audio_play_sound(A.snd_letsgo_toad, 0.0, false)
				3.0:
					GM.audio_play_sound(A.snd_letsgo_toadette, 0.0, false)
		GM.audio_stop_sound(music_editor)
		GM.audio_stop_sound(A.snd_SMB_dead)
		GM.audio_stop_sound(A.snd_SMB3_dead)
		GM.audio_stop_sound(A.snd_dead)
		GM.audio_stop_sound(A.snd_NSMBU_dead)
		GM.audio_stop_sound(A.snd_NSMBU_dead_lava)
		GM.audio_stop_sound(A.snd_NSMBU_dead_veneno)
		G.pink_coins_total = GM.instance_number(A.obj_pink_coin)
		if G.pink_coins_total != 0.0:
			G.pink_coins_draw = 1.0
			var _with_target59 = A.obj_levelmanager
			var _other58: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target59):
				inst.pink_coins_draw = 1.0
			GM.other = _other58
		var _with_target61 = A.obj_levelmanager
		var _other60: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target61):
			G.timer = inst.leveltime
			if G.timer > 0.0 and G.timer < 101.0:
				inst.alarm[3] = 2.0
				inst.alarm[2] = 1.0
			else:
				inst.alarm[2] = 1.0
		GM.other = _other60
		match float(G.powerup):
			-50.0:
				var _with_target63 = A.obj_levelmanager
				var _other62: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target63):
					inst.mchange = 1.0
				GM.other = _other62
			-85.0:
				var _with_target65 = A.obj_levelmanager
				var _other64: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target65):
					inst.mchange = 4.0
				GM.other = _other64
			_:
				GM.audio_play_sound(GM.instance_find(A.obj_levelmanager, 0).levelmusic, 99.0, true)
		var mario_c = GM.instance_create((GM.instance_find(A.obj_mario_editor, 0).x + 8.0), (GM.instance_find(A.obj_mario_editor, 0).y - 16.0), A.obj_mario_temp)
		mario_c.direct = GM.instance_find(A.obj_mario_editor, 0).direct
		var _with_target67 = A.obj_mario_editor
		var _other66: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target67):
			if G.star_flash == 1.0:
				inst.event_user(1)
			inst.instance_destroy()
		GM.other = _other66
		if GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0:
			if GM.instance_exists(A.obj_card_block_sounds):
				var _with_target69 = A.obj_card_block_sounds
				var _other68: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target69):
					inst.event_user(2)
				GM.other = _other68
		moment = 1.0
		G.instance_deactivate = 1.0
	else:
		for _obj_write72 in GM.with_list(A.obj_levelmanager):
			_obj_write72.editor = 1.0
		G.n64_music = 0.0
		G.bonus_music = 0.0
		G.boss_music = 0.0
		G.ef_repeat = 0.0
		# DESACTIVARCONTROL
		Scr.scr_play_to_edit(self)
		Scr.scr_stop_effect_sounds(self)
		for _obj_write73 in GM.with_list(A.obj_editormanager):
			_obj_write73.visible = true
		for _obj_write74 in GM.with_list(A.obj_expand_panels):
			_obj_write74.visible = true
		for _obj_write75 in GM.with_list(A.obj_expand_panels_left):
			_obj_write75.visible = true
		_set_top_palette_visible(true)
		if GM.instance_exists(A.obj_panel_left):
			for _obj_write77 in GM.with_list(A.obj_panel_left):
				_obj_write77.visible = true
		if GM.instance_exists(A.obj_autoscroll):
			var _with_target79 = A.obj_autoscroll
			var _other78: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target79):
				inst.instance_destroy()
			GM.other = _other78
		if GM.instance_exists(A.obj_rainmaker):
			var _with_target81 = A.obj_rainmaker
			var _other80: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target81):
				inst.instance_destroy()
			GM.other = _other80
		Scr.__background_set(self, (int(11) << int(0)), 0.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 1.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 2.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 3.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 4.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 5.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 6.0, GM.c_black)
		Scr.__background_set(self, (int(11) << int(0)), 7.0, GM.c_black)
		var _with_target83 = A.obj_cursor
		var _other82: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target83):
			inst.event_user(4)
		GM.other = _other82
		alarm[5] = 10.0
		Scr.scr_reset_variables(self)
		GM.audio_play_sound(A.snd_play_start_create, 0.0, false)
		var _with_target85 = A.obj_persistent
		var _other84: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target85):
			inst.alarm[6] = -1.0
		GM.other = _other84
		var _with_target87 = A.obj_goalcard
		var _other86: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target87):
			inst.alarm[3] = -1.0
		GM.other = _other86
		var _with_target89 = A.obj_persistent
		var _other88: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target89):
			inst.alarm[6] = -1.0
		GM.other = _other88
		var _with_target91 = A.obj_levelmanager
		var _other90: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target91):
			GM.audio_stop_sound(inst.levelmusic)
			inst.levelmusic = inst.levelmusic_original
		GM.other = _other90
		GM.audio_stop_sound(A.snd_music_mario_land)
		if GM.instance_find(A.obj_levelmanager, 0).sound_effect != A.snd_SMB_music_ground:
			GM.audio_stop_sound(GM.instance_find(A.obj_levelmanager, 0).sound_effect)
			for _obj_write92 in GM.with_list(A.obj_levelmanager):
				_obj_write92.sound_effect = 0.0
		GM.audio_play_sound(music_editor, 99.0, true)
		G.powerup = 0.0
		var _with_target94 = A.obj_levelmanager
		var _other93: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target94):
			inst.lock_lock = 0.0
			G.timer = inst.leveltime
			inst.alarm[2] = -1.0
			inst.alarm[4] = -1.0
			inst.alarm[10] = 1.0
		GM.other = _other93
		if GM.instance_exists(marioU):
			element_obj = marioU
		elif GM.instance_exists(A.obj_deadmario):
			element_obj = A.obj_deadmario
		elif GM.instance_exists(A.obj_doormario):
			element_obj = A.obj_doormario
		elif GM.instance_exists(A.obj_doormario_exit):
			element_obj = A.obj_doormario_exit
		elif GM.instance_exists(A.obj_player_warp):
			element_obj = A.obj_player_warp
		elif GM.instance_exists(A.obj_player_goal_parent):
			element_obj = A.obj_player_goal_parent
		else:
			element_obj = GM.noone
		if GM.instance_exists(element_obj):
			if (GM.instance_find(int(element_obj), 0).y + 32.0) > GM.room_height:
				mario_editor = GM.instance_create((GM.instance_find(int(element_obj), 0).x - 8.0), (GM.room_height - 32.0), A.obj_mario_editor)
			elif (GM.instance_find(int(element_obj), 0).x + 8.0) > GM.room_width:
				mario_editor = GM.instance_create((GM.room_width - 16.0), (GM.instance_find(int(element_obj), 0).y + 16.0), A.obj_mario_editor)
			else:
				mario_editor = GM.instance_create((GM.instance_find(int(element_obj), 0).x - 8.0), (GM.instance_find(int(element_obj), 0).y + 16.0), A.obj_mario_editor)
			mario_editor.direct = GM.instance_find(int(element_obj), 0).direct
			var _with_target96 = element_obj
			var _other95: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target96):
				inst.instance_destroy()
			GM.other = _other95
		else:
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + (GM.camera_get_view_height(GM.view_get_camera(0)) / 2.0)), A.obj_mario_editor)
		if GM.instance_exists(A.obj_parent_save):
			var _with_target100 = A.obj_parent_save
			var _other99: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target100):
				inst.visible = true
			GM.other = _other99
		moment = 0.0
		G.instance_deactivate = 1.0


func _set_top_palette_visible(show_palette: bool) -> void:
	for object_id: int in [A.obj_card_item, A.obj_card_block_sounds, A.obj_expand, A.obj_expand_paneles_top]:
		for control: GMObject in GM.with_list(object_id):
			control.visible = show_palette


# from objects/obj_creator_jugar_editar/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_cursor):
		GM.draw_sprite_ext(A.spr_creator_part, 0.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 4.0) - GM.instance_find(A.obj_cursor, 0).anim_creator), (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0), 1.0, 1.0, rot1, GM.c_white, image_alpha)
		GM.draw_sprite_ext(sprite_index, image_index, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 4.0) - GM.instance_find(A.obj_cursor, 0).anim_creator), (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0), 1.0, 1.0, rot2, GM.c_white, image_alpha)
	if effect_hover == 1.0:
		anim2 += 0.3
		Scr.scr_anim_hover2(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 4.0) - GM.instance_find(A.obj_cursor, 0).anim_creator), (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0), anim2, 2.0)


# from objects/obj_creator_jugar_editar/Mouse_4.gml
func _mouse_4() -> void:
	if G.editor_activity == 1.0 and image_speed == 0.0 and GM.instance_exists(A.obj_cursor) and GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0 and GM.instance_find(A.obj_cursor, 0).cont_panel_creator == 0.0 and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_bg_selection)) and (not GM.instance_exists(A.obj_mario_transform2)) and GM.instance_find(A.obj_cursor, 0).move == 0.0:
		if G.play_lock == 0.0:
			_user_2()
		else:
			GM.audio_play_sound(A.snd_wrong, 0.0, false)


# from objects/obj_creator_jugar_editar/Mouse_10.gml
func _mouse_10() -> void:
	if sprite_index == A.spr_creator_play:
		effect_hover = 1.0


# from objects/obj_creator_jugar_editar/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
