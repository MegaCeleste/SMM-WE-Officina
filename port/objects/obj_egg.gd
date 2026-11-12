# from objects/obj_egg（第 5 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var motion: Array = []
var anim: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var jumping: float = 0.0
var wings_anim: float = 0.0
var i = null  # 只在 Alarm_1 里赋值（for 循环变量，是实例变量）


# from objects/obj_egg/Create_0.gml
func _create() -> void:
	if G.apariencia < 2.0:
		hardness = 0.0
		stomp = 0.0
		edible = 1.0
		alarm[2] = 7.0
		alarm[10] = 2.0
		image_speed = 0.15
	else:
		hardness = 100.0
		stomp = -1.0
		edible = 2.0
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_egg
			image_speed = 0.0
			alarm[10] = 2.0
		else:
			image_speed = 0.0
			alarm[10] = 2.0
	GM.aset(motion, 0, 45.0)
	GM.aset(motion, 1, 60.0)
	GM.aset(motion, 2, 120.0)
	GM.aset(motion, 3, 135.0)
	anim = 0.0
	ready_v = 0.0
	direct = -1.0
	jumping = 0.0
	swimming = 0.0
	modo_lava = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	innave = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	apilar = 0.0


# from objects/obj_egg/Step_0.gml
func _step() -> void:
	if G.apariencia < 2.0:
		if gravity == 0.0 and jumping == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.2)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.2:
				hspeed = 0.0
		hardness = 0.0
		stomp = 0.0
		edible = 1.0
		if G.apariencia == 0.0:
			if object_index == A.obj_egg_red:
				sprite_index = A.spr_SMB_goomba_shoe_red
			else:
				sprite_index = A.spr_SMB_goomba_shoe
		elif object_index == A.obj_egg_red:
			sprite_index = A.spr_SMB3_goomba_shoe_red
		else:
			sprite_index = A.spr_SMB3_goomba_shoe
		super._step()
		if jumping == 2.0 and gravity == 0.0:
			hspeed = 0.0
			jumping = 0.0
			alarm[10] = 60.0
		if vspeed >= 0.0 and jumping == 1.0:
			jumping = 2.0
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
		if paracaidas == 1.0:
			direct = -1.0
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
			if gravity == 0.0:
				GM.instance_create(x, y, A.obj_paracaidas_go)
				paracaidas = 0.0
				hspeed = 0.0
				alarm[10] = 10.0
	else:
		if gravity == 0.0 and wings == 0.0 and paracaidas == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.2)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.2:
				hspeed = 0.0
		hardness = 100.0
		stomp = -1.0
		edible = 2.0
		if G.apariencia != 3.0:
			if object_index == A.obj_egg_red:
				sprite_index = A.spr_egg_red
			elif object_index == A.obj_egg_blue:
				sprite_index = A.spr_egg_blue
			else:
				sprite_index = A.spr_egg
		if wings == 0.0 or paracaidas == 1.0:
			super._step()
		if gravity == 0.0 and wings == 0.0 and paracaidas == 0.0:
			if ready_v == 0.0:
				ready_v = 1.0
				alarm[0] = 30.0
		if wings == 1.0 and paracaidas == 0.0:
			if G.apariencia == 3.0:
				wings_anim += 0.5
			else:
				wings_anim += 0.12
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
		if paracaidas == 1.0:
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
			if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_mario, true, false) != null:
				paracaidas = 0.0
				if GM.instance_exists(A.obj_mario):
					if GM.instance_find(A.obj_mario, 0).vspeed < 0.0:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = 0.0
						vspeed = -1.5
			if gravity == 0.0:
				GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
				paracaidas = 0.0
				hspeed = 0.0
				alarm[10] = 10.0


# from objects/obj_egg/Alarm_0.gml
func _alarm_0() -> void:
	if G.apariencia < 2.0:
		jumping = 1.0
		hspeed = -1.0
		if swimming == 0.0:
			vspeed = -4.4
		else:
			vspeed = -2.2
	else:
		GM.audio_play_sound(A.snd_hatch, 0.0, false)
		if G.apariencia == 2.0:
			image_index = 1.0
		depth = -2.0
		alarm[1] = 16.0


# from objects/obj_egg/Alarm_1.gml
func _alarm_1() -> void:
	match G.apariencia:
		0.0:
			jumping = 1.0
			hspeed = 1.0
			if swimming == 0.0:
				vspeed = -4.4
			else:
				vspeed = -2.2
		1.0:
			jumping = 1.0
			hspeed = 1.0
			if swimming == 0.0:
				vspeed = -4.4
			else:
				vspeed = -2.2
		2.0:
			i = 0.0
			while i < 4.0:
				for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
					inst.sprite_index = A.spr_egg_bits
					inst.motion_set(self.motion[int(self.i)], 4.0)
					inst.image_speed = 0.0
					inst.image_index = self.i
					inst.alarm[0] = 25.0
				i += 1.0
			visible = false
			alarm[2] = 2.0
		3.0:
			i = 0.0
			while i < 4.0:
				for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
					inst.sprite_index = A.spr_NSMBU_egg_bits
					inst.motion_set((30.0 + (15.0 * self.i)), 4.0)
					inst.image_speed = 0.0
					inst.image_index = self.i
					inst.alarm[0] = 25.0
				i += 1.0
			if G.apariencia == 2.0:  # ORIG-BUG: 在 case 3 里判断 apariencia == 2，恒为假，照搬
				alarm[2] = 2.0
			else:
				instance_destroy()


# from objects/obj_egg/Alarm_2.gml
func _alarm_2() -> void:
	var v  # 局部变量提升（GML 的 var 是函数作用域）
	if G.apariencia < 2.0:
		anim += 1.0
		alarm[2] = 7.0
	else:
		if G.apariencia == 3.0:
			v = 0.0
		else:
			v = 16.0
		if GM.instance_number(A.obj_yoshi_abandon) < 2 and GM.instance_number(A.obj_egg_hatch) < 2:
			GM.instance_create((x + 8.0), (y - v), A.obj_egg_hatch)
		instance_destroy()


# from objects/obj_egg/Alarm_10.gml
func _alarm_10() -> void:
	if G.apariencia < 2.0:
		if paracaidas == 1.0:
			hspeed = -0.6
		elif gravity == 0.0:
			image_speed = 0.3
			if not (ready_v > 0.5):
				ready_v = 1.0
		else:
			alarm[10] = 1.0
	elif wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.6 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	elif G.apariencia == 3.0:
		image_speed = 0.5


# from objects/obj_egg/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.apariencia > 1.0:
		if bbox_bottom < ((other.bbox_top - other.vspeed) + 5.0) and vspeed >= 0.0 and (wings == 1.0 or paracaidas == 1.0):
			if wings == 1.0:
				for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
					inst.direct = -1.0
				for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
					inst.sprite_index = A.spr_wings_dead2
					inst.direct = -1.0
				wings = 0.0
			paracaidas = 0.0
			other.vspeed = 0.0
			hspeed = 0.0
			vspeed = -1.6
		elif wings == 1.0 or paracaidas == 1.0:
			if wings == 1.0:
				for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
					inst.direct = -1.0
				for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
					inst.sprite_index = A.spr_wings_dead2
					inst.direct = -1.0
				wings = 0.0
			paracaidas = 0.0
			hspeed = 0.0
	else:
		super._collision_obj_mario(other)


# from objects/obj_egg/Other_7.gml
func _animation_end() -> void:
	if G.apariencia < 2.0:
		if ready_v == 1.0:
			ready_v = 0.0
			image_speed = 0.0
			image_index = 1.0
			if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
				alarm[0] = 10.0
			else:
				alarm[1] = 10.0


# from objects/obj_egg/Other_10.gml
func _user_0() -> void:
	if G.apariencia < 2.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_getshoe)):
			inst.dir = self.direct
			if self.object_index == A.obj_egg_red:
				inst.bota = 2.0
		imdead = GM.instance_create(x, y, A.obj_enemy_dead)
		imdead.girar = 1.0
		imdead.direct = direct
		imdead.sprite_index = A.spr_galoomba_deads
		imdead.image_index = G.apariencia
		if dead_h == 0.0:
			if GM.other.hspeed == 0.0:  # ORIG-BUG: 下面 other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
				if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
					imdead.hspeed = 1.0
				elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
					imdead.hspeed = -1.0
			elif GM.other.hspeed > 0.0:
				imdead.hspeed = 1.0
			elif GM.other.hspeed < 0.0:
				imdead.hspeed = -1.0
		else:
			imdead.hspeed = 0.0
			for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
		instance_destroy()


# from objects/obj_egg/Other_11.gml
func _user_1() -> void:
	if G.apariencia < 2.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_getshoe)):
			inst.dir = self.direct
			if self.object_index == A.obj_egg_red:
				inst.bota = 2.0
				match G.apariencia:
					0.0:
						inst.sprite_index = A.spr_SMB_kuriboshoe2
					1.0:
						inst.sprite_index = A.spr_kuriboshoe2
			else:
				match G.apariencia:
					0.0:
						inst.sprite_index = A.spr_SMB_kuriboshoe
					1.0:
						inst.sprite_index = A.spr_kuriboshoe
		_user_7()


# from objects/obj_egg/Other_17.gml
func _user_7() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_galoomba_deads
	imdead.image_index = G.apariencia
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:  # ORIG-BUG: 下面 other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_egg/Draw_0.gml
func _gm_draw() -> void:
	match G.apariencia:
		0.0:
			if object_index == A.obj_egg_red:
				GM.draw_sprite_ext(A.spr_SMB_kuriboshoe2, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			else:
				GM.draw_sprite_ext(A.spr_SMB_kuriboshoe, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if ready_v > 0.5:
				GM.draw_sprite_ext(sprite_index, -1.0, x, (GM.gm_round(y) - 15.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
		1.0:
			if object_index == A.obj_egg_red:
				GM.draw_sprite_ext(A.spr_kuriboshoe2, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			else:
				GM.draw_sprite_ext(A.spr_kuriboshoe, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if ready_v > 0.5:
				GM.draw_sprite_ext(sprite_index, -1.0, x, (GM.gm_round(y) - 15.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
		2.0:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			if wings == 1.0:
				GM.draw_sprite(A.spr_wings_items, wings_anim, x, y)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
		3.0:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			if wings == 1.0:
				GM.draw_sprite(A.spr_NSMBU_wings_items, wings_anim, x, y)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
