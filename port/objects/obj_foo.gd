extends "res://objects/obj_deactenemyparent.gd"

var s_foo_idle: float = 0.0
var s_foo_mist: float = 0.0
var pos_y: float = 0.0
var edible: float = 0.0
var cfoo: float = 0.0
var wings_anim: float = 0.0
var timer: float = 0.0
var sound = null
var dead: float = 0.0
var blowtime: float = 0.0


# from objects/obj_foo/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_foo_idle
			s_foo_idle = A.spr_SMB_foo_idle
			s_foo_mist = A.spr_SMB_foo_mist
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_foo_idle
			s_foo_idle = A.spr_SMB3_foo_idle
			s_foo_mist = A.spr_SMB3_foo_mist
			image_speed = 0.0
		2.0:
			sprite_index = A.spr_foo_idle
			s_foo_idle = A.spr_foo_idle
			s_foo_mist = A.spr_foo_mist
			image_speed = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_foo_idle
			s_foo_idle = A.spr_NSMBU_foo_idle
			s_foo_mist = A.spr_NSMBU_foo_mist
			image_speed = 0.25
	if G.apariencia == 3.0:
		pos_y = 10.0
	else:
		pos_y = 9.0
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	dead_h = 0.0
	modo_lava = 0.0
	cfoo = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	swimming = 0.0
	apilar = 0.0
	timer = 0.0
	sound = -4.0
	dead = 0.0
	blowtime = 200.0


# from objects/obj_foo/Destroy_0.gml
func _destroy() -> void:
	if G.apariencia == 3.0 and sound != -4.0:
		GM.audio_stop_sound(sound)


# from objects/obj_foo/Step_0.gml
func _step() -> void:
	if dead == 1.0:
		return
	if G.apariencia != 3.0:
		y = (ystart + (sin((timer * 0.04375)) * 2.0))
		timer += 1.0
	if sprite_index == s_foo_mist:
		if cfoo == 1.0:
			for inst in GM.with_list(GM.instance_create(x, (y + pos_y), A.obj_foo_fog)):
				if self.direct == 1.0:
					inst.motion_set(GM.random_range(-15.0, 15.0), GM.random_range(1.0, 1.5))
				else:
					inst.motion_set(GM.random_range(165.0, 195.0), GM.random_range(1.0, 1.5))
			cfoo = 2.0
		else:
			cfoo -= 1.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if blowtime <= 200.0:
		if G.apariencia == 3.0:
			if sprite_index == A.spr_NSMBU_foo_mist:
				image_speed = 0.5
			else:
				if sprite_index != A.spr_NSMBU_foo_prepare:
					sprite_index = A.spr_NSMBU_foo_prepare
					image_index = 0.0
					image_speed = 0.5
				if image_index >= 30.5:
					sprite_index = A.spr_NSMBU_foo_mist
					image_index = 0.0
					if G.apariencia == 3.0:
						sound = GM.audio_play_sound(A.snd_foo, 0.0, false)
		else:
			sprite_index = s_foo_mist
			match G.apariencia:
				0.0:
					image_speed = 0.0
				1.0:
					image_speed = 0.0
				2.0:
					image_speed = 0.15
	elif blowtime > 200.0:
		sprite_index = s_foo_idle
		if G.apariencia == 3.0:
			image_speed = 0.25
		else:
			image_speed = 0.0
	blowtime -= 1.0
	if blowtime < 0.0:
		blowtime = 600.0


# from objects/obj_foo/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_foo_deads:
		_user_0()


# from objects/obj_foo/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 3.0:
		if dead == 0.0:
			dead = 1.0
			sprite_index = A.spr_NSMBU_foo_deads
			image_speed = 0.5
			image_index = 0.0
		else:
			GM.audio_stop_sound(A.snd_foo_dead)
			GM.audio_play_sound(A.snd_foo_dead, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, (y + 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_smoke_foo
			instance_destroy()
	else:
		for _rep in range(2):
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_foo_fog)):
				inst.motion_set(GM.random(360.0), GM.random_range(0.25, 0.5))
				inst.scale = 0.5
		instance_destroy()


# from objects/obj_foo/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_foo/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), direct, 1.0, 0.0, GM.c_white, 1.0)
