# from objects/obj_spike（第 6e 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var s_spike: float = 0.0
var s_spike_throw: float = 0.0
var s_spike_throw2: float = 0.0
var s_spike_throw3: float = 0.0
var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var ball = null
var cont_ball: float = 0.0
var startTime: float = 0.0
var sud_imagen = null
var s_part = null
var i: float = 0.0


# from objects/obj_spike/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_spike
			s_spike = A.spr_SMB_spike
			s_spike_throw = A.spr_SMB_spike_throw
			s_spike_throw2 = A.spr_SMB_spike_throw_night
			s_spike_throw3 = A.spr_SMB_spike_throw_snow
			sprite_wings = A.spr_SMB_wings
		1.0:
			sprite_index = A.spr_SMB3_spike
			s_spike = A.spr_SMB3_spike
			s_spike_throw = A.spr_SMB3_spike_throw
			s_spike_throw2 = A.spr_SMB3_spike_throw_night
			s_spike_throw3 = A.spr_SMB3_spike_throw_snow
			sprite_wings = A.spr_SMB3_wings
		2.0:
			s_spike = A.spr_spike
			s_spike_throw = A.spr_spike_throw
			s_spike_throw2 = A.spr_spike_throw
			s_spike_throw3 = A.spr_spike_throw_snow
			sprite_wings = A.spr_wings
		3.0:
			sprite_index = A.spr_NSMBU_spike
			s_spike = A.spr_NSMBU_spike
			s_spike_throw = A.spr_NSMBU_spike_throw
			s_spike_throw2 = A.spr_NSMBU_spike_throw
			s_spike_throw3 = A.spr_NSMBU_spike_throw_snow
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	innave = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	direct = 1.0
	swimming = 0.0
	ready_v = 0.0
	apilar = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	ball = A.obj_lighting
	cont_ball = 0.0
	startTime = GM.current_time
	alarm[10] = 2.0
	alarm[0] = 3.0


# from objects/obj_spike/Destroy_0.gml
func _destroy() -> void:
	var _o: GMObject = GM.other
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x - (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
	if not GM.veq(ball, A.obj_lighting) and GM.instance_exists(ball):
		if G.bg_level == "snow":
			GM.other = self
			for inst in GM.with_list(ball):
				inst.event_user(0)
			GM.other = _o
		else:
			for inst in GM.with_list(ball):
				inst.instance_destroy()


# from objects/obj_spike/Step_0.gml
func _step() -> void:
	if wings == 0.0 or paracaidas == 1.0:
		super._step()
	if G.apariencia > 1.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
		if gravity == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.1:
				hspeed = 0.0
	elif wings == 0.0:
		if swimming == 1.0:
			if direct == 1.0 and hspeed > 0.3:
				hspeed -= 0.08
				if hspeed <= 0.3:
					hspeed = 0.3
			elif direct == -1.0 and hspeed < -0.3:
				hspeed += 0.08
				if hspeed >= -0.3:
					hspeed = -0.3
		elif direct == 1.0 and hspeed > 0.5:
			hspeed -= 0.08
			if hspeed <= 0.5:
				hspeed = 0.5
		elif direct == -1.0 and hspeed < -0.5:
			hspeed += 0.08
			if hspeed >= -0.5:
				hspeed = -0.5
	if wings == 1.0 and paracaidas == 0.0:
		if G.apariencia == 3.0:
			wings_anim += 0.5
		else:
			wings_anim += 0.12
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
		if y > (ystart + 32.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.015
		elif y < (ystart - 32.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.015
		if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
			if vspeed > 0.0:
				vspeed = -0.4
		elif vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_physicssolid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solidphy, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_bullebill_base, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null):
			vspeed = 0.4
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
			GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
			paracaidas = 0.0
			ystart = (y - 32.0)
			hspeed = 0.0
			alarm[10] = 10.0
	if paracaidas == 1.0:
		var oscillationSpeed = -0.1
		var elapsedTime = (GM.current_time - startTime) / GM.room_speed
		# Calcola l'angolo oscillante tra -12 e 12 gradi
		var oscillation = (sin(oscillationSpeed * elapsedTime) * 12.0)
		image_angle = oscillation
	else:
		image_angle = 0.0
	if not GM.veq(ball, A.obj_lighting):
		if GM.instance_exists(ball):
			ball.x = x
			ball.y = (y - 16.0)
		else:
			sprite_index = s_spike
			if G.apariencia == 3.0:
				image_speed = 0.5
			else:
				image_speed = 0.15
			if G.apariencia < 2.0:
				if cont_ball >= 1.0:
					cont_ball = 0.0
					if wings == 0.0:
						alarm[10] = 10.0
					alarm[0] = 180.0
				else:
					cont_ball += 1.0
					alarm[0] = 10.0
			else:
				alarm[0] = 180.0
			ball = A.obj_lighting


# from objects/obj_spike/Step_2.gml
func _step_end() -> void:
	var index
	var index2
	match G.apariencia:
		2.0:
			index = 8.1
			index2 = 8.4
		3.0:
			index = 8.0
			index2 = 8.5
		_:
			index = 8.0
			index2 = 8.2
	if sprite_index == s_spike_throw or sprite_index == s_spike_throw2 or sprite_index == s_spike_throw3:
		if image_index >= index and image_index < index2:
			alarm[1] = 1.0
		elif G.apariencia == 3.0 and image_index >= 24.0 and image_index <= 24.5:
			alarm[2] = 1.0


# from objects/obj_spike/Alarm_0.gml
func _alarm_0() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if gravity == 0.0:
		if wings == 0.0 and paracaidas == 0.0:
			alarm[10] = -1.0
			hspeed = 0.0
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		if G.bg_level == "snow":
			sprite_index = s_spike_throw3
		elif dark == 1.0:
			sprite_index = s_spike_throw2
		else:
			sprite_index = s_spike_throw
		match G.apariencia:
			2.0:
				image_speed = 0.3
			3.0:
				image_speed = 0.5
			_:
				image_speed = 0.2
	else:
		alarm[0] = 1.0


# from objects/obj_spike/Alarm_1.gml
func _alarm_1() -> void:
	if G.bg_level == "snow":
		ball = GM.instance_create(x, (y - 16.0), A.obj_snow_ball)
	else:
		ball = GM.instance_create(x, (y - 16.0), A.obj_spike_ball)
	ball.visible = false


# from objects/obj_spike/Alarm_2.gml
func _alarm_2() -> void:
	if not GM.veq(ball, A.obj_lighting):
		if GM.instance_exists(ball):
			if G.bg_level == "snow":
				for inst in GM.with_list(GM.instance_create(x, (y - 16.0), A.obj_snow_ball_held)):
					inst.hspeed = (1.2 * GM.gm_sign(self.direct))
					if G.apariencia > 1.0:
						inst.vspeed = -2.5
					inst.alarm[0] = 20.0
				for inst in GM.with_list(ball):
					inst.instance_destroy()
			else:
				for inst in GM.with_list(ball):
					inst.visible = true
					inst.hspeed = (1.2 * GM.gm_sign(self.direct))
					inst.ready_v = 1.0
					inst.alarm[0] = 20.0
			ball = A.obj_lighting
	if G.apariencia < 2.0:
		if cont_ball >= 1.0:
			cont_ball = 0.0
			if wings == 0.0:
				alarm[10] = 20.0
			alarm[0] = 180.0
		else:
			cont_ball += 1.0
			alarm[0] = 20.0
	else:
		alarm[0] = 180.0


# from objects/obj_spike/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 0.0 and G.apariencia < 2.0:
		hspeed = ((0.5 - (0.2 * swimming)) * direct)
	elif wings == 1.0 and paracaidas == 0.0:
		vspeed = 0.5
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
	elif paracaidas == 1.0:
		hspeed = -0.5


# from objects/obj_spike/Other_7.gml
func _animation_end() -> void:
	if sprite_index == s_spike_throw or sprite_index == s_spike_throw2 or sprite_index == s_spike_throw3:
		sprite_index = s_spike
		image_index = 0.0
		if G.apariencia != 3.0:
			image_speed = 0.15
			alarm[2] = 1.0
		else:
			image_speed = 0.5


# from objects/obj_spike/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_spike_deads
	imdead.image_index = G.apariencia
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
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
	if G.bg_level != "snow" and (sprite_index == s_spike_throw or sprite_index == s_spike_throw2 or sprite_index == s_spike_throw3):
		_user_7()
	instance_destroy()


# from objects/obj_spike/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		_user_0()
	elif wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x - (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0


# from objects/obj_spike/Other_17.gml
func _user_7() -> void:
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		sud_imagen = 1.0
	else:
		sud_imagen = 0.0
	match G.apariencia:
		0.0:
			if sud_imagen == 1.0:
				s_part = A.spr_SMB3_spike_ball_part_night
			else:
				s_part = A.spr_SMB3_spike_ball_part
		1.0:
			if sud_imagen == 1.0:
				s_part = A.spr_SMB3_spike_ball_part_night
			else:
				s_part = A.spr_SMB3_spike_ball_part
		2.0:
			s_part = A.spr_spike_ball_part
		3.0:
			s_part = A.spr_NSMBU_spike_ball_part
	i = 0.0
	while i < 6.0:
		imdead = GM.instance_create(x, y, A.obj_enemy_dead)
		imdead.girar = 1.0
		imdead.sprite_index = s_part
		imdead.image_index = GM.choose(0.0, 1.0, 2.0, 3.0)
		match i:
			0.0:
				imdead.vspeed = -2.0
			1.0:
				imdead.vspeed = -0.6
			2.0:
				imdead.hspeed = 0.6
			3.0:
				imdead.hspeed = 0.6
			4.0:
				imdead.hspeed = -0.6
			5.0:
				imdead.hspeed = -0.6
		i += 1.0
	instance_destroy()


# from objects/obj_spike/Draw_0.gml
func _gm_draw() -> void:
	var ypos
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		if G.apariencia == 3.0:
			ypos = 22.0
		else:
			ypos = 20.0
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (12.0 * direct)), (y - ypos), direct, 1.0, image_angle, GM.c_white, 1.0)
