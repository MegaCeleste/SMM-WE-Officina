extends "res://objects/obj_deactivation.gd"

var sprite_wings: float = 0.0
var convertirse: float = 0.0
var wings: float = 0.0
var wings_anim: float = 0.0
var paracaidas: float = 0.0


# from objects/obj_coin/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB_coin_dark
				"ghost":
					sprite_index = A.spr_SMB_coin_night
				"underground":
					sprite_index = A.spr_SMB_coin_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_dark
					else:
						sprite_index = A.spr_SMB_coin
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_night
					else:
						sprite_index = A.spr_SMB_coin
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_coin_dark
				"ghost":
					sprite_index = A.spr_SMB3_coin_night
				"underground":
					sprite_index = A.spr_SMB3_coin_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_dark
					else:
						sprite_index = A.spr_SMB3_coin
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_night
					else:
						sprite_index = A.spr_SMB3_coin
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_index = A.spr_coin
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_coin
			sprite_wings = A.spr_NSMBU_wings_items
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.15
	convertirse = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	alarm[10] = 4.0


# from objects/obj_coin/Destroy_0.gml
func _destroy() -> void:
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if wings == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.set("direct", -1.0)
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.set("direct", -1.0)


# from objects/obj_coin/Step_2.gml
func _step_end() -> void:
	if convertirse == 1.0 and wings == 0.0 and paracaidas == 0.0:
		if GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			_user_0()
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_flipblock)):
				inst.convertirse = 0.0
			instance_destroy()
	elif convertirse == 0.0 and wings == 0.0 and paracaidas == 0.0:
		if not GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			_user_0()
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_flipblock)):
				inst.convertirse = 1.0
			instance_destroy()
	if paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
		if x > (xstart + 16.0):
			if hspeed < -0.5:
				hspeed = -0.5
			else:
				hspeed -= 0.015
		elif x < (xstart - 16.0):
			if hspeed > 0.5:
				hspeed = 0.5
			else:
				hspeed += 0.015
	if wings == 1.0:
		if not GM.instance_exists(A.obj_deadmario):
			if G.apariencia == 3.0:
				wings_anim += 0.5
			else:
				wings_anim += 0.12
	if wings == 1.0 and paracaidas == 0.0:
		if y > (ystart + 16.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.085
		elif y < (ystart - 16.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.085


# from objects/obj_coin/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = -0.6
		vspeed = -0.5
		depth = -7.0
	elif paracaidas == 1.0:
		hspeed = -0.6
		depth = -7.0


# from objects/obj_coin/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0:
		GM.instance_create(x, y, A.obj_veggiecoin)
		instance_destroy()


# from objects/obj_coin/Collision_obj_clown.gml
func _collision_obj_clown(other: GMObject) -> void:
	var o = other
	if o.inmario == 1.0:
		if G.apariencia == 3.0:
			_user_2()
		else:
			_user_1()


# from objects/obj_coin/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var o = other
	if o.held == 0.0:
		if G.apariencia == 3.0:
			_user_2()
		else:
			_user_1()


# from objects/obj_coin/Collision_obj_link_arrow.gml
func _collision_obj_link_arrow(other: GMObject) -> void:
	_user_1()


# from objects/obj_coin/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.apariencia == 3.0 and G.effect_star == 1.0:
		_user_2()
	else:
		_user_1()


# from objects/obj_coin/Collision_obj_player_goal_parent.gml
func _collision_obj_player_goal_parent(other: GMObject) -> void:
	if G.apariencia == 3.0:
		_user_2()
	else:
		_user_1()


# from objects/obj_coin/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if G.apariencia == 3.0:
		_user_2()
	else:
		_user_1()


# from objects/obj_coin/Collision_obj_spinner.gml
func _collision_obj_spinner(other: GMObject) -> void:
	_user_1()


# from objects/obj_coin/Collision_obj_superball.gml
func _collision_obj_superball(other: GMObject) -> void:
	_user_1()


# from objects/obj_coin/Other_10.gml
func _user_0() -> void:
	var col_enemy
	var col_enemy_held
	var col_munchers
	var col_bosses
	var col_clown
	var col_bullet
	var col_powerup
	var col_cannon
	var _o: GMObject = GM.other
	GM.other = self
	col_enemy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_enemyparent, false, false)
	col_enemy_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_enemyparent_held, false, false)
	col_munchers = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_muncher, false, false)
	col_bosses = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bossparent, false, false)
	col_clown = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
	col_bullet = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
	col_powerup = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_powerupparent, false, false)
	col_cannon = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_cannon, false, false)
	if col_enemy != null and place_meeting(x, y, A.obj_enemyparent):
		if col_enemy.object_index != A.obj_grinder and col_enemy.object_index != A.obj_podoboo and col_enemy.object_index != A.obj_boo and col_enemy.object_index != A.obj_banzaibill and col_enemy.object_index != A.obj_bulletbill and col_enemy.object_index != A.obj_cannonball and col_enemy.object_index != A.obj_cannonball_red and col_enemy.object_index != A.obj_cheepcheep:
			if col_enemy.object_index == A.obj_bobomb or col_enemy.object_index == A.obj_bobomb_ready:
				for inst in GM.with_list(col_enemy):
					GM.instance_create(inst.x, inst.y, A.obj_explosion)
					inst.instance_destroy()
			else:
				for inst in GM.with_list(col_enemy):
					inst.event_user(0)
	if col_enemy_held != null and col_enemy_held.held == 0.0 and place_meeting(x, y, A.obj_enemyparent_held):
		if col_enemy_held.object_index == A.obj_bobomb_hold:
			for inst in GM.with_list(col_enemy_held):
				GM.instance_create(inst.x, inst.y, A.obj_explosion)
				inst.instance_destroy()
		else:
			for inst in GM.with_list(col_enemy_held):
				inst.event_user(0)
	if col_munchers != null and place_meeting(x, y, A.obj_muncher):
		for inst in GM.with_list(col_munchers):
			inst.event_user(0)
	if col_bosses != null and place_meeting(x, y, A.obj_bossparent):
		for inst in GM.with_list(col_bosses):
			inst.event_user(0)
	if col_clown != null and place_meeting(x, y, A.obj_clown):
		for inst in GM.with_list(col_clown):
			inst.event_user(0)
	if col_bullet != null and place_meeting(x, y, A.obj_bullebill_base):
		for inst in GM.with_list(col_bullet):
			inst.event_user(0)
	if col_powerup != null and place_meeting(x, y, A.obj_powerupparent):
		for inst in GM.with_list(col_powerup):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	if col_cannon != null and place_meeting(x, y, A.obj_cannon):
		for inst in GM.with_list(col_cannon):
			inst.event_user(0)
	GM.other = _o


# from objects/obj_coin/Other_11.gml
func _user_1() -> void:
	GM.audio_stop_sound(Scr.scr_snd_coin(self))
	GM.audio_play_sound(Scr.scr_snd_coin(self), 0.0, false)
	G.coins += 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(0)
		inst.visible = false
	GM.other = _o
	if G.apariencia != 0.0:
		GM.instance_create(x, y, A.obj_sparkles_coin)
	instance_destroy()


# from objects/obj_coin/Other_12.gml
func _user_2() -> void:
	GM.audio_stop_sound(Scr.scr_snd_coin(self))
	GM.audio_play_sound(Scr.scr_snd_coin(self), 0.0, false)
	G.coins += 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(0)
		inst.visible = false
	GM.other = _o
	# region Efecto
	# Crear anillo
	for inst in GM.with_list(GM.instance_create_depth(x + 8.0, y + 8.0, -2.0, A.obj_blend_ring)):
		inst.image_blend = GM.make_colour_rgb(248.0, 216.0, 0.0)
	# Repetir 6 veces
	for _rep in range(6):
		for inst in GM.with_list(GM.instance_create_depth(x + 8.0, y + 8.0, -2.0, A.obj_sparkles_blend)):
			inst.sprite_index = A.spr_sparkles_blend
			inst.gravity = 0.2
			inst.set("shrink_rate", 0.0324)
			inst.motion_set(GM.random_range(80.0, 100.0), GM.random_range(1.0, 3.0))
	# endregion
	instance_destroy()


# from objects/obj_coin/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
	if wings == 1.0:
		if G.apariencia > 1.0:
			GM.draw_sprite(int(sprite_wings), wings_anim, x, y)
		else:
			GM.draw_sprite(int(sprite_wings), wings_anim, (x + 8.0), y)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
