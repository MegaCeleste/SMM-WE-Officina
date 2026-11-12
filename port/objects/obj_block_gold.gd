# from objects/obj_block_gold（第 5 批移植，已核对）
extends "res://objects/obj_block_multicoin.gd"

var w_wings: float = 0.0
var cont_coin: float = 0.0
var limit_coins: float = 0.0


# from objects/obj_block_gold/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_qblock
			image_index = 5.0
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_qblock_gold
			image_speed = 0.15
		2.0:
			sprite_index = A.spr_flipblock_gold
			image_speed = 0.15
		3.0:
			sprite_index = A.spr_NSMBU_block_gold
			image_speed = 0.2
	ready_v = 0.0
	cointime = 0.0
	wings = 0.0
	w_wings = 0.0
	cont_coin = 0.0
	limit_coins = 100.0
	s_scalex = 1.0
	s_scaley = 1.0
	expand = 0.0


# from objects/obj_block_gold/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	if cointime == 2.0:
		GM.audio_stop_sound(A.snd_NSMBU_coinappear)
		GM.audio_play_sound(A.snd_NSMBU_coinappear, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin_pow)):
			inst.hspeed = -1.0
			inst.vspeed = -2.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin_pow)):
			inst.hspeed = -0.5
			inst.vspeed = -2.2
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin_pow)):
			inst.hspeed = -0.6
			inst.vspeed = -2.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin_pow)):
			inst.hspeed = 1.0
			inst.vspeed = -2.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin_pow)):
			inst.hspeed = 0.5
			inst.vspeed = -2.2
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin_pow)):
			inst.hspeed = -0.6
			inst.vspeed = -2.0
		GM.instance_create(x, y, A.obj_smoke)
		instance_destroy()
	else:
		ready_v = 0.0


# from objects/obj_block_gold/Other_10.gml
func _user_0() -> void:
	if cointime == 2.0 and cont_coin >= 11.0:
		GM.instance_create(x, y, A.obj_blockcoin)
		limit_coins -= 1.0
		if limit_coins <= 0.0:
			GM.instance_create(x, y, A.obj_smoke)
			instance_destroy()
	else:
		GM.instance_create(x, y, A.obj_blockcoin)
		cont_coin += 1.0
		if cointime == 0.0:
			cointime = 1.0
			alarm[4] = 320.0


# from objects/obj_block_gold/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)  # obj_levelmanager.banim 读：第 16 条
		anim = lm.banim
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, x, y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
