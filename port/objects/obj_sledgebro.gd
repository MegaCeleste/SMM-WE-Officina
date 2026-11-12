# from objects/obj_sledgebro（第 6e 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var s_sledgebro: float = 0.0
var s_sledgebro_throw: float = 0.0
var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var volar: float = 0.0
var jumping: float = 0.0
var prev_hspeed: float = 0.0
var trow: float = 0.0


# from objects/obj_sledgebro/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_sledgebro = A.spr_SMB_sledgebro
			s_sledgebro_throw = A.spr_SMB_sledgebro_throw
			sprite_wings = A.spr_SMB_wings
		1.0:
			s_sledgebro = A.spr_SMB3_sledgebro
			s_sledgebro_throw = A.spr_SMB3_sledgebro_throw
			sprite_wings = A.spr_SMB3_wings
		2.0:
			s_sledgebro = A.spr_sledgebro
			s_sledgebro_throw = A.spr_sledgebro_throw
			sprite_wings = A.spr_wings
		3.0:
			s_sledgebro = A.spr_NSMBU_sledgebro
			sprite_index = A.spr_NSMBU_sledgebro
			s_sledgebro_throw = A.spr_NSMBU_sledgebro_throw
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	volar = 0.0
	apilar = 0.0
	dead_h = 0.0
	innave = 0.0
	swimming = 0.0
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	jumping = 0.0
	prev_hspeed = 0.0
	trow = 0.0
	alarm[1] = 480.0
	alarm[3] = 60.0


# from objects/obj_sledgebro/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = 1.0
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = -1.0


# from objects/obj_sledgebro/Step_0.gml
func _step() -> void:
	if G.apariencia == 3.0:
		if sprite_index == A.spr_NSMBU_sledgebro_throw:
			if image_index >= 13.0 and image_index < 13.5:
				alarm[4] = 1.0
		elif sprite_index == A.spr_NSMBU_sledgebro_jump:
			if image_index >= 3.0 and image_index < 3.5:
				alarm[2] = 1.0
			elif image_index >= 11.0 and vspeed != 0.0 and image_speed != 0.0:
				image_speed = 0.0
				image_index = 11.0
			elif vspeed == 0.0 and image_index > 3.5:
				if image_index <= 11.0:
					image_index = 12.0
					image_speed = 0.5
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if vspeed == 0.0 and hspeed <= 0.0 and x <= (xstart - 16.0) and paracaidas == 0.0:
		if swimming == 1.0:
			hspeed = 0.2
		else:
			hspeed = 0.4
	elif vspeed == 0.0 and hspeed >= 0.0 and x >= (xstart + 16.0) and paracaidas == 0.0:
		if swimming == 1.0:
			hspeed = -0.2
		else:
			hspeed = -0.4
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
		if hspeed > 0.3:
			hspeed -= 0.08
			if hspeed <= 0.3:
				hspeed = 0.3
		elif hspeed < -0.3:
			hspeed += 0.08
			if hspeed >= -0.3:
				hspeed = -0.3
	elif hspeed > 0.4:
		hspeed -= 0.08
		if hspeed <= 0.4:
			hspeed = 0.4
	elif hspeed < -0.4:
		hspeed += 0.08
		if hspeed >= -0.4:
			hspeed = -0.4
	_user_3()
	if volar == 0.0:
		_user_4()
	elif volar == 1.0:
		if y > (ystart + 8.0):
			if vspeed < -0.2:
				vspeed = -0.2
			else:
				vspeed -= 0.085
		elif y < (ystart - 8.0):
			if vspeed > 0.2:
				vspeed = 0.2
			else:
				vspeed += 0.085
	if gravity > 0.0:
		if jumping == 1.0 and vspeed > 0.0:
			jumping = 2.0
			if wings == 1.0:
				vspeed = 0.0
				gravity = 0.0
				volar = 1.0
				alarm[6] = 60.0
	elif gravity == 0.0:
		if jumping == 2.0 and volar == 0.0:
			GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
			if GM.instance_exists(A.obj_levelmanager):
				for inst in GM.with_list(A.obj_levelmanager):
					inst.alarm[11] = 1.0
			if GM.instance_exists(A.obj_mario):
				if GM.instance_find(A.obj_mario, 0).state < 2.0:
					for inst in GM.with_list(A.obj_mario):
						if G.apariencia == 3.0:
							GM.audio_play_sound(A.snd_NSMBU_stun, 0.0, false)
						else:
							if not GM.instance_exists(A.obj_shake_mario):
								GM.instance_create(inst.x, (inst.y + 5.0), A.obj_shake_mario)
						inst.stuntime = 80.0
						inst.hspeed = 0.0
						inst.disablecontrols = 1.0
			jumping = 0.0
			if G.apariencia != 3.0:
				alarm[5] = 15.0
			GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
			GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if wings == 1.0 and (not GM.instance_exists(A.obj_deadmario)):
		if volar == 1.0 or gravity > 0.0:
			wings_anim += 0.18
		else:
			wings_anim += 0.12
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
			alarm[10] = 10.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_sledgebro/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 3.0:
		return
	if not GM.instance_exists(A.obj_deadmario):
		if gravity > 0.0:
			sprite_index = s_sledgebro
			if G.apariencia < 2.0:
				image_speed = 0.15
			else:
				image_speed = 0.0
				if vspeed > 0.0:
					image_index = 1.0
				else:
					image_index = 0.0
		elif trow == 0.0:
			sprite_index = s_sledgebro
			image_speed = 0.125
		elif trow > 0.5:
			sprite_index = s_sledgebro_throw
			image_speed = 0.0
			image_index = (trow - 1.0)


# from objects/obj_sledgebro/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		if sprite_index == A.spr_NSMBU_sledgebro_throw:
			alarm[1] = 5.0
			return
		sprite_index = A.spr_NSMBU_sledgebro_jump
		image_index = 0.0
		image_speed = 0.5
		if hspeed != 0.0:
			prev_hspeed = hspeed
		hspeed = 0.0
	elif vspeed == 0.0 and sprite_index != A.spr_sledgebro_throw and sprite_index != A.spr_SMB3_sledgebro_throw and sprite_index != A.spr_SMB_sledgebro_throw:
		if hspeed != 0.0:
			prev_hspeed = hspeed
		alarm[3] = -1.0
		alarm[4] = -1.0
		alarm[4] = -1.0
		alarm[3] = 80.0
		hspeed = 0.0
		alarm[2] = 30.0
	else:
		alarm[1] = 1.0


# from objects/obj_sledgebro/Alarm_2.gml
func _alarm_2() -> void:
	vspeed = (-(6.0 - (3.0 * swimming)))
	jumping = 1.0
	alarm[1] = 490.0


# from objects/obj_sledgebro/Alarm_3.gml
func _alarm_3() -> void:
	if sprite_index == A.spr_NSMBU_sledgebro_jump:
		alarm[3] = 5.0
		return
	if gravity == 0.0 and volar == 0.0:
		trow = 1.0
		if hspeed != 0.0:
			prev_hspeed = hspeed
		hspeed = 0.0
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_sledgebro_throw
			image_index = 0.0
			image_speed = 0.5
		else:
			alarm[4] = 10.0
			alarm[3] = 80.0
	else:
		alarm[3] = 1.0


# from objects/obj_sledgebro/Alarm_4.gml
func _alarm_4() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_hammer_throw)
		GM.audio_play_sound(A.snd_NSMBU_hammer_throw, 0.0, false)
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x > x:
			for inst in GM.with_list(GM.instance_create(x, (y - 10.0), A.obj_brohammer)):
				if G.apariencia == 3.0:
					inst.sprite_index = A.spr_NSMBU_hammer2
				inst.hspeed = 1.5
				inst.direct = 1.0
		elif GM.instance_find(A.obj_mario, 0).x < x:
			for inst in GM.with_list(GM.instance_create(x, (y - 10.0), A.obj_brohammer)):
				if G.apariencia == 3.0:
					inst.sprite_index = A.spr_NSMBU_hammer2
				inst.hspeed = -1.5
				inst.direct = -1.0
	else:
		for inst in GM.with_list(GM.instance_create(x, (y - 10.0), A.obj_brohammer)):
			if G.apariencia == 3.0:
				inst.sprite_index = A.spr_NSMBU_hammer2
			inst.hspeed = -1.5
			inst.direct = -1.0
	trow = 2.0
	if G.apariencia != 3.0:
		alarm[5] = 5.0


# from objects/obj_sledgebro/Alarm_5.gml
func _alarm_5() -> void:
	trow = 0.0
	hspeed = prev_hspeed


# from objects/obj_sledgebro/Alarm_6.gml
func _alarm_6() -> void:
	volar = 0.0
	vspeed = 2.0


# from objects/obj_sledgebro/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if paracaidas == 1.0:
			hspeed = -0.5
		elif (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
				hspeed = -0.3
			else:
				hspeed = -0.4
		elif G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			hspeed = 0.3
		else:
			hspeed = 0.4


# from objects/obj_sledgebro/Other_7.gml
func _animation_end() -> void:
	if G.apariencia != 3.0:
		pass
	if sprite_index == A.spr_NSMBU_sledgebro_throw:
		sprite_index = A.spr_NSMBU_sledgebro
		image_speed = 0.5
		alarm[3] = 80.0
		alarm[5] = 1.0
	elif sprite_index == A.spr_NSMBU_sledgebro_jump:
		sprite_index = A.spr_NSMBU_sledgebro
		image_speed = 0.5
		hspeed = prev_hspeed


# from objects/obj_sledgebro/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_sledgebro
		1.0:
			imdead.sprite_index = A.spr_SMB3_sledgebro
		2.0:
			imdead.sprite_index = A.spr_sledgebro
		3.0:
			imdead.sprite_index = A.spr_NSMBU_sledgebro
			imdead.image_index = 7.0
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
	instance_destroy()


# from objects/obj_sledgebro/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		_user_0()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0
		alarm[10] = 2.0


# from objects/obj_sledgebro/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		if hspeed != 0.0:
			hspeed = (-hspeed)
			prev_hspeed = hspeed
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
		if (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
				x += 1.0


# from objects/obj_sledgebro/Draw_0.gml
func _gm_draw() -> void:
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (6.0 * direct)), (y - 4.0), 1.0, 1.0, image_angle, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		if direct == 1.0:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x - 14.0), (y - 26.0), direct, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x + 14.0), (y - 26.0), direct, 1.0, 0.0, GM.c_white, 1.0)
