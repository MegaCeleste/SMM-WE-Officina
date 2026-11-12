# 第 4 批移植，已核对。
extends "res://objects/obj_mario.gd"

var groundpount_cancelled: float = 0.0
var time_groundpount: float = 0.0
var smoke_cinta: float = 0.0
var crouch_temp: float = 0.0
var slide: float = 0.0
var walljump_ex: float = 0.0
var skid_nsmbu: float = 0.0
var idle_start: float = 0.0
var triple_number: float = 0.0
var steps_count: float = 0.0
var step_inter: float = 0.0
var polvo: float = 0.0
var flip: float = 0.0
var flip_count: float = 0.0
var helice_temp: float = 0.0
var helice_cont: float = 0.0
var color: Array = []
var jump_number = null


# from objects/obj_marioU/Create_0.gml
func _create() -> void:
	super._create()
	groundpount_cancelled = 0.0
	time_groundpount = 0.0
	smoke_cinta = 0.0
	direct_turn = 1.0
	crouch_temp = 0.0
	slide = 0.0
	jumpnow_temp = 0.0
	walljump_ex = 0.0
	isflashing = 0.0
	skid_nsmbu = 0.0
	idle_start = 0.0
	triple_jump = 0.0
	triple_count = 0.0
	triple_number = 33.0
	steps_count = 0.0
	step_inter = 0.0
	blend_star = GM.c_white
	flashAlpha = 1.0
	polvo = 0.0
	flip = 0.0
	flip_count = 0.0
	helice_temp = 0.0
	helice_cont = 0.0
	flag = 0.0
	disable_doublejump = 0.0
	if G.apariencia == 3.0:
		GM.aset(color, 0, GM.make_colour_rgb(255.0, 255.0, 72.0))
		GM.aset(color, 1, GM.make_colour_rgb(254.0, 138.0, 139.0))
		GM.aset(color, 2, GM.make_colour_rgb(102.0, 245.0, 157.0))
	else:
		GM.aset(color, 0, GM.make_colour_rgb(255.0, 255.0, 72.0))
		GM.aset(color, 1, GM.make_colour_rgb(254.0, 138.0, 139.0))
		GM.aset(color, 2, GM.make_colour_rgb(102.0, 245.0, 157.0))


# from objects/obj_marioU/Step_0.gml
func _step() -> void:
	if flashAlpha > 0.0:
		flashAlpha -= 0.03
	var pblock = collision_rectangle((bbox_right - 5.0), (bbox_top + 5.0), (bbox_left + 5.0), (bbox_bottom - 5.0), A.obj_enabledsolid, true, false)
	if pblock != null:
		speed = 0.0
		gravity = 0.0
		state = 0.0
		isduck = 1.0
		jumpnow = 0.0
		canjump = 0.0
	else:
		canjump = 1.0
	if (G.modo_noche == 1.0 and G.bg_level == "snow") or ((collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_ice, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_icecoin, false, false) != null) and G.powerup != -38.0):
		snow = 1.0
	else:
		snow = 0.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 5.0), bbox_right, (bbox_bottom + 5.0), A.obj_platform_parent, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 5.0), bbox_right, (bbox_bottom + 5.0), A.obj_block_pow_hold, false, false) != null) and state < 2.0:
		platform_m = 1.0
	else:
		platform_m = 0.0
	if walljump == 0.0 and GM.audio_is_playing(A.snd_NSMBU_desllizarse_walljump):
		GM.audio_stop_sound(A.snd_NSMBU_desllizarse_walljump)
	if boostme > 0.0:
		boostme -= 1.0
		if absf(hspeed) < hspeedmax:
			boostme = 0.0
	if vspeed >= 0.0:
		var solidtop = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var solidphy = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		var b_drybones = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false)
		if solidtop != null and bbox_bottom < (solidtop.yprevious + 5.0) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (solidtop.y - 1.0), A.obj_solid, true, false) == null):
			y = (solidtop.y - 32.0)
			vspeed = 0.0
			gravity = 0.0
			_user_15()
		if solidphy != null and bbox_bottom < (solidphy.yprevious + 5.0) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (solidphy.y - 1.0), A.obj_solid, true, false) == null):
			y = (solidphy.y - 32.0)
			vspeed = 0.0
			gravity = 0.0
			_user_15()
		if b_drybones != null and bbox_bottom < (b_drybones.yprevious + 5.0) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (b_drybones.y - 1.0), A.obj_solid, true, false) == null) and (GM.instance_exists(A.obj_kuribo_drybones) or (G.powerup == -38.0 and slide == 1.0)):
			y = (b_drybones.y - 32.0)
			vspeed = 0.0
			gravity = 0.0
			_user_15()
	if stuntime > 0.0:
		stuntime -= 1.0
		if stuntime == 0.0:
			groundpount = 0.0
			disablecontrols = 0.0
	if isswim == 0.0:
		match int(state):
			3:
				_user_4()
			_:
				_user_2()
	else:
		match int(state):
			3:
				_user_4()
			_:
				_user_3()
	if new_swim == 0.0 and GM.audio_is_playing(A.snd_NSMBU_swim2):
		GM.audio_stop_sound(A.snd_NSMBU_swim2)
	if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, true, false) != null:
		if hspeed > 0.0:
			hspeed = 0.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_solid, false, false) == null):
			x -= 1.0
		if collision_rectangle((bbox_left + 4.0), (bbox_top + 4.0), (bbox_right + 1.0), bbox_bottom, A.obj_pinchos, false, false) != null:
			_user_0()
	elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) != null:
		if hspeed < 0.0:
			hspeed = 0.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_solid, false, false) == null):
			x += 1.0
		if collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), (bbox_right - 4.0), bbox_bottom, A.obj_pinchos, false, false) != null:
			_user_0()
	if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null:
		if hspeed > 0.0:
			hspeed = 0.0
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_physicssolid, false, false) == null):
				x -= 1.0
		if collision_rectangle((bbox_left + 4.0), (bbox_top + 4.0), (bbox_right + 1.0), bbox_bottom, A.obj_muncher, false, false) != null:
			_user_0()
	elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null:
		if hspeed < 0.0:
			hspeed = 0.0
		if (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), (bbox_left + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_physicssolid, false, false) == null):
				x += 1.0
		if collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), (bbox_right - 4.0), bbox_bottom, A.obj_muncher, false, false) != null:
			_user_0()
	if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null:
		if hspeed > 0.0:
			hspeed = 0.0
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_bullebill_base, false, false) == null):
				x -= 1.0
	elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null:
		if hspeed < 0.0:
			hspeed = 0.0
		if (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_solidphy, false, false) == null):
				x += 1.0
	var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, true, false)
	var col_one_left = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, true, false)
	if col_one_right != null:
		if hspeed < 0.0:
			hspeed = 0.0
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o1
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_onewaygate_right, false, false) == null):
			x += 1.0
	elif col_one_left != null:
		if hspeed > 0.0:
			hspeed = 0.0
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_left, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_onewaygate_left, false, false) == null):
			x -= 1.0
	pow = collision_rectangle((bbox_left + 1.0), (bbox_top - 2.0), (bbox_right - 1.0), bbox_top, A.obj_block_pow_hold, true, false)
	if vspeed < 0.0 and pow != null and pow.get("held") == 0.0 and pow.get("inmune") == 0.0 and (pow.y + 8.0) < bbox_top:
		vspeed = 0.0
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(pow):
			inst.set("explode", 1.0)
			inst.event_user(6)
		GM.other = _o3
	pswitch = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_pswitch, true, false)
	if pswitch != null and pswitch.get("inmune") == 0.0 and pswitch.get("inup") == 1.0:
		var _o4: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(pswitch):
			inst.event_user(6)
		GM.other = _o4
	var one_2 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false)
	# If moving upwards
	if vspeed < 0.0 and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or (pswitch != null and pswitch.get("held") == 0.0 and (pswitch.y + 16.0) < bbox_top) or (one_2 != null and (bbox_top + 5.0) >= one_2.bbox_bottom)):
		# Prevent the player from getting stuck on a ceiling when jumping/climbing
		if state > 1.0 and canjump == 1.0:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null:
				y += 1.0
		vspeed = 0.0
		if helmet == 0.0 and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_bottom - 2.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_bottom - 2.0), A.obj_muncher, false, false) != null):
			_user_0()
		var col_one_bottom = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false)
		if col_one_bottom != null:
			var _o5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_bottom):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o5
		elif not GM.audio_is_playing(Scr.scr_snd_bump(self)):
			GM.audio_stop_sound(Scr.scr_jump(self))
			GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		var block_col = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_blockparent, false, false)
		var rock_parent = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_rockparent, true, false)
		if GM.instance_exists(A.obj_helmet_spiny) and rock_parent != null and rock_parent.vspeed == 0.0:
			for inst in GM.with_list(rock_parent):
				inst.alarm[0] = 1.0
		if (GM.instance_exists(A.obj_helmet_spiny) or G.powerup == -77.0) and block_col != null and block_col.vspeed == 0.0 and block_col.object_index != A.obj_onoffblock and block_col.object_index != A.obj_noteblock and block_col.object_index != A.obj_musicblock and block_col.object_index != A.obj_noteblock_s:
			for inst in GM.with_list(block_col):
				inst.alarm[2] = 1.0
		if block_col != null and block_col.vspeed == 0.0 and block_col.object_index == A.obj_flipblock and G.apariencia != 2.0 and (G.powerup != 0.0 or (G.powerup == 0.0 and GM.instance_exists(A.obj_helmet))):
			for inst in GM.with_list(block_col):
				inst.alarm[2] = 1.0
		elif block_col != null and block_col.object_index == A.obj_onoffblock and block_col.get("ready_v") == 0.0:
			var _o6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(block_col):
				inst.event_user(1)
			GM.other = _o6
		elif block_col != null:
			if block_col.get("ready_v") == 0.0:
				var _o7: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_col):
					if inst.object_index != A.obj_noteblock and inst.object_index != A.obj_musicblock:
						inst.set("expand", 1.0)
					inst.set("ready_v", 1.0)
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock or inst.object_index == A.obj_musicblock or inst.object_index == A.obj_noteblock_s:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o7
		# If penguin Mario is not swimming, and Mario is not climbing or wall climbing
		if noisy == 0.0 and state < 3.0 and vspeed < 0.0:
			# Stop variable jumping
			jumpnow = 2.0
			# Bump sound
			GM.audio_stop_sound(Scr.scr_snd_bump(self))
			GM.audio_stop_sound(Scr.scr_jump(self))
			GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
	if state < 3.0:
		if state != 2.0 and disablecontrols == 0.0:
			if G.powerup == -38.0 and isswim == 1.0:
				isduck = 0.0
			elif GM.keyboard_check(G.abajo) and (holding == 0.0 or holding == 3.0) and noisy == 0.0:
				if gravity == 0.0 and isduck == 0.0:
					GM.audio_stop_sound(A.snd_NSMBU_duck)
					GM.audio_play_sound(A.snd_NSMBU_duck, 0.0, false)
				isduck = 1.0
			elif (not GM.keyboard_check(G.abajo)) and (collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 12.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 16.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null) and G.powerup != 0.0 and isduck == 1.0:
				isduck = 1.0
			else:
				isduck = 0.0
		elif state == 2.0 and disablecontrols == 0.0:
			if (not GM.keyboard_check(G.abajo)) and isduck == 1.0 and (collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 12.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 12.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 16.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) == null) and place_free(x, (y + 1.0)) and vspeed > 0.0:
				jump_type = 1.0
				sprite_index = Scr.scr_NSMBU_jump1(self)
				image_speed = 0.0
				image_index = 19.0
				isduck = 0.0
		if GM.keyboard_check_pressed(G.lanzar_agarrar) and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("barrier") == 0.0:
			alarm[10] = 1.0
	else:
		isduck = 0.0
	if isswim == 0.0 and (G.bg_level == "underwater" or (G.bg_level == "castle" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and G.bg_level == "forest" and G.modo_noche == 0.0 and (y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y) or (GM.instance_exists(A.obj_lava_water) and G.bg_level == "beach" and (y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y)):
		isswim = 1.0
		groundpount = 0.0
		disablecontrols = 0.0
		_user_15()
		walljump = 0.0
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0):
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
		if state > 2.0:
			state = 2.0
	match G.bg_level:
		"underwater":
			var _lm1 = GM.instance_find(A.obj_levelmanager, 0)
			if GM.instance_exists(A.obj_levelmanager) and _lm1.get("camlock") == 1.0:
				if y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0):
					y = (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0)
			elif y < -16.0:
				y = -16.0
		"castle":
			var _lm2 = GM.instance_find(A.obj_levelmanager, 0)
			if G.modo_noche == 1.0 and GM.instance_exists(A.obj_levelmanager) and _lm2.get("camlock") == 1.0:
				if y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0):
					y = (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0)
			elif y < -16.0:
				y = -16.0
		_:
			var _lm3 = GM.instance_find(A.obj_levelmanager, 0)
			if GM.instance_exists(A.obj_mario_pballon) and GM.instance_exists(A.obj_levelmanager) and _lm3.get("camlock") == 1.0:
				if GM.instance_find(A.obj_mario_pballon, 0).y < GM.camera_get_view_y(GM.view_get_camera(0)):
					for inst in GM.with_list(A.obj_mario_pballon):
						inst.y = GM.camera_get_view_y(GM.view_get_camera(0))
				# break (end of switch)
	if y < -96.0:
		y = -96.0
	elif ((bbox_top - 32.0) > GM.room_height) and (G.bg_level != "castle"):
		if (G.powerup == 24.0) and (doublejump != -1.0):
			doublejump = -1.0
			vspeed = -4.5
			y -= 8.0
			jumpnow = 1.0
			GM.audio_play_sound(A.snd_jump, 0.0, false)
			GM.audio_play_sound(A.snd_stomp, 0.0, false)
		else:
			for inst in GM.with_list(GM.instance_create(x, (GM.room_height - 32.0), A.obj_deadmario)):
				inst.visible = false
			instance_destroy()
	elif (GM.instance_exists(A.obj_lava_water) and (((G.bg_level == "castle") or ((G.bg_level == "forest") and (G.modo_noche == 1.0))) and (((y + 32.0) >= GM.instance_find(A.obj_lava_water, 0).y) and (not GM.instance_exists(A.obj_kuribo_drybones))))) or (GM.instance_exists(A.obj_lava_water) and (((G.bg_level == "castle") or ((G.bg_level == "forest") and (G.modo_noche == 1.0))) and (((y + 32.0) >= (GM.instance_find(A.obj_lava_water, 0).y + 12.0)) and GM.instance_exists(A.obj_kuribo_drybones)))):
		if G.bg_level == "castle":
			G.dead_type = 2.0
		elif G.bg_level == "forest":
			G.dead_type = 1.0
		GM.instance_create(x, y, A.obj_deadmario)
		instance_destroy()
	elif GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 1.0)) and (((y + 32.0) >= GM.instance_find(A.obj_lava_water, 0).y) and (not GM.instance_exists(A.obj_kuribo_drybones))) or (GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 1.0)) and (((y + 32.0) >= (GM.instance_find(A.obj_lava_water, 0).y + 12.0)) and GM.instance_exists(A.obj_kuribo_drybones))):
		G.dead_type = 2.0
		GM.instance_create(x, y, A.obj_deadmario)
		instance_destroy()
	if ((G.bg_level == "underwater") and (isswim == 0.0)) or (((G.bg_level == "castle") and ((G.modo_noche == 1.0) and (isswim == 0.0))) or (GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "forest") and ((G.modo_noche == 0.0) and (((y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y) and (isswim == 0.0)))))):
		if (holding == 2.0) and (G.apariencia == 2.0):
			isswimhold = 1.0
		isswim = 1.0
		powerupfly = 0.0
		walljump = 0.0
		squirrelpropel = 0.0
		doublejump = 0.0
		if collision_point(x, (y - 17.0), A.obj_lava_water, false, false) != null and (collision_point(x, (y - 16.0), A.obj_lava_water, false, false) == null):
			vspeed = 0.0
			if G.apariencia != 0.0:
				for inst in GM.with_list(GM.instance_create(x, (y + 7.0), A.obj_smoke)):
					if G.apariencia == 1.0:
						inst.sprite_index = A.spr_SMB3_splash
					elif G.apariencia == 2.0:
						inst.sprite_index = A.spr_splash
					inst.depth = -10.0
		isfloating = 0.0
		if floatnow == 1.0:
			GM.audio_stop_sound(A.snd_spin)
			floatnow = 0.0
		if state > 2.0:
			state = 2.0
	if GM.instance_exists(A.obj_cinta) and GM.instance_exists(A.obj_marioU):
		conveyor = null  # GML: false (== no instance)
		player_on_conveyor = collision_rectangle((bbox_left - 2.0), (bbox_top + 10.0), (bbox_right + 2.0), (bbox_bottom + 10.0), A.obj_cinta_parent, false, false)
		solid_col = (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidtop, false, false))
		solid_col_2 = (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false))
		if player_on_conveyor != null:
			conveyor_first_col = true
		elif (solid_col != null) or (solid_col_2 != null):
			conveyor_first_col = false
		if conveyor_first_col == true:
			conveyor = collision_rectangle((bbox_left - 2.0), GM.instance_find(A.obj_cinta_parent, 0).y - 48.0, (bbox_right + 2.0), GM.instance_find(A.obj_cinta_parent, 0).y, A.obj_cinta_parent, false, false)
		elif conveyor_first_col == false:
			conveyor = null  # GML: false
		if conveyor != null and GM.instance_find(A.obj_marioU, 0).y > GM.instance_find(A.obj_cinta_parent, 0).y:
			conveyor = null  # GML: false
		if conveyor != null and (conveyor.image_speed != 0.0):
			if conveyor.image_speed > 0.0:
				if (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_pinchos, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_muncher, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_cannon, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) == null))))):
					x -= conveyor.image_speed
			elif conveyor.image_speed < 0.0:
				if (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_pinchos, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_muncher, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_cannon, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle((bbox_left - 2.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) == null))))):
					x -= conveyor.image_speed


# from objects/obj_marioU/Step_2.gml
func _step_end() -> void:
	var acrh  # 局部变量提升（GML 的 var 是函数作用域）
	var crh_f  # 局部变量提升（GML 的 var 是函数作用域）
	var wkhm  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_levelmanager):
		pmeter = GM.instance_find(A.obj_levelmanager, 0).get("pmeter")
	if airspin > 1.0 and (not GM.instance_exists(A.obj_mario_transform2)):
		if airspin >= 11.7:
			airspin = 0.0
		else:
			airspin += 0.9
	if isswim == 0.0 and GM.audio_is_playing(A.snd_NSMBU_swim2):
		GM.audio_stop_sound(A.snd_NSMBU_swim2)
	if triple_jump > 0.0 and state == 2.0 and jumpnow == 0.0:
		triple_jump = 0.0
	_user_9()
	if iamkicking == 1.0 and stompstyle == 0.0 and isduck == 0.0:
		sprite_index = Scr.scr_NSMBU_kick(self, isswim)
		if image_index > (image_number - 1.0):
			if state == 2.0 and isswim == 0.0:
				sprite_index = Scr.scr_NSMBU_jump2(self)
				image_speed = 0.0
				image_index = 34.0
				jump_type = 2.0
			iamkicking = 0.0
		else:
			image_speed = 0.8
	elif isduck == 0.0:
		if G.powerup == 0.0:
			mask_index = A.spr_smallmask
		else:
			mask_index = A.spr_bigmask
		if G.powerup == 2.0 or G.powerup == -38.0:
			if firing > 0.0:
				firing -= 1.0
		else:
			firing = 0.0
		if holding == 0.0:
			if state < 2.0 and isswim == 0.0 and pmeter > 5.0 and ((direct == 1.0 and hspeed < 0.0 and GM.keyboard_check(G.derecha)) or (direct == -1.0 and hspeed > 0.0 and GM.keyboard_check(G.izquierda))):
				sprite_index = Scr.scr_NSMBU_skid(self)
				image_speed = 0.0
				if direct == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
				if skidnow == 0.0:
					skidnow = 1.0
					skid_nsmbu = 1.0
					GM.audio_play_sound(Scr.scr_snd_skid(self), 1.0, true)
			elif skidnow == 1.0 and state < 2.0 and direct == 1.0 and hspeed > 0.0 and GM.keyboard_check(G.derecha):
				if sprite_index != Scr.scr_NSMBU_skid_right(self) and (not GM.instance_exists(A.obj_mario_transform2)):
					image_index = 0.0
					GM.audio_stop_sound(Scr.scr_snd_skid(self))
				sprite_index = Scr.scr_NSMBU_skid_right(self)
				if image_index < 6.0:
					image_speed = 0.6
				else:
					sprite_index = Scr.scr_NSMBU_runmax(self)
					image_index = 0.0
					hspeed = 2.1
					if GM.instance_exists(A.obj_levelmanager):
						for inst in GM.with_list(A.obj_levelmanager):
							inst.pmeter = 6.0
					skidnow = 0.0
			elif skidnow == 1.0 and state < 2.0 and direct == -1.0 and hspeed < 0.0 and GM.keyboard_check(G.izquierda):
				if sprite_index != Scr.scr_NSMBU_skid_left(self) and (not GM.instance_exists(A.obj_mario_transform2)):
					image_index = 0.0
					GM.audio_stop_sound(Scr.scr_snd_skid(self))
				sprite_index = Scr.scr_NSMBU_skid_left(self)
				if image_index < 6.0:
					image_speed = 0.6
				else:
					sprite_index = Scr.scr_NSMBU_runmax(self)
					image_index = 0.0
					hspeed = -2.1
					if GM.instance_exists(A.obj_levelmanager):
						for inst in GM.with_list(A.obj_levelmanager):
							inst.pmeter = 6.0
					skidnow = 0.0
			elif state == 0.0:
				if inclown == 2.0:
					if isswim == 1.0:
						sprite_index = Scr.scr_NSMBU_swim_fall(self)
						image_speed = 0.5
					else:
						# animacion de claw mario caught
						sprite_index = Scr.scr_NSMBU_jump1(self)
						image_speed = 0.0
						image_index = 34.0
				elif stuntime > 0.0:
					sprite_index = Scr.scr_NSMBU_stun(self)
					image_speed = 0.4
				elif groundpount > 1.0:
					if groundpount > 6.0:
						if GM.keyboard_check(G.abajo):
							sprite_index = Scr.scr_NSMBU_crouch_idle(self)
							image_index = 0.0
							groundpount = 0.0
							disablecontrols = 0.0
						else:
							if sprite_index != Scr.scr_NSMBU_standup(self) and (not GM.instance_exists(A.obj_mario_transform2)):
								image_index = 0.0
							sprite_index = Scr.scr_NSMBU_standup(self)
							if image_index < 14.0:
								image_speed = 0.6
							else:
								sprite_index = Scr.scr_NSMBU_idle(self, isswim)
								image_index = 0.0
								groundpount = 0.0
								disablecontrols = 0.0
					else:
						sprite_index = Scr.scr_NSMBU_groundpound_stop(self)
						image_speed = 0.0
						match G.powerup:
							0.0:
								image_index = 0.0
							1.0:
								image_index = 1.0
							2.0:
								image_index = 2.0
							-30.0:
								image_index = 3.0
							-43.0:
								image_index = 4.0
							-38.0:
								image_index = 5.0
						if groundpount == 2.0:
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
								inst.sprite_index = A.spr_NSMBU_smoke_groundpound
								inst.direct = 1.0
								inst.image_speed = 0.5
								inst.depth = -10.0
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
								inst.sprite_index = A.spr_NSMBU_smoke_groundpound
								inst.direct = -1.0
								inst.image_speed = 0.5
								inst.depth = -10.0
							GM.audio_play_sound(A.snd_NSMBU_groundpount_stop, 0.0, false)
							groundpount = 3.0
						if not GM.instance_exists(A.obj_groundpount):
							if GM.keyboard_check(G.abajo):
								groundpount += 0.3
							else:
								groundpount += 1.0
				elif firing > 0.0:
					sprite_index = Scr.scr_marioshoot(self)
					if firing == 19.0:
						image_index = 0.0
					if image_index >= 13.0:
						firing = 0.0
					image_speed = 0.7
				elif isswim == 1.0:
					if G.powerup == -38.0:
						if sprite_index == A.spr_NSMBU_mario_penguin_swim:
							if image_index >= 15.5:
								sprite_index = A.spr_NSMBU_mario_penguin_swim_idle
								image_index = 0.0
							else:
								image_speed = 0.5
						else:
							sprite_index = A.spr_NSMBU_mario_penguin_swim_idle
							if hspeed == 0.0:
								image_speed = 0.5
							else:
								image_speed = 1.0
					elif new_swim == 1.0:
						sprite_index = Scr.scr_NSMBU_swim2(self)
						image_speed = 1.0
					elif sprite_index != Scr.scr_NSMBU_idle(self, isswim) and sprite_index != Scr.scr_NSMBU_ground_idle(self):
						sprite_index = Scr.scr_NSMBU_ground_idle(self)
						image_index = 0.0
					elif sprite_index == Scr.scr_NSMBU_ground_idle(self):
						if image_index >= 10.5:
							sprite_index = Scr.scr_NSMBU_idle(self, isswim)
							image_index = 0.0
						else:
							image_speed = 0.5
					else:
						sprite_index = Scr.scr_NSMBU_idle(self, isswim)
						image_speed = 0.5
				else:
					if flip > 6.0:
						if flip == 7.0:
							sprite_index = Scr.scr_NSMBU_flip_start(self)
							if image_index >= 4.5:
								flip = 8.0
							else:
								image_speed = 0.5
						else:
							sprite_index = Scr.scr_NSMBU_flip(self)
							image_speed = 0.3
					elif sprite_index == Scr.scr_NSMBU_ground_idle(self):
						if image_index >= 10.5:
							sprite_index = Scr.scr_NSMBU_idle(self, isswim)
						else:
							image_speed = 0.5
					elif sprite_index == Scr.scr_NSMBU_walkhome(self):
						if G.jugador == 0.0:
							wkhm = 9.0
						else:
							wkhm = 6.0
						if image_index >= wkhm:
							sprite_index = Scr.scr_NSMBU_idle(self, isswim)
						else:
							image_speed = 1.0
					elif sprite_index == Scr.scr_NSMBU_idle(self, isswim):
						sprite_index = Scr.scr_NSMBU_idle(self, isswim)
						image_speed = 0.3
					elif sprite_index == Scr.scr_NSMBU_acrouch(self):
						if G.jugador == 0.0:
							acrh = 10.0
						else:
							acrh = 6.0
						if image_index >= acrh:
							sprite_index = Scr.scr_NSMBU_idle(self, isswim)
							crouch_temp = 0.0
						else:
							image_speed = 1.0
					elif crouch_temp == 1.0:
						sprite_index = Scr.scr_NSMBU_acrouch(self)
						image_index = 0.0
					elif sprite_index == Scr.scr_NSMBU_walk(self, 0.0):
						sprite_index = Scr.scr_NSMBU_walkhome(self)
						image_index = 0.0
					else:
						if jumpnow_temp == 0.0:
							image_index = 5.0
						else:
							GM.audio_play_sound(A.snd_NSMBU_standup, 0.0, false)
							jumpnow_temp = 0.0
							image_index = 0.0
						sprite_index = Scr.scr_NSMBU_ground_idle(self)
					if isswim == 0.0 and inclown == 0.0 and G.powerup != -38.0 and G.jugador == 0.0 and flip < 7.0:
						if flip < 6.0:
							flip += 0.01
						else:
							flip = 7.0
							image_index = 0.0
			elif state == 1.0:
				flip = 0.0
				jumpnow_temp = 0.0
				crouch_temp = 0.0
				if firing > 0.0:
					sprite_index = Scr.scr_marioshoot(self)
					if firing == 19.0:
						image_index = 0.0
					if image_index >= 9.0:
						firing = 0.0
					image_speed = 0.7
				elif isswim == 1.0:
					if G.powerup == -38.0:
						if sprite_index == A.spr_NSMBU_mario_penguin_swim:
							if image_index >= 15.5:
								sprite_index = A.spr_NSMBU_mario_penguin_swim_idle
								image_index = 0.0
							else:
								image_speed = 0.5
						else:
							sprite_index = A.spr_NSMBU_mario_penguin_swim_idle
							if hspeed == 0.0:
								image_speed = 0.5
							else:
								image_speed = 1.0
					elif new_swim == 1.0:
						sprite_index = Scr.scr_NSMBU_swim2(self)
						image_speed = 1.0
					else:
						sprite_index = Scr.scr_NSMBU_walk(self, isswim)
						image_speed = 0.5
				elif pmeter < 6.0:
					if absf(hspeed) <= (1.4 + absf((1 * GM.instance_number(A.obj_invincibility)))):
						if sprite_index == Scr.scr_NSMBU_skid_right(self) or sprite_index == Scr.scr_NSMBU_skid_left(self):
							if image_index < 6.0:
								image_speed = 0.5
							else:
								sprite_index = Scr.scr_NSMBU_walk(self, isswim)
								image_speed = 1.0
						else:
							sprite_index = Scr.scr_NSMBU_walk(self, isswim)
							if absf(hspeed) == (1.4 + absf((1 * GM.instance_number(A.obj_invincibility)))):
								image_speed = (1.5 + (0.5 * snow))
							else:
								image_speed = (1.0 + (0.5 * snow))
					else:
						sprite_index = Scr.scr_NSMBU_run(self)
						image_speed = (1.0 + (0.5 * snow))
				else:
					if polvo < 5.0:
						polvo += 1.0
					else:
						if hspeed > 0.0:
							GM.instance_create((x - 20.0), (y + 18.0), A.obj_smoke_steps)
						elif hspeed < 0.0:
							GM.instance_create((x + 4.0), (y + 18.0), A.obj_smoke_steps)
						polvo = 0.0
					sprite_index = Scr.scr_NSMBU_runmax(self)
					image_speed = (0.8 + (0.2 * snow))
			elif state == 2.0:
				flip = 0.0
				crouch_temp = 0.0
				if isswim == 1.0:
					if noisy == 0.0:
						if G.powerup == -38.0:
							if firing > 0.0:
								sprite_index = A.spr_NSMBU_mario_penguin_swim_shoot
								if firing == 19.0:
									image_index = 0.0
								if image_index >= 11.0:
									firing = 0.0
								image_speed = 0.7
							elif sprite_index == A.spr_NSMBU_mario_penguin_swim:
								if image_index >= 15.5:
									sprite_index = A.spr_NSMBU_mario_penguin_swim_idle
									image_index = 0.0
								else:
									image_speed = 0.5
							else:
								sprite_index = A.spr_NSMBU_mario_penguin_swim_idle
								if hspeed == 0.0:
									image_speed = 0.5
								else:
									image_speed = 1.0
						elif firing > 0.0:
							sprite_index = Scr.scr_marioshoot(self)
							if firing == 19.0:
								image_index = 0.0
							if image_index >= 9.0:
								firing = 0.0
							image_speed = 0.7
						elif new_swim == 1.0:
							sprite_index = Scr.scr_NSMBU_swim2(self)
							image_speed = 1.0
						elif sprite_index == Scr.scr_NSMBU_swim(self):
							if image_index > (image_number - 1.0):
								sprite_index = Scr.scr_NSMBU_swim_fall(self)
								image_index = 0.0
							else:
								if image_speed > 0.5:
									image_speed -= 0.05
								else:
									image_speed = 0.5
								if GM.keyboard_check(G.saltar) and image_index > 7.0 and image_index < 8.0:
									new_swim = 1.0
									GM.audio_play_sound(A.snd_NSMBU_swim2, 1.0, true)
						else:
							sprite_index = Scr.scr_NSMBU_swim_fall(self)
							image_speed = 0.5
				elif helice_fly > 0.0 and helice_fly < 5.0:
					match helice_fly:
						1.0:
							if GM.instance_exists(A.obj_mario_transform2):
								sprite_index = A.spr_NSMBU_mario_helice_transform
								image_speed = 0.0
								match G.powerup:
									-30.0:
										image_index = 0.0
									1.0:
										image_index = 1.0
							else:
								sprite_index = A.spr_NSMBU_mario_helice_fly
								if G.bg_level == "sky" and G.modo_noche == 1.0:
									image_speed = 0.6
								else:
									image_speed = 0.9
								if vspeed > 1.0 and fly_cap == 0.0:
									helice_fly = 2.0
						2.0:
							if GM.instance_exists(A.obj_mario_transform2):
								sprite_index = A.spr_NSMBU_mario_helice_transform
								image_speed = 0.0
								match G.powerup:
									-30.0:
										image_index = 2.0
									1.0:
										image_index = 3.0
							elif sprite_index == A.spr_NSMBU_mario_helice_drill_spin:
								sprite_index = A.spr_NSMBU_mario_helice_drill_spin_end
								image_index = 0.0
							elif sprite_index == A.spr_NSMBU_mario_helice_drill_spin_end:
								if image_index >= 24.0:
									sprite_index = A.spr_NSMBU_mario_helice_fall
									image_index = 0.0
								image_speed = 1.0
							else:
								sprite_index = A.spr_NSMBU_mario_helice_fall
								image_speed = 0.8
						3.0:
							if GM.instance_exists(A.obj_mario_transform2):
								sprite_index = A.spr_NSMBU_mario_helice_transform
								image_speed = 0.0
								match G.powerup:
									-30.0:
										image_index = 0.0
									1.0:
										image_index = 1.0
							else:
								sprite_index = A.spr_NSMBU_mario_helice_down_spin
								if image_index >= 22.5:
									if helice_fly_temp == 1.0:
										helice_fly_temp = 0.0
										helice_fly = 2.0
									else:
										helice_fly_temp += 1.0
								elif helice_fly_temp == 0.0:
									image_speed = 1.5
								else:
									image_speed = 1.0
						4.0:
							sprite_index = Scr.scr_NSMBU_drill_spin(self)
							image_speed = 1.0
				elif doublejump != 0.0 and G.powerup == -43.0:
					if doublejump == 1.0:
						sprite_index = A.spr_NSMBU_mario_arcon_doblejump
						if image_index >= 39.5:
							sprite_index = A.spr_NSMBU_mario_arcon_fly_d
							image_index = 0.0
							doublejump = 2.0
						else:
							image_speed = 0.5
					elif airspin == 1.0:
						if sprite_index != Scr.scr_NSMBU_airspin1(self) and (not GM.instance_exists(A.obj_mario_transform2)):
							image_index = 0.0
						sprite_index = Scr.scr_NSMBU_airspin1(self)
						if not GM.instance_exists(A.obj_mario_transform2):
							airspin_count += 0.7
						if airspin_count < 11.9:
							image_speed = 0.7
						else:
							image_index = 10.0
							airspin = 2.0
							airspin_count = 0.0
					else:
						sprite_index = A.spr_NSMBU_mario_arcon_fly_d
						image_speed = 0.5
				elif walljump == 1.0 and stompstyle == 0.0:
					if G.powerup == -43.0:
						image_speed = 0.25
						if direct == 1.0:
							sprite_index = A.spr_NSMBU_mario_arcon_wallslide_r
						else:
							sprite_index = A.spr_NSMBU_mario_arcon_wallslide_l
					else:
						sprite_index = Scr.scr_NSMBU_wall_slide(self)
						image_speed = 0.0
						if direct == 1.0:
							image_index = 0.0
						else:
							image_index = 1.0
				elif groundpount != 0.0:
					# ORIG-BUG: 原版写的是 sprite_index != scr_NSMBU_groundpound_stop（脚本引用，没有加括号调用），
					# 拿 sprite 编号和脚本函数编号比较，恒为真；照搬为 true
					if true:  # UNSURE: 按 GMS 2.3 脚本函数编号（>= 100000）与 sprite 编号不可能相等推断恒为真
						sprite_index = Scr.scr_NSMBU_groundpound(self)
						if image_index >= 10.2:
							if time_groundpount > 3.0:
								if groundpount_cancelled == 1.0:
									sprite_index = Scr.scr_NSMBU_groundpound_canceled(self)
									image_speed = 0.6
									image_index = 0.0
									groundpount = 0.0
									groundpount_cancelled = 0.0
									disablecontrols = 0.0
								else:
									image_speed = 0.0
									image_index = 10.2
									if groundpount != 2.0:
										groundpount = 2.0
										if not GM.instance_exists(A.obj_groundpount):
											GM.instance_create(x, (y + 20.0), A.obj_groundpount)
										vspeed = 1.0
								time_groundpount = 0.0
							else:
								time_groundpount += 1.0
								image_speed = 0.0
								image_index = 10.2
						else:
							image_speed = 0.8
				elif triple_jump > 1.0:
					if triple_jump == 2.0:
						if sprite_index != Scr.scr_NSMBU_triple_jump0(self) and sprite_index != Scr.scr_NSMBU_triple_jump1(self) and sprite_index != Scr.scr_NSMBU_triple_jump3(self) and sprite_index != Scr.scr_NSMBU_airspin1(self):
							var triple_2 = GM.choose(1.0, 0.0, 1.0, 1.0, 0.0, 2.0)
							triple_number = 33.0
							image_index = 0.0
							match float(triple_2):
								0.0:
									sprite_index = Scr.scr_NSMBU_triple_jump0(self)
								1.0:
									sprite_index = Scr.scr_NSMBU_triple_jump1(self)
								2.0:
									sprite_index = Scr.scr_NSMBU_triple_jump3(self)
					else:
						if sprite_index != Scr.scr_NSMBU_triple_jump2(self) and sprite_index != Scr.scr_NSMBU_airspin1(self) and (not GM.instance_exists(A.obj_mario_transform2)):
							sprite_index = Scr.scr_NSMBU_triple_jump2(self)
							image_index = 0.0
						triple_number = 35.0
					if image_index < triple_number:
						image_speed = 0.5
					else:
						image_speed = 0.0
						image_index = triple_number
					if airspin == 1.0:
						if image_speed == 0.0 and image_index == triple_number:
							sprite_index = Scr.scr_NSMBU_airspin1(self)
							image_index = 0.0
							image_speed = 0.7
						if not GM.instance_exists(A.obj_mario_transform2):
							airspin_count += 0.7
						if airspin_count >= 11.9:
							if triple_jump == 2.0:
								if sprite_index == Scr.scr_NSMBU_airspin1(self):
									sprite_index = Scr.scr_NSMBU_triple_jump1(self)
									image_speed = 0.0
									image_index = triple_number
							elif sprite_index == Scr.scr_NSMBU_airspin1(self):
								sprite_index = Scr.scr_NSMBU_triple_jump2(self)
								image_index = triple_number
							airspin = 2.0
							airspin_count = 0.0
				elif GM.instance_exists(A.obj_invincibility) and stompstyle == 0.0:
					sprite_index = Scr.scr_NSMBU_jump_star(self)
					image_speed = 1.0
					if airspin == 1.0:
						if not GM.instance_exists(A.obj_mario_transform2):
							airspin_count += 0.7
						if airspin_count >= 11.9:
							airspin = 2.0
							airspin_count = 0.0
				elif airspin == 1.0:
					if sprite_index != Scr.scr_NSMBU_airspin1(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_airspin1(self)
					if not GM.instance_exists(A.obj_mario_transform2):
						airspin_count += 0.7
					if airspin_count < 11.9:
						image_speed = 0.7
					else:
						if vspeed < 0.0:
							image_index = 17.0
						elif vspeed > 0.0:
							image_index = 34.0
						sprite_index = Scr.scr_NSMBU_jump1(self)
						jump_type = 1.0
						image_speed = 0.0
						airspin = 2.0
						airspin_count = 0.0
				elif stompstyle == 1.0:
					if sprite_index != Scr.scr_NSMBU_spinjump(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_spinjump(self)
					image_speed = 0.8
				elif firing > 0.0:
					sprite_index = Scr.scr_marioshoot(self)
					if firing == 19.0:
						image_index = 0.0
					if image_index >= 11.0:
						firing = 0.0
						sprite_index = Scr.scr_NSMBU_jump1(self)
						image_index = 27.0
					image_speed = 0.7
				elif sprite_index == Scr.scr_NSMBU_groundpound_canceled(self):
					if image_index >= 4.5:
						sprite_index = Scr.scr_NSMBU_jump2(self)
						image_speed = 0.0
						image_index = 34.5
						jump_type = 2.0
					else:
						image_speed = 0.3
				elif inclown == 1.0:
					sprite_index = Scr.scr_NSMBU_idle(self, isswim)
					image_speed = 0.3
				elif inclown == 0.0 and vspeed > 0.0 or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
					if G.powerup == -43.0 and GM.keyboard_check(G.saltar) and holding == 0.0 and stompstyle == 0.0 and airspin == 0.0 and walljump == 0.0 and isduck == 0.0 and vspeed > 0.0:
						# switch sprite_index（default 里 if 块末尾的 break 只是跳出 switch，后面没有语句，改写成 if/elif 等价）
						if sprite_index == A.spr_NSMBU_mario_arcon_fly_turn:
							if direct_turn == 1.0:
								if image_index <= 1.0:
									sprite_index = A.spr_NSMBU_mario_arcon_fly
									image_index = 0.0
								else:
									image_speed = -0.5
							elif image_index >= 15.5:
								sprite_index = A.spr_NSMBU_mario_arcon_fly
								image_index = 0.0
								direct = (-direct)
							else:
								image_speed = 0.5
						elif sprite_index == A.spr_NSMBU_mario_arcon_fly:
							image_speed = 0.5
						else:
							if sprite_index != Scr.scr_arcon_fly_start(self):
								image_index = 0.0
							sprite_index = Scr.scr_arcon_fly_start(self)
							if image_index >= 11.5:
								sprite_index = Scr.scr_arcon_fly(self)
								image_index = 0.0
							else:
								image_speed = 0.5
						jumpnow = 0.0
					elif sprite_index == A.spr_NSMBU_mario_arcon_fly or sprite_index == A.spr_NSMBU_mario_arcon_fly_start:
						sprite_index = A.spr_NSMBU_mario_arcon_fly_fall
						image_index = 0.0
					elif sprite_index == A.spr_NSMBU_mario_arcon_fly_fall:
						if image_index >= 17.5:
							image_speed = 0.0
							image_index = 17.5
						else:
							image_speed = 0.5
					else:
						if (jumpnow == 0.0 and jumpnow_temp == 0.0) or skidnow == 1.0:
							image_index = 23.0
							jumpnow_temp = 1.0
							jump_type = 1.0
						match float(jump_type):
							1.0:
								sprite_index = Scr.scr_NSMBU_jump1(self)
							2.0:
								sprite_index = Scr.scr_NSMBU_jump2(self)
							3.0:
								sprite_index = Scr.scr_NSMBU_jump3(self)
						if image_index >= 34.5:
							image_speed = 0.0
							image_index = 34.5
						else:
							image_speed = 0.5
				else:
					if jump_type == 0.0:
						jump_type = GM.choose(1.0, 2.0, 3.0)
					match float(jump_type):
						1.0:
							if sprite_index != Scr.scr_NSMBU_jump1(self) and (not GM.instance_exists(A.obj_mario_transform2)):
								image_index = 0.0
							sprite_index = Scr.scr_NSMBU_jump1(self)
						2.0:
							if sprite_index != Scr.scr_NSMBU_jump2(self) and (not GM.instance_exists(A.obj_mario_transform2)):
								image_index = 0.0
							sprite_index = Scr.scr_NSMBU_jump2(self)
						3.0:
							if sprite_index != Scr.scr_NSMBU_jump3(self) and (not GM.instance_exists(A.obj_mario_transform2)):
								image_index = 0.0
							sprite_index = Scr.scr_NSMBU_jump3(self)
					if image_index >= 18.5:
						image_speed = 0.0
						image_index = 18.5
					else:
						image_speed = 0.5
		else:
			flip = 0.0
			crouch_temp = 0.0
			if state == 0.0:
				if isswim == 1.0:
					if sprite_index != Scr.scr_NSMBU_swim_hold(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_swim_hold(self)
					image_speed = 0.5
				elif sprite_index != Scr.scr_NSMBU_hold(self) and sprite_index != Scr.scr_NSMBU_hold_ground(self):
					if sprite_index != Scr.scr_NSMBU_hold_jump(self) and sprite_index != Scr.scr_NSMBU_hold_spinjump(self):
						image_index = 7.0
					else:
						image_index = 0.0
						if gravity == 0.0:
							if not GM.audio_is_playing(A.snd_NSMBU_standup):
								GM.audio_play_sound(A.snd_NSMBU_standup, 0.0, false)
					sprite_index = Scr.scr_NSMBU_hold_ground(self)
				elif sprite_index == Scr.scr_NSMBU_hold_ground(self):
					if image_index >= 10.5:
						sprite_index = Scr.scr_NSMBU_hold(self)
					else:
						image_speed = 0.5
				else:
					if sprite_index != Scr.scr_NSMBU_hold(self):
						sprite_index = Scr.scr_NSMBU_hold(self)
						image_index = 0.0
					image_speed = 0.3
			if state == 1.0:
				flip = 0.0
				jumpnow_temp = 0.0
				if isswim == 1.0:
					if sprite_index != Scr.scr_NSMBU_swim_hold(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_swim_hold(self)
					image_speed = 0.5
				else:
					if sprite_index != Scr.scr_NSMBU_walkhold(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_walkhold(self)
					if pmeter < 6.0:
						if G.bg_level == "snow" and G.modo_noche == 1.0:
							if GM.eq(absf(hspeed), 1.4):
								image_speed = 1.5
							else:
								image_speed = 1.1
						elif GM.eq(absf(hspeed), 1.4):
							image_speed = 1.0
						else:
							image_speed = 0.6
					else:
						image_speed = 1.5
			if state == 2.0:
				if isswim == 1.0:
					if sprite_index != Scr.scr_NSMBU_swim_hold(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_swim_hold(self)
					image_speed = 0.5
				elif G.powerup == -43.0 and GM.keyboard_check(G.saltar) and stompstyle == 0.0 and airspin == 0.0 and walljump == 0.0 and isduck == 0.0 and vspeed > 0.0:
					if sprite_index == A.spr_NSMBU_mario_arcon_flyhold:
						image_speed = 0.5
					else:
						if sprite_index != Scr.scr_arcon_fly_start(self):
							image_index = 0.0
						sprite_index = Scr.scr_arcon_fly_start(self)
						if image_index >= 11.5:
							sprite_index = Scr.scr_arcon_fly(self)
							image_index = 0.0
						else:
							image_speed = 0.5
					jumpnow = 0.0
				elif helice_fly > 0.0 and helice_fly < 5.0:
					match helice_fly:
						1.0:
							if GM.instance_exists(A.obj_mario_transform2):
								sprite_index = A.spr_NSMBU_mario_helice_transform
								image_speed = 0.0
								match G.powerup:
									-30.0:
										image_index = 0.0
									1.0:
										image_index = 1.0
							else:
								sprite_index = A.spr_NSMBU_mario_helice_hold_fly
								image_speed = 0.5
								if vspeed > 0.5 and fly_cap == 0.0:
									helice_fly = 2.0
						2.0:
							if GM.instance_exists(A.obj_mario_transform2):
								sprite_index = A.spr_NSMBU_mario_helice_transform
								image_speed = 0.0
								match G.powerup:
									-30.0:
										image_index = 2.0
									1.0:
										image_index = 3.0
							else:
								if sprite_index != A.spr_NSMBU_mario_helice_fall_hold:
									image_index = 0.0
								sprite_index = A.spr_NSMBU_mario_helice_fall_hold
								image_speed = 1.0
						3.0:
							if GM.instance_exists(A.obj_mario_transform2):
								sprite_index = A.spr_NSMBU_mario_helice_transform
								image_speed = 0.0
								match G.powerup:
									-30.0:
										image_index = 0.0
									1.0:
										image_index = 1.0
							else:
								sprite_index = A.spr_NSMBU_mario_helice_down_spin_hold
								if image_index >= 23.0:
									helice_fly = 2.0
								else:
									image_speed = 1.0
						4.0:
							sprite_index = Scr.scr_NSMBU_drill_spin(self)
							image_speed = 1.0
				elif airspin == 1.0:
					if sprite_index != Scr.scr_NSMBU_hold_airspin(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_hold_airspin(self)
					if not GM.instance_exists(A.obj_mario_transform2):
						airspin_count += 0.7
					if airspin_count < 11.9:
						image_speed = 0.7
					else:
						jump_type = 3.0
						sprite_index = Scr.scr_NSMBU_hold_jump(self)
						image_speed = 0.0
						image_index = 22.0
						airspin = 2.0
						airspin_count = 0.0
				elif stompstyle == 1.0:
					if sprite_index != Scr.scr_NSMBU_hold_spinjump(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_hold_spinjump(self)
					image_speed = 0.7
				else:
					if sprite_index != Scr.scr_NSMBU_hold_jump(self) and (not GM.instance_exists(A.obj_mario_transform2)):
						image_index = 0.0
					sprite_index = Scr.scr_NSMBU_hold_jump(self)
					if image_index < 22.0:
						image_speed = 0.6
					else:
						image_speed = 0.0
						image_index = 22.0
		if state == 3.0:
			flip = 0.0
			jumpnow_temp = 0.0
			crouch_temp = 0.0
			if sprite_index == Scr.scr_marioclimb(self):
				if speed == 0.0:
					image_speed = 0.0
					image_index = 0.0
					if GM.audio_is_playing(A.snd_NSMBU_vine_up):
						GM.audio_stop_sound(A.snd_NSMBU_vine_up)
				else:
					if GM.keyboard_check(G.lanzar_agarrar):
						image_speed = 0.6
					else:
						image_speed = 0.5
					if not GM.audio_is_playing(A.snd_NSMBU_vine_up):
						GM.audio_play_sound(A.snd_NSMBU_vine_up, 1.0, true)
			elif sprite_index == Scr.scr_NSMBU_marioclimb_start(self):
				if image_index >= 3.5:
					sprite_index = Scr.scr_marioclimb(self)
					image_index = 0.0
				else:
					image_speed = 0.5
			else:
				if G.powerup == -43.0:
					sprite_index = Scr.scr_marioclimb(self)
				else:
					sprite_index = Scr.scr_NSMBU_marioclimb_start(self)
				image_index = 0.0
	elif isduck == 1.0:
		flip = 0.0
		jumpnow_temp = 0.0
		if G.powerup == 0.0:
			mask_index = A.spr_smallduckmask
		else:
			mask_index = A.spr_smallmask
		if airspin == 1.0:
			if slide == 1.0:
				if sprite_index != A.spr_NSMBU_mario_penguin_slide_airspin and (not GM.instance_exists(A.obj_mario_transform2)):
					image_index = 0.0
				sprite_index = A.spr_NSMBU_mario_penguin_slide_airspin
			else:
				if sprite_index != Scr.scr_NSMBU_spincrouch(self) and (not GM.instance_exists(A.obj_mario_transform2)):
					image_index = 0.0
				sprite_index = Scr.scr_NSMBU_spincrouch(self)
			if not GM.instance_exists(A.obj_mario_transform2):
				airspin_count += 0.7
			if airspin_count < 11.9:
				image_speed = 0.7
			else:
				if slide == 1.0:
					sprite_index = A.spr_NSMBU_mario_penguin_slide_jump
				else:
					sprite_index = Scr.scr_NSMBU_crouch_jump(self)
				image_index = 22.0
				image_speed = 0.5
				airspin = 2.0
				airspin_count = 0.0
		elif state == 2.0:
			if slide == 1.0:
				if sprite_index != A.spr_NSMBU_mario_penguin_slide_jump and (not GM.instance_exists(A.obj_mario_transform2)):
					image_index = 0.0
				sprite_index = A.spr_NSMBU_mario_penguin_slide_jump
				if image_index < 33.0:
					image_speed = 0.5
				else:
					image_speed = 0.0
					image_index = 33.0
			else:
				if sprite_index != Scr.scr_NSMBU_crouch_jump(self) and (not GM.instance_exists(A.obj_mario_transform2)):
					image_index = 0.0
				sprite_index = Scr.scr_NSMBU_crouch_jump(self)
				if image_index < 25.0:
					image_speed = 0.5
				else:
					image_speed = 0.0
					image_index = 25.0
		else:
			if slide == 1.0:
				if sprite_index == A.spr_NSMBU_mario_penguin_slide or sprite_index == A.spr_NSMBU_mario_penguin_slide_jump:
					sprite_index = A.spr_NSMBU_mario_penguin_slide
					image_speed = 0.5
				else:
					sprite_index = A.spr_NSMBU_mario_penguin_slide_start
					if image_index >= 5.5:
						sprite_index = A.spr_NSMBU_mario_penguin_slide
						image_index = 0.0
					else:
						image_speed = 0.5
			elif sprite_index == Scr.scr_NSMBU_crouch_jump(self):
				sprite_index = Scr.scr_NSMBU_crouch_fall(self)
				image_index = 0.0
			elif sprite_index == Scr.scr_NSMBU_crouch_fall(self):
				if G.jugador == 0.0:
					crh_f = 7.0
				else:
					crh_f = 9.0
				if image_index < crh_f:
					image_speed = 0.5
				else:
					sprite_index = Scr.scr_NSMBU_crouch_idle(self)
					image_index = 0.0
					image_speed = 0.5
			elif sprite_index == Scr.scr_NSMBU_crouch_idle(self):
				image_speed = 0.5
			elif sprite_index == Scr.scr_NSMBU_crouch(self):
				if image_index >= 2.5:
					sprite_index = Scr.scr_NSMBU_crouch_idle(self)
				else:
					image_speed = 0.5
			elif sprite_index == Scr.scr_NSMBU_acrouch(self):
				if image_index <= 1.0:
					sprite_index = Scr.scr_NSMBU_crouch_idle(self)
				else:
					image_speed = -1.0
			else:
				sprite_index = Scr.scr_NSMBU_crouch(self)
				image_index = 0.0
				crouch_temp = 1.0
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0:
				direct = 1.0
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0:
				direct = -1.0
	if (sprite_index != Scr.scr_NSMBU_skid(self) and sprite_index != Scr.scr_NSMBU_skid_right(self) and sprite_index != Scr.scr_NSMBU_skid_left(self) and skidnow == 1.0 and (not GM.instance_exists(A.obj_mario_transform2))) or (state > 1.0 and skidnow == 1.0):
		GM.audio_stop_sound(Scr.scr_snd_skid(self))
		skidnow = 0.0
	if GM.audio_is_playing(Scr.scr_snd_skid(self)) and skidnow == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_skid(self))
	if sprite_index != Scr.scr_marioclimb(self) and sprite_index != Scr.scr_NSMBU_marioclimb_start(self) and GM.audio_is_playing(A.snd_NSMBU_vine_up) and (not GM.instance_exists(A.obj_mario_transform2)):
		GM.audio_stop_sound(A.snd_NSMBU_vine_up)
		skidnow = 0.0


# from objects/obj_marioU/Alarm_4.gml
func _alarm_4() -> void:
	walljump_ex = 0.0


# from objects/obj_marioU/Alarm_11.gml
func _alarm_11() -> void:
	# / @description Allow walljump
	walljump = 0.0


# from objects/obj_marioU/Other_11.gml
func _user_1() -> void:
	if state != 3.0:
		if GM.keyboard_check(G.saltar) or GM.keyboard_check(G.saltar_spin):
			jumpnow = 1.0
		else:
			jumpnow = 2.0
		state = 2.0
		yview = (y + 32.0)
		camera_jump = 1.0
		alarm[0] = 4.0
		airspin = 0.0
		airspin_count = 0.0
		if pmeter >= 6.0 and absf(hspeed) > (2.5 * (1 + GM.instance_number(A.obj_invincibility))) and isduck == 0.0 and holding == 0.0 and stompstyle == 0.0:
			if triple_jump == 3.0:
				triple_jump = 0.0
			else:
				triple_jump += 1.0
			triple_count = 0.0
		else:
			triple_jump = 0.0
		if triple_jump == 2.0:
			GM.audio_play_sound(A.snd_NSMBU_triplejump_0, 0.0, false)
			triple_number = 33.0
		elif triple_jump == 3.0:
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_triplejump_1, A.snd_NSMBU_triplejump_2, A.snd_NSMBU_triplejump_3), 0.0, false)
			triple_number = 35.0
		if (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -2.675
			else:
				vspeed = (-((4.225 - (2.55 * isswim))))
			y -= 1.0
		if stompstyle == 1.0:
			alarm[7] = 5.0
		if sprite_index == Scr.scr_NSMBU_jump1(self) or sprite_index == Scr.scr_NSMBU_jump2(self) or sprite_index == Scr.scr_NSMBU_jump3(self) or holding == 2.0:
			image_index = 0.0
		airspin = 0.0
		airspin_count = 0.0
		groundpount = 0.0
		doublejump = 0.0
		walljump = 0.0
		if helice_fly > 0.0:
			helice_fly = 5.0


# from objects/obj_marioU/Other_12.gml
func _user_2() -> void:
	if gravity == 0.0 and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_lava_water_drybones, false, false) != null and (GM.instance_exists(A.obj_kuribo_drybones) or (G.powerup == -38.0 and slide == 1.0)))):
		if vspeed >= 0.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			statedelay = 0.0
			if hspeed == 0.0:
				state = 0.0
			else:
				state = 1.0
			yview = (y + 32.0)
			if G.yoshi == 0.0 and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsizable, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsolid, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_rockparent, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null):
				_user_0()
		elif vspeed < 0.0:
			state = 2.0
		if groundpount == 1.0:
			groundpount = 0.0
		if triple_jump != 0.0:
			triple_count += 1.0
			if triple_count > 6.0:
				triple_jump = 0.0
				triple_count = 0.0
	else:
		statedelay += 1.0
		if statedelay > 4.0:
			state = 2.0
	if groundpount == 0.0 and disablecontrols == 2.0:
		disablecontrols = 0.0
	if groundpount == 1.0:
		vspeed = 0.0
		gravity = 0.0
	elif groundpount == 2.0:
		if vspeed > 6.0:
			vspeed = 6.0
	elif vspeed > 4.0:
		vspeed = 4.0
	if gp_limit > 0.0:
		gp_limit -= 1.0
	if GM.keyboard_check_pressed(G.abajo) and (helice_fly == 0.0 or helice_fly == 5.0) and G.apariencia == 3.0 and disablecontrols == 0.0 and (not place_meeting(x, y, A.obj_bortice)) and state == 2.0 and isduck == 0.0 and holding == 0.0 and iamkicking == 0.0 and G.yoshi == 0.0 and inclown == 0.0 and airspin != 1.0 and groundpount == 0.0 and gp_limit == 0.0 and walljump == 0.0 and stompstyle == 0.0 and doublejump == 0.0:
		image_index = 0.0
		groundpount = 1.0
		airspin = 0.0
		doublejump = 0.0
		triple_jump = 0.0
		triple_count = 0.0
		hspeed = 0.0
		disablecontrols = 2.0
		GM.audio_play_sound(A.snd_NSMBU_groundpound, 0.0, false)
	if GM.keyboard_check_pressed(G.arriba) and G.apariencia == 3.0 and disablecontrols == 2.0 and state == 2.0 and groundpount != 0.0 and stompstyle == 0.0:
		if groundpount == 1.0:
			groundpount_cancelled = 1.0
		else:
			sprite_index = Scr.scr_NSMBU_groundpound_canceled(self)
			image_speed = 0.6
			image_index = 0.0
			groundpount = 0.0
			disablecontrols = 0.0
		gp_limit = 25.0
	if GM.keyboard_check(G.lanzar_agarrar) or G.key_br == 1.0:
		if helice_fly > 0.0 and helice_fly < 5.0:
			hspeedmax = (1.0 + absf((1 * GM.instance_number(A.obj_invincibility))))
		else:
			hspeedmax = (3.0 + absf((1 * GM.instance_number(A.obj_invincibility))))
	elif helice_fly > 0.0 and helice_fly < 5.0:
		hspeedmax = (1.0 + absf((1 * GM.instance_number(A.obj_invincibility))))
	else:
		hspeedmax = (1.3 + absf((1 * GM.instance_number(A.obj_invincibility))))
	if GM.keyboard_check_pressed(G.saltar) and disablecontrols == 0.0 and jumpnow == 0.0 and state < 2.0:
		if pmeter >= 6.0 and ((GM.instance_exists(A.obj_invincibility) and absf(hspeed) > 3.5) or ((not GM.instance_exists(A.obj_invincibility)) and absf(hspeed) > 2.5)) and isduck == 0.0 and holding == 0.0:
			if triple_jump == 3.0:
				triple_jump = 0.0
			else:
				triple_jump += 1.0
			triple_count = 0.0
		else:
			triple_jump = 0.0
		if triple_jump == 3.0:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -3.65
			else:
				vspeed = -4.65
		elif absf(hspeed) > 2.8:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -3.3
			else:
				vspeed = -4.3
		elif G.bg_level == "sky" and G.modo_noche == 1.0:
			if GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -2.85
			else:
				vspeed = -2.95
		elif GM.gm_round((hspeed / 2.0)) == 0.0:
			vspeed = -3.95
		else:
			vspeed = -4.05
		GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
		if triple_jump == 2.0:
			GM.audio_play_sound(A.snd_NSMBU_triplejump_0, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, (y + 32.0), A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_smoke_triplejump
		elif triple_jump == 3.0:
			for inst in GM.with_list(GM.instance_create(x, (y + 32.0), A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_smoke_triplejump
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_triplejump_1, A.snd_NSMBU_triplejump_2, A.snd_NSMBU_triplejump_3), 0.0, false)
		jumpnow = 1.0
		state = 2.0
		gp_limit = 8.0
	if (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding < 3.0 and isduck == 0.0 and jumpnow == 0.0 and state < 2.0 and G.powerup != -30.0) or (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and isduck == 0.0 and G.yoshi > 0.0 and vspeed == 0.0 and jumpnow == 0.0 and state < 2.0):
		triple_jump = 0.0
		triple_count = 0.0
		image_index = 0.0
		if G.bg_level == "sky" and G.modo_noche == 1.0:
			if G.powerup == -43.0:
				vspeed = -3.625
			else:
				vspeed = -2.3
		elif G.powerup == -43.0:
			vspeed = -4.625
		else:
			vspeed = -3.3
		jumpnow = 1.0
		state = 2.0
		isduck = 0.0
		y -= 1.0
		stompstyle = 1.0
		GM.audio_play_sound(Scr.scr_snd_spinjump(self), 0.0, false)
		alarm[7] = 10.0
		if G.yoshi == 2.0:
			G.yoshi = 0.0
			holding = 0.0
			if GM.instance_exists(A.obj_kuriboshoe):
				var _o9: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_kuriboshoe):
					inst.event_user(0)
				GM.other = _o9
		elif G.yoshi > 0.0:
			G.yoshi = 0.0
			holding = 0.0
			if direct > 0.0:
				hspeed = -1.2
			else:
				hspeed = 1.2
			if GM.instance_exists(A.obj_yoshi2):
				var _o10: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_yoshi2):
					inst.event_user(1)
				GM.other = _o10
	elif (GM.keyboard_check_pressed(G.saltar) and disablecontrols == 0.0 and holding == 3.0 and jumpnow == 0.0 and state < 2.0) or (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and state == 2.0 and G.yoshi > 0.0 and vspeed != 0.0):
		if pmeter >= 6.0 and ((GM.instance_exists(A.obj_invincibility) and absf(hspeed) > 3.5) or ((not GM.instance_exists(A.obj_invincibility)) and absf(hspeed) > 2.5)) and isduck == 0.0 and holding == 0.0:
			if triple_jump == 3.0:
				triple_jump = 0.0
			else:
				triple_jump += 1.0
			triple_count = 0.0
		else:
			triple_jump = 0.0
		if triple_jump == 3.0:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -3.65
			else:
				vspeed = -4.65
		elif absf(hspeed) > 2.8:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -3.3
			else:
				vspeed = -4.3
		elif G.bg_level == "sky" and G.modo_noche == 1.0:
			if GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -2.85
			else:
				vspeed = -2.95
		elif GM.gm_round((hspeed / 2.0)) == 0.0:
			vspeed = -3.95
		else:
			vspeed = -4.05
		GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
		if triple_jump == 2.0:
			GM.audio_play_sound(A.snd_NSMBU_triplejump_0, 0.0, false)
		elif triple_jump == 3.0:
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_triplejump_1, A.snd_NSMBU_triplejump_2, A.snd_NSMBU_triplejump_3), 0.0, false)
		if state == 2.0:
			if G.yoshi == 2.0:
				G.yoshi = 0.0
				holding = 0.0
				if GM.instance_exists(A.obj_kuriboshoe):
					var _o11: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_kuriboshoe):
						inst.event_user(0)
					GM.other = _o11
			elif G.yoshi > 0.0:
				G.yoshi = 0.0
				holding = 0.0
				if direct > 0.0:
					hspeed = -1.2
				else:
					hspeed = 1.2
				if GM.instance_exists(A.obj_yoshi2):
					var _o12: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_yoshi2):
						inst.event_user(1)
					GM.other = _o12
		jumpnow = 1.0
		state = 2.0
		gp_limit = 8.0
	if GM.keyboard_check_pressed(G.abajo) and disablecontrols == 0.0 and G.powerup == -38.0 and holding == 0.0 and pmeter > 5.0 and hspeed != 0.0 and state < 2.0 and slide == 0.0:
		slide = 1.0
		image_index = 0.0
		hspeed += (0.5 * direct)
		GM.audio_play_sound(A.snd_NSMBU_penguin_slide, 0.0, false)
		if not GM.instance_exists(A.obj_penguin_attack):
			GM.instance_create((x + 5.0), (y + 12.0), A.obj_penguin_attack)
	if slide == 1.0 and (GM.keyboard_check_released(G.abajo) or hspeed == 0.0):
		slide = 2.0
	if slide > 1.0:
		slide += 1.0
		if slide > 10.0:
			slide = 0.0
	if GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and G.powerup == -30.0 and G.yoshi == 0.0 and isduck == 0.0 and walljump == 0.0 and holding != 3.0 and inclown == 0.0 and (helice_fly == 0.0 or helice_fly == 2.0):
		triple_jump = 0.0
		triple_count = 0.0
		image_index = 0.0
		if helice_fly == 0.0:
			vspeed = -1.0
			helice_fly = 1.0
			fly_cap = 1.0
			jumpnow = 1.0
			state = 2.0
			isduck = 0.0
			y -= 1.0
			GM.audio_play_sound(A.snd_NSMBU_helice, 0.0, false)
			GM.audio_play_sound(A.snd_NSMBU_helice_voice, 0.0, false)
		elif helice_fly == 2.0 or (helice_fly == 3.0 and helice_fly_temp == 1.0):
			helice_fly = 3.0
			GM.audio_play_sound(A.snd_NSMBU_helice_down_spin, 0.0, false)
	if fly_cap > 0.0:
		if fly_cap > 48.0:
			fly_cap = 0.0
		else:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				if fly_cap > 36.0 and vspeed < 0.0:
					vspeed += 0.05
				elif vspeed < -2.8:
					vspeed = -2.8
				else:
					vspeed -= 0.5
			elif fly_cap > 38.0 and vspeed < 0.0:
				vspeed += 0.05
			elif vspeed < -3.2:
				vspeed = -3.2
			else:
				vspeed -= 0.5
			fly_cap += 1.0
			jumpnow = 1.0
	if GM.keyboard_check(G.abajo) and G.powerup == -30.0 and ((helice_fly > 1.0 and helice_fly != 5.0) or (helice_fly == 1.0 and fly_cap > 15.0)):
		if helice_fly != 4.0:
			GM.audio_stop_sound(A.snd_NSMBU_helice_drill_spin)
			GM.audio_play_sound(A.snd_NSMBU_helice_drill_spin, 0.0, false)
		if helice_fly == 1.0:
			vspeed = 0.5
			fly_cap = 0.0
		helice_fly = 4.0
	elif vspeed > 0.5 and helice_fly == 4.0 and G.powerup == -30.0:
		helice_fly = 2.0
	# ORIG-BUG: 原版写的是 (sprite_index == spr_NSMBU_mario_helice_fall || spr_NSMBU_mario_helice_fall_hold)，
	# 第二项是 sprite 编号本身（非 0 即真），整个括号恒为真；照搬为 or true
	if (sprite_index == A.spr_NSMBU_mario_helice_fall or true) and image_index > 9.0 and helice_fly == 2.0 and (not GM.audio_is_playing(A.snd_NSMBU_helice_planear)):
		GM.audio_play_sound(A.snd_NSMBU_helice_planear, 1.0, true)
	elif helice_fly != 2.0 and GM.audio_is_playing(A.snd_NSMBU_helice_planear):
		GM.audio_stop_sound(A.snd_NSMBU_helice_planear)
	if G.powerup == -43.0 and sprite_index == A.spr_NSMBU_mario_arcon_fly_d and (not GM.audio_is_playing(A.snd_NSMBU_squirrel_plan)):
		GM.audio_play_sound(A.snd_NSMBU_squirrel_plan, 1.0, true)
	elif sprite_index != A.spr_NSMBU_mario_arcon_fly_d and sprite_index != A.spr_NSMBU_mario_arcon_airspin and GM.audio_is_playing(A.snd_NSMBU_squirrel_plan):
		GM.audio_stop_sound(A.snd_NSMBU_squirrel_plan)
	if GM.keyboard_check_pressed(G.saltar_spin) and G.apariencia == 3.0 and disablecontrols == 0.0 and state == 2.0 and G.yoshi == 0.0 and airspin == 0.0 and walljump != 1.0 and inclown == 0.0 and groundpount != 1.0 and stompstyle == 0.0 and (G.powerup != -43.0 or doublejump == 2.0 or holding == 2.0) and (G.powerup != -30.0 or helice_fly == 5.0):
		if triple_jump == 0.0:
			image_index = 0.0
		airspin = 1.0
		groundpount = 0.0
		gp_limit = 0.0
		GM.audio_play_sound(A.snd_NSMBU_airspin, 0.0, false)
	if (GM.keyboard_check_released(G.saltar) and jumpnow == 1.0) or (GM.keyboard_check_released(G.saltar_spin) and jumpnow == 1.0):
		jumpnow = 2.0
	if isduck == 1.0 and state != 2.0:
		if slide == 1.0:
			if hspeed > 0.0:
				hspeed -= 0.005
			if hspeed < 0.0:
				hspeed += 0.005
			if absf(hspeed) < 0.005:
				hspeed = 0.0
		elif snow == 1.0:
			if hspeed > 0.0:
				hspeed -= 0.02
			if hspeed < 0.0:
				hspeed += 0.02
			if absf(hspeed) < 0.02:
				hspeed = 0.0
		else:
			if hspeed > 0.0:
				hspeed -= 0.05
			if hspeed < 0.0:
				hspeed += 0.05
			if absf(hspeed) < 0.05:
				hspeed = 0.0
	else:
		if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and (walljump_ex == 0.0 or (walljump_ex == 1.0 and hspeed > 0.0)):
			if (sprite_index == A.spr_NSMBU_mario_arcon_fly_start or sprite_index == A.spr_NSMBU_mario_arcon_fly) and direct == -1.0:
				sprite_index = A.spr_NSMBU_mario_arcon_fly_turn
				image_index = 15.0
			if hspeed < hspeedmax:
				if snow == 1.0 and gravity == 0.0:
					if hspeed < 0.0:
						hspeed += 0.03
					else:
						hspeed += 0.05
				else:
					if hspeed < 0.0:
						hspeed += 0.075
					hspeed += 0.06
			if walljump == 0.0:
				direct = 1.0
			direct_turn = 1.0
		elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and (walljump_ex == 0.0 or (walljump_ex == 1.0 and hspeed < 0.0)):
			if (sprite_index == A.spr_NSMBU_mario_arcon_fly_start or sprite_index == A.spr_NSMBU_mario_arcon_fly) and direct == 1.0:
				sprite_index = A.spr_NSMBU_mario_arcon_fly_turn
				image_index = 0.0
			if hspeed > (-hspeedmax):
				if snow == 1.0 and gravity == 0.0:
					if hspeed > 0.0:
						hspeed += -0.03
					else:
						hspeed += -0.05
				else:
					if hspeed > 0.0:
						hspeed += -0.075
					hspeed += -0.06
			if walljump == 0.0 and sprite_index != A.spr_NSMBU_mario_arcon_fly_turn:
				direct = -1.0
			direct_turn = -1.0
		elif state != 2.0 or (G.powerup == -30.0 and helice_fly > 0.0 and helice_fly < 5.0):
			if snow == 1.0:
				if hspeed > 0.0:
					hspeed -= 0.005
				elif hspeed < 0.0:
					hspeed += 0.005
				if absf(hspeed) < 0.005:
					hspeed = 0.0
			else:
				if hspeed > 0.0:
					hspeed -= 0.05
				elif hspeed < 0.0:
					hspeed += 0.05
				if absf(hspeed) < 0.05:
					hspeed = 0.0
		if state != 2.0 and absf(hspeed) > hspeedmax:
			if hspeed > 0.0:
				hspeed -= 0.025
			elif hspeed < 0.0:
				hspeed += 0.025
			if absf(hspeed) < 0.025:
				hspeed = 0.0
	if state == 2.0 or statedelay > 0.0:
		if pmeter < 6.0 and triple_jump != 0.0:
			triple_jump = 0.0
		if vspeed > 0.0 and isduck == 0.0 and groundpount == 0.0 and walljump == 0.0 and (helice_fly == 0.0 or helice_fly == 5.0) and holding == 0.0 and G.yoshi == 0.0:
			if GM.keyboard_check(G.derecha) and direct == 1.0:
				if collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_solid, false, true) != null or collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, true) != null or collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, true) != null or collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, true) != null:
					walljump = 1.0
					airspin = 0.0
					airspin_count = 0.0
					jump_number = 1.0
					triple_jump = 0.0
					triple_count = 0.0
					if doublejump == 1.0 or doublejump == 2.0:
						disable_doublejump = 1.0
					doublejump = 0.0
					if G.powerup != -43.0:
						GM.audio_play_sound(A.snd_NSMBU_desllizarse_walljump, 1.0, true)
				else:
					walljump = 0.0
					arcon_slide = 0.0
			elif GM.keyboard_check(G.izquierda) and direct == -1.0:
				if collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, true) != null or collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, true) != null or collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, true) != null or collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, true) != null:
					walljump = 1.0
					airspin = 0.0
					airspin_count = 0.0
					jump_number = 1.0
					triple_jump = 0.0
					triple_count = 0.0
					if doublejump == 1.0 or doublejump == 2.0:
						disable_doublejump = 1.0
					doublejump = 0.0
					if G.powerup != -43.0:
						GM.audio_play_sound(A.snd_NSMBU_desllizarse_walljump, 1.0, true)
				else:
					walljump = 0.0
					arcon_slide = 0.0
					GM.audio_stop_sound(A.snd_NSMBU_desllizarse_walljump)
			else:
				walljump = 0.0
				arcon_slide = 0.0
				GM.audio_stop_sound(A.snd_NSMBU_desllizarse_walljump)
		if walljump == 1.0:
			if state < 2.0 or isswim == 1.0:
				walljump = 0.0
			if (direct < 0.0 and (collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, true) == null) and (collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, true) == null) and (collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, true) == null) and (collision_line((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, true) == null)) or (direct > 0.0 and (collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 1.0), A.obj_solid, false, true) == null) and (collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, true) == null) and (collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, true) == null) and (collision_line(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, true) == null)):
				walljump = 0.0
				if state == 2.0:
					image_index = 23.0
				GM.audio_stop_sound(A.snd_NSMBU_desllizarse_walljump)
			if stompstyle == 0.0:
				if G.powerup == -43.0 and arcon_slide < 120.0:
					gravity = 0.0
					vspeed = 0.0
					arcon_slide += 1.0
				else:
					if G.modo_noche == 1.0 and G.bg_level == "sky":
						gravity = 0.1
						if vspeed > 1.0:
							vspeed = 1.0
					else:
						gravity = 0.2
						if vspeed > 1.6:
							vspeed = 1.6
					if polvo < 6.0:
						polvo += 1.0
					else:
						if direct == 1.0:
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
								inst.image_speed = 0.8
						else:
							for inst in GM.with_list(GM.instance_create((x - 16.0), y, A.obj_smoke)):
								inst.image_speed = 0.8
						polvo = 0.0
			if GM.keyboard_check_pressed(G.saltar):
				if G.modo_noche == 1.0 and G.bg_level == "sky":
					vspeed = -2.625
				else:
					vspeed = -3.625
				jumpnow = 1.0
				stompstyle = 0.0
				image_index = 0.0
				walljump_ex = 1.0
				alarm[4] = 20.0
				alarm[11] = 10.0
				if direct > 0.0:
					hspeed = -2.625
					walljump = 2.0
					direct = -1.0
					GM.audio_play_sound(GM.choose(A.snd_NSMBU_walljump1, A.snd_NSMBU_walljump2), 1.0, false)
					for inst in GM.with_list(GM.instance_create(bbox_right, y, A.obj_smoke)):
						inst.sprite_index = A.spr_NSMBU_smoke_wall
						inst.direct = -1.0
				elif direct < 0.0:
					hspeed = 2.625
					walljump = 2.0
					direct = 1.0
					GM.audio_play_sound(GM.choose(A.snd_NSMBU_walljump1, A.snd_NSMBU_walljump2), 1.0, false)
					for inst in GM.with_list(GM.instance_create(bbox_left, y, A.obj_smoke)):
						inst.sprite_index = A.spr_NSMBU_smoke_wall
						inst.direct = 1.0
			elif GM.keyboard_check_pressed(G.saltar_spin):
				if G.modo_noche == 1.0 and G.bg_level == "sky":
					vspeed = -2.625
				else:
					vspeed = -3.625
				jumpnow = 1.0
				stompstyle = 1.0
				walljump_ex = 1.0
				alarm[4] = 20.0
				alarm[11] = 20.0
				if direct > 0.0:
					hspeed = -2.625
					walljump = 2.0
					direct = -1.0
					GM.audio_play_sound(A.snd_NSMBU_spinjump, 1.0, false)
					for inst in GM.with_list(GM.instance_create(bbox_right, y, A.obj_smoke)):
						inst.sprite_index = A.spr_NSMBU_smoke_wall
						inst.direct = -1.0
				elif direct < 0.0:
					hspeed = 2.625
					walljump = 2.0
					direct = 1.0
					GM.audio_play_sound(A.snd_NSMBU_spinjump, 1.0, false)
					for inst in GM.with_list(GM.instance_create(bbox_left, y, A.obj_smoke)):
						inst.sprite_index = A.spr_NSMBU_smoke_wall
						inst.direct = 1.0
		else:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				gravity = 0.05
				if airspin == 1.0 and vspeed > 0.0:
					gravity = 0.05
					if vspeed > 0.2:
						vspeed = 0.2
				elif groundpount == 2.0:
					if vspeed > 4.0:
						vspeed = 4.0
				elif helice_fly > 1.0 and helice_fly < 5.0:
					match helice_fly:
						2.0:
							if helice_temp == 0.0:
								gravity = 0.1
								if vspeed > 0.4:
									vspeed = 0.4
								if helice_cont == 9.0:
									helice_temp = 1.0
								else:
									helice_cont += 0.5
							else:
								gravity = 0.1
								if vspeed > 0.6:
									vspeed = 0.6
								if helice_cont == 0.0:
									helice_temp = 0.0
								else:
									helice_cont -= 0.5
						3.0:
							gravity = 0.05
							if vspeed > 0.4:
								vspeed = 0.4
						4.0:
							gravity = 0.6
							if vspeed > 4.0:
								vspeed = 4.0
				elif vspeed > 2.0:
					vspeed = 2.0
			elif vspeed > -1.0 or jumpnow != 1.0:
				if helice_fly > 1.0 and helice_fly < 5.0:
					match helice_fly:
						2.0:
							if helice_temp == 0.0:
								gravity = 0.1
								if vspeed > 0.8:
									vspeed = 0.8
								if helice_cont == 9.0:
									helice_temp = 1.0
								else:
									helice_cont += 0.5
							else:
								gravity = 0.1
								if vspeed > 1.2:
									vspeed = 1.2
								if helice_cont == 0.0:
									helice_temp = 0.0
								else:
									helice_cont -= 0.5
						3.0:
							gravity = 0.05
							if vspeed > 0.8:
								vspeed = 0.8
						4.0:
							gravity = 0.6
							if vspeed > 6.0:
								vspeed = 6.0
				elif airspin == 1.0 and vspeed > 0.0:
					gravity = 0.05
					if vspeed > 0.5:
						vspeed = 0.5
				elif groundpount == 2.0:
					gravity = 0.6
				else:
					gravity = 0.3
				if jumpnow == 1.0:
					jumpnow = 2.0
			elif airspin == 1.0 and vspeed > 0.0:
				gravity = 0.05
				if vspeed > 0.5:
					vspeed = 0.5
			elif groundpount == 2.0:
				gravity = 0.2
			else:
				gravity = 0.1
			if G.powerup == -43.0:
				if doublejump > 0.0 or (GM.keyboard_check(G.saltar) and vspeed > 0.0 and (holding == 0.0 or holding == 2.0) and stompstyle == 0.0 and airspin == 0.0 and isduck == 0.0 and groundpount == 0.0 and walljump == 0.0):
					gravity /= 2.0
					if vspeed > 0.8:
						vspeed = 0.8
					triple_jump = 0.0
					triple_count = 0.0
	if G.powerup == -43.0 and GM.keyboard_check_pressed(G.saltar_spin) and (not GM.instance_exists(A.obj_kuribo_drybones)) and disablecontrols == 0.0 and groundpount == 0.0 and doublejump == 0.0 and holding == 0.0 and inclown == 0.0 and stompstyle == 0.0 and airspin == 0.0 and walljump == 0.0 and holding != 3.0 and isduck == 0.0 and disable_doublejump == 0.0:
		doublejump = 1.0
		GM.audio_play_sound(A.snd_NSMBU_squirrel_imp, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, (y + 32.0), A.obj_smoke)):
			inst.sprite_index = A.spr_smoke_doublejump
			inst.direct = self.direct
			inst.image_speed = 0.5
		squirrel_fly = 1.0
		vspeed = 0.0
		hspeed = (1.0 * direct)
		image_index = 0.0
	if squirrel_fly > 0.0:
		if squirrel_fly > 8.0:
			squirrel_fly = 0.0
		else:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				if squirrel_fly > 3.0 and vspeed < 0.0:
					vspeed += 0.15
				elif vspeed < -2.4:
					vspeed = -2.4
				else:
					vspeed -= 1.0
			elif squirrel_fly > 4.0 and vspeed < 0.0:
				vspeed += 0.05
			elif vspeed < -3.0:
				vspeed = -3.0
			else:
				vspeed -= 1.0
			squirrel_fly += 1.0
			jumpnow = 1.0
	var climb1 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false)
	if climb1 != null and (((y + 19.0) > climb1.y and climb1.object_index == A.obj_vine_green and climb1.image_index == 0.0) or climb1.object_index != A.obj_vine_green or climb1.image_index != 0.0) and G.yoshi == 0.0 and isduck == 0.0 and (GM.keyboard_check(G.arriba) or (GM.keyboard_check(G.abajo) and state == 2.0)) and holding == 0.0 and disablecontrols == 0.0:
		GM.audio_stop_sound(A.snd_NSMBU_get_vine)
		GM.audio_play_sound(A.snd_NSMBU_get_vine, 0.0, false)
		state = 3.0
		gravity = 0.0
		speed = 0.0
		_user_15()
		_user_14()
		fly_cap = 0.0
		walljump = 0.0
		airspin = 0.0
		groundpount = 0.0
		triple_jump = 0.0
		triple_count = 0.0
	if stompstyle == 1.0:
		if state != 2.0:
			stompstyle = 0.0


# from objects/obj_marioU/Other_13.gml
func _user_3() -> void:
	if gravity == 0.0 and collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null:
		if vspeed >= 0.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			statedelay = 0.0
			if hspeed == 0.0:
				state = 0.0
			else:
				state = 1.0
			if G.yoshi == 0.0 and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsizable, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsolid, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_rockparent, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null):
				_user_0()
		elif vspeed < 0.0:
			state = 2.0
		if groundpount == 1.0:
			groundpount = 0.0
	else:
		statedelay += 1.0
		if statedelay > 4.0:
			state = 2.0
		gravity = 0.03
	flip = 0.0
	helice_fly = 0.0
	if GM.audio_is_playing(A.snd_NSMBU_helice_planear):
		GM.audio_stop_sound(A.snd_NSMBU_helice_planear)
	if G.powerup == -38.0:
		gravity = 0.0
		if hspeedmax > 1.0:
			hspeedmax -= 0.005
		else:
			hspeedmax = 1.0
		if GM.keyboard_check_pressed(G.saltar) and disablecontrols == 0.0:
			match swimtype:
				0.0:
					hspeed = (3.0 * direct)
				1.0:
					vspeed = -3.0
					hspeed = 0.0
				2.0:
					vspeed = 3.0
					hspeed = 0.0
			if sprite_index != A.spr_NSMBU_mario_penguin_swim or (sprite_index == A.spr_NSMBU_mario_penguin_swim and image_index > (image_number - 4.0)):
				image_index = 0.0
			sprite_index = A.spr_NSMBU_mario_penguin_swim
			image_speed = 0.5
			GM.audio_stop_sound(Scr.scr_swim(self))
			GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
			state = 2.0
			isduck = 0.0
			isduckhold = 0.0
			new_swim = 0.0
			hspeedmax = 2.0
		if GM.keyboard_check(G.izquierda) and isduck == 0.0 and (not GM.keyboard_check(G.derecha)):
			hspeed += -0.2
			direct = -1.0
			swimtype = 0.0
		elif GM.keyboard_check(G.derecha) and isduck == 0.0 and (not GM.keyboard_check(G.izquierda)):
			hspeed += 0.2
			direct = 1.0
			swimtype = 0.0
		else:
			if hspeed > 0.0:
				hspeed -= 0.04
			elif hspeed < 0.0:
				hspeed += 0.04
			if absf(hspeed) < 0.04:
				hspeed = 0.0
		if GM.keyboard_check(G.arriba):
			vspeed += -0.2
			swimtype = 1.0
		elif GM.keyboard_check(G.abajo):
			swimtype = 2.0
			if collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null:
				vspeed = 0.0
			else:
				vspeed += 0.2
		else:
			if vspeed > 0.0:
				vspeed -= 0.04
			elif vspeed < 0.0:
				vspeed += 0.04
			if absf(vspeed) < 0.04:
				vspeed = 0.0
		if GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and G.yoshi > 0.0:
			vspeed = -2.0
			GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
			state = 2.0
			isduck = 0.0
			G.yoshi = 0.0
			holding = 0.0
			if GM.instance_exists(A.obj_kuriboshoe):
				var _o13: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_kuriboshoe):
					inst.event_user(0)
				GM.other = _o13
		if hspeed > hspeedmax:
			hspeed = hspeedmax
		if hspeed < (-hspeedmax):
			hspeed = (-hspeedmax)
		if vspeed > hspeedmax:
			vspeed = hspeedmax
		if vspeed < (-hspeedmax):
			vspeed = (-hspeedmax)
	else:
		if holding == 0.0 or holding == 3.0:
			if new_swim == 1.0:
				if vspeed > 0.5:
					vspeed = 0.5
			elif vspeed > 1.0:
				vspeed = 1.0
			if vspeed < -1.5:
				vspeed = -1.5
			if GM.keyboard_check_pressed(G.saltar) and disablecontrols == 0.0:
				if state < 2.0:
					vspeed = -1.0
				elif vspeed > 0.0:
					vspeed = (-((vspeed + 0.18)))
				else:
					vspeed -= 0.6
				if sprite_index != Scr.scr_NSMBU_swim(self) or (sprite_index == Scr.scr_NSMBU_swim(self) and image_index > (image_number - 4.0)):
					image_index = 0.0
				sprite_index = Scr.scr_NSMBU_swim(self)
				image_speed = 0.9
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
				state = 2.0
				isduck = 0.0
				isduckhold = 0.0
				new_swim = 0.0
			if GM.keyboard_check_released(G.saltar) and new_swim == 1.0:
				new_swim = 0.0
				sprite_index = Scr.scr_NSMBU_swim(self)
				image_index = 8.0
			if GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and G.yoshi > 0.0:
				vspeed = -1.0
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
				state = 2.0
				isduck = 0.0
				isduckhold = 0.0
				G.yoshi = 0.0
				holding = 0.0
				if GM.instance_exists(A.obj_yoshi2):
					var _o14: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_yoshi2):
						inst.event_user(1)
					GM.other = _o14
				if GM.instance_exists(A.obj_kuriboshoe):
					stompstyle = 0.0
					var _o15: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_kuriboshoe):
						inst.event_user(0)
					GM.other = _o15
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed += 0.05
				direct = 1.0
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed -= 0.05
				direct = -1.0
			else:
				if hspeed > 0.0:
					hspeed -= 0.05
				if hspeed < 0.0:
					hspeed += 0.05
				if absf(hspeed) < 0.05:
					hspeed = 0.0
		else:
			vspeed -= 0.5
			if vspeed < -1.0:
				vspeed = -1.0
			if vspeed > 1.0:
				vspeed = 1.0
			if GM.keyboard_check_pressed(G.abajo) and disablecontrols == 0.0:
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
			if GM.keyboard_check(G.abajo) and disablecontrols == 0.0:
				vspeed = 1.0
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed += 0.05
				direct = 1.0
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed -= 0.05
				direct = -1.0
			elif direct == 1.0:
				hspeed += 0.05
				if hspeed > 0.5:
					hspeed = 0.5
			else:
				hspeed -= 0.05
				if hspeed < -0.5:
					hspeed = -0.5
		if state == 2.0:
			if hspeed > 1.0:
				hspeed = 1.0
			if hspeed < -1.0:
				hspeed = -1.0
		else:
			if hspeed > 0.5:
				hspeed = 0.5
			if hspeed < -0.5:
				hspeed = -0.5
		if noisy == 1.0:
			noisy = 0.0
			GM.audio_stop_sound(Scr.scr_swim(self))
	var climb1 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false)
	if climb1 != null and (((y + 19.0) > climb1.y and climb1.object_index == A.obj_vine_green and climb1.image_index == 0.0) or climb1.object_index != A.obj_vine_green or climb1.image_index != 0.0) and G.yoshi == 0.0 and isduck == 0.0 and (GM.keyboard_check(G.arriba) or (GM.keyboard_check(G.abajo) and state == 2.0)) and holding == 0.0 and disablecontrols == 0.0:
		GM.audio_stop_sound(A.snd_NSMBU_get_vine)
		GM.audio_play_sound(A.snd_NSMBU_get_vine, 0.0, false)
		state = 3.0
		gravity = 0.0
		speed = 0.0
		_user_15()
		_user_14()
		walljump = 0.0
		airspin = 0.0
		groundpount = 0.0
		triple_jump = 0.0
		triple_count = 0.0
	if GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach") and (y + 16.0) <= (GM.instance_find(A.obj_lava_water, 0).y - 4.0):
		isswim = 0.0
		if place_meeting(x, (y + 16.0), A.obj_lava_water):
			if G.apariencia != 0.0 and vspeed > 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
			if GM.keyboard_check(G.saltar):
				vspeed = -4.125
				jumpnow = 1.0
				if G.apariencia != 0.0:
					GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
		if noisy == 1.0:
			noisy = 0.0
			GM.audio_stop_sound(Scr.scr_swim(self))
	if G.yoshi != 2.0:
		stompstyle = 0.0


# from objects/obj_marioU/Other_19.gml
func _user_9() -> void:
	var steps_sound  # 局部变量提升（GML 的 var 是函数作用域）
	if isswim == 0.0 and state == 1.0 and isduck == 0.0 and skidnow == 0.0:
		if pmeter > 6.0:
			steps_sound = 9.0
		elif absf(hspeed) <= 1.0:
			steps_sound = 16.0
		elif absf(hspeed) <= 1.6:
			steps_sound = 12.0
		elif absf(hspeed) > 1.6:
			steps_sound = 12.0
		if steps_count > 0.0:
			steps_count -= 1.0
			return
		if G.powerup == -38.0:
			if step_inter == 0.0:
				GM.audio_play_sound(A.snd_NSMBU_step_penguin1, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_NSMBU_step_penguin2, 0.0, false)
		else:
			var c_model = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_modelsolid, false, false)
			var c_start_goal = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_groundparent, false, false)
			if G.bg_level == "ground" or G.bg_level == "forest" or G.bg_level == "beach" or G.bg_level == "fall" or G.bg_level == "snow" or G.bg_level == "sky":
				if c_model != null or c_start_goal != null:
					Scr.scr_step_sounds(self, 0.0, step_inter)
				else:
					Scr.scr_step_sounds(self, 1.0, step_inter)
			elif G.bg_level == "airship":
				if c_start_goal != null:
					Scr.scr_step_sounds(self, 0.0, step_inter)
				elif c_model != null:
					Scr.scr_step_sounds(self, 2.0, step_inter)
				else:
					Scr.scr_step_sounds(self, 1.0, step_inter)
			else:
				Scr.scr_step_sounds(self, 1.0, step_inter)
		if step_inter == 0.0:
			step_inter = 1.0
		else:
			step_inter = 0.0
		steps_count = steps_sound
	else:
		steps_count = 0.0
		step_inter = 0.0


# from objects/obj_marioU/Draw_0.gml
func _gm_draw() -> void:
	var posyy  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Draws Mario
	# Draw Mario
	if stompstyle == 1.0 or (helice_fly > 0.0 and helice_fly < 5.0):
		GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) + shake), (GM.gm_round(y) + 1.0), 1.0, 1.0, 0.0, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) + shake), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
	if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
		# Make Mario flash
		GM.shader_set(A.sha_blendreplace)
		if stompstyle == 1.0 or (helice_fly > 0.0 and helice_fly < 5.0):
			GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) + shake), (GM.gm_round(y) + 1.0), 1.0, 1.0, 0.0, blend_star, GM.instance_find(A.obj_invincibility, 0).get("flashAlpha"))
		else:
			GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) + shake), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, blend_star, GM.instance_find(A.obj_invincibility, 0).get("flashAlpha"))
		# Reset flashing
		GM.shader_reset()
	if helice_fly == 4.0:
		GM.draw_sprite(A.spr_NSMBU_mario_helice_remolino, image_index, x, (y + 1.0))
	if G.condiciones == 1.0 and G.condiciones_clear == 1.0:
		if G.powerup == 0.0 or G.powerup == -85.0:
			posyy = 1.0
		else:
			posyy = 11.0
		if G.apariencia > 1.0:
			sprite_cond = A.spr_condicion_obtenida
		else:
			sprite_cond = A.spr_SMB3_condicion_obtenida
		GM.draw_sprite(sprite_cond, G.jugador, (x - 19.0), (y - posyy))
