# from objects/obj_pink_coin（第 5 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var lock: float = 0.0


# from objects/obj_pink_coin/Create_0.gml
func _create() -> void:
	if G.checkpointroom != -4.0:
		if (G.pink_coin1_x == x and G.pink_coin1_y == y) or (G.pink_coin2_x == x and G.pink_coin2_y == y) or (G.pink_coin3_x == x and G.pink_coin3_y == y) or (G.pink_coin4_x == x and G.pink_coin4_y == y) or (G.pink_coin5_x == x and G.pink_coin5_y == y) or (G.pink_coin6_x == x and G.pink_coin6_y == y) or (G.pink_coin7_x == x and G.pink_coin7_y == y) or (G.pink_coin8_x == x and G.pink_coin8_y == y) or (G.pink_coin9_x == x and G.pink_coin9_y == y) or (G.pink_coin10_x == x and G.pink_coin10_y == y):
			instance_destroy()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pink_coin
		1.0:
			sprite_index = A.spr_SMB3_pink_coin
		2.0:
			sprite_index = A.spr_pink_coin
		3.0:
			sprite_index = A.spr_NSMBU_pink_coin
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.15
	alarm[0] = 1.0
	lock = 0.0


# from objects/obj_pink_coin/Step_0.gml
func _step() -> void:
	if y > (ystart - 8.0) and vspeed > 0.0:
		if G.pink_coins == G.pink_coins_total and lock == 0.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_key_appear)):
				inst.vspeed = -3.0
			if GM.instance_exists(A.obj_levelmanager):
				for inst in GM.with_list(A.obj_levelmanager):
					inst.pink_coins_draw = 0.0
		instance_destroy()


# from objects/obj_pink_coin/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create(((x - 3.0) + GM.random(GM.gm_round(22.0))), ((y - 3.0) + GM.random(GM.gm_round(22.0))), A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark_pinkcoin
		inst.image_speed = 0.16
	alarm[0] = 60.0


# from objects/obj_pink_coin/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var o = other
	if (GM.eq(image_speed, 0.15) or GM.eq(image_speed, 0.3)) and o.held == 0.0:
		_user_0()


# from objects/obj_pink_coin/Collision_obj_link_arrow.gml
func _collision_obj_link_arrow(other: GMObject) -> void:
	if GM.eq(image_speed, 0.15) or GM.eq(image_speed, 0.3):
		_user_0()


# from objects/obj_pink_coin/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.eq(image_speed, 0.15) or GM.eq(image_speed, 0.3):
		_user_0()


# from objects/obj_pink_coin/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if GM.eq(image_speed, 0.15) or GM.eq(image_speed, 0.3):
		_user_0()


# from objects/obj_pink_coin/Collision_obj_snow_ball.gml
func _collision_obj_snow_ball(other: GMObject) -> void:
	var o = other
	if (GM.eq(image_speed, 0.15) or GM.eq(image_speed, 0.3)) and o.held == 0.0:
		_user_0()


# from objects/obj_pink_coin/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	if GM.eq(image_speed, 0.15) or GM.eq(image_speed, 0.3):
		_user_0()


# from objects/obj_pink_coin/Other_10.gml
func _user_0() -> void:
	G.pink_coins += 1.0
	if G.pink_coins == G.pink_coins_total:
		GM.audio_play_sound(A.snd_pink_coin5, 0.0, false)
	else:
		match G.pink_coins:
			1.0:
				GM.audio_play_sound(A.snd_pink_coin1, 0.0, false)
			2.0:
				GM.audio_play_sound(A.snd_pink_coin2, 0.0, false)
			3.0:
				GM.audio_play_sound(A.snd_pink_coin3, 0.0, false)
			4.0:
				GM.audio_play_sound(A.snd_pink_coin4, 0.0, false)
	_user_1()
	vspeed = -3.0
	gravity = 0.2
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.visible = false
		inst.event_user(0)
	GM.other = _o
	if G.pink_coins == G.pink_coins_total:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.image_speed = 0.26
			inst.sprite_index = A.spr_pink_coin_get
	else:
		lock = 1.0
	if G.apariencia == 3.0:
		image_speed = 1.0
	else:
		image_speed = 0.4


# from objects/obj_pink_coin/Other_11.gml
func _user_1() -> void:
	if GM.instance_exists(A.obj_checkpoint):
		for inst in GM.with_list(A.obj_checkpoint):
			if inst.pink_coin1_x == 0.0:
				inst.pink_coin1_x = self.x
				inst.pink_coin1_y = self.y
			elif inst.pink_coin2_x == 0.0:
				inst.pink_coin2_x = self.x
				inst.pink_coin2_y = self.y
			elif inst.pink_coin3_x == 0.0:
				inst.pink_coin3_x = self.x
				inst.pink_coin3_y = self.y
			elif inst.pink_coin4_x == 0.0:
				inst.pink_coin4_x = self.x
				inst.pink_coin4_y = self.y
			elif inst.pink_coin5_x == 0.0:
				inst.pink_coin5_x = self.x
				inst.pink_coin5_y = self.y
			elif inst.pink_coin6_x == 0.0:
				inst.pink_coin6_x = self.x
				inst.pink_coin6_y = self.y
			elif inst.pink_coin7_x == 0.0:
				inst.pink_coin7_x = self.x
				inst.pink_coin7_y = self.y
			elif inst.pink_coin8_x == 0.0:
				inst.pink_coin8_x = self.x
				inst.pink_coin8_y = self.y
			elif inst.pink_coin9_x == 0.0:
				inst.pink_coin9_x = self.x
				inst.pink_coin9_y = self.y
			elif inst.pink_coin10_x == 0.0:
				inst.pink_coin10_x = self.x
				inst.pink_coin10_y = self.y


# from objects/obj_pink_coin/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
