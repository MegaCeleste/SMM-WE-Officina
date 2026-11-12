# from objects/obj_coin10（第 5 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var active: float = 0.0


# from objects/obj_coin10/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB_coin_10_dark
				"ghost":
					sprite_index = A.spr_SMB_coin_10_night
				"underground":
					sprite_index = A.spr_SMB_coin_10_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_10_night
					else:
						sprite_index = A.spr_SMB_coin_10
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_coin_10_dark
				"ghost":
					sprite_index = A.spr_SMB3_coin_10_night
				"underground":
					sprite_index = A.spr_SMB3_coin_10_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_10_night
					else:
						sprite_index = A.spr_SMB3_coin_10
		2.0:
			sprite_index = A.spr_coin_10
		3.0:
			sprite_index = A.spr_NSMBU_coin_10
	active = 0.0
	image_speed = 0.15


# from objects/obj_coin10/Step_0.gml
func _step() -> void:
	if y > (ystart - 20.0) and vspeed > 0.0:
		instance_destroy()


# from objects/obj_coin10/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var o = other
	if o.held == 0.0:
		_user_0()


# from objects/obj_coin10/Collision_obj_link_arrow.gml
func _collision_obj_link_arrow(other: GMObject) -> void:
	_user_0()


# from objects/obj_coin10/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	_user_0()


# from objects/obj_coin10/Collision_obj_player_goal_parent.gml
func _collision_obj_player_goal_parent(other: GMObject) -> void:
	_user_0()


# from objects/obj_coin10/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	_user_0()


# from objects/obj_coin10/Other_10.gml
func _user_0() -> void:
	if active == 0.0:
		active = 1.0
		_user_1()
		_user_2()
		vspeed = -3.0
		gravity = 0.2
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
			inst.visible = false
		GM.other = _o
		if G.apariencia != 0.0:
			GM.instance_create((x + 8.0), y, A.obj_sparkles_coin)
		image_speed = 0.5
		alarm[0] = 30.0


# from objects/obj_coin10/Other_11.gml
func _user_1() -> void:
	match G.apariencia:
		2.0:
			GM.audio_stop_sound(A.snd_coin10)
			GM.audio_play_sound(A.snd_coin10, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_coin10)
			GM.audio_play_sound(A.snd_NSMBU_coin10, 0.0, false)
		_:
			GM.audio_stop_sound(A.snd_SMB3_coin10)
			GM.audio_play_sound(A.snd_SMB3_coin10, 0.0, false)


# from objects/obj_coin10/Other_12.gml
func _user_2() -> void:
	match object_index:
		A.obj_coin10:
			G.coins += 10.0
		A.obj_coin30:
			G.coins += 30.0
		A.obj_coin50:
			G.coins += 50.0


# from objects/obj_coin10/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if active == 0.0:
		if image_speed == 0.0:
			anim = image_index
		else:
			var lm = GM.instance_find(A.obj_levelmanager, 0)
			anim = lm.banim
		GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
