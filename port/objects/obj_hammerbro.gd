# from objects/obj_hammerbro（第 6e 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var s_hammerbro: float = 0.0
var s_hammerbro_jump: float = 0.0
var s_hammerbro_throw: float = 0.0
var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var prev_hspeed: float = 0.0
var jump_high: float = 0.0
var throughsolid: float = 0.0
var jump_start: float = 0.0
var hammers: float = 0.0
var trow: float = 0.0
var throw_lanzar: float = 0.0
var salto: String = ""
var start: float = 0.0
var altura_max = null
var altura_min = null


# from objects/obj_hammerbro/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_hammerbro = A.spr_SMB_hammerbro
			s_hammerbro_jump = A.spr_SMB3_hammerbro_jump
			s_hammerbro_throw = A.spr_SMB_hammerbro_throw
			sprite_wings = A.spr_SMB_wings
		1.0:
			s_hammerbro = A.spr_SMB3_hammerbro
			s_hammerbro_jump = A.spr_SMB3_hammerbro_jump
			s_hammerbro_throw = A.spr_SMB3_hammerbro_throw
			sprite_wings = A.spr_SMB3_wings
		2.0:
			s_hammerbro = A.spr_hammerbro
			s_hammerbro_jump = A.spr_hammerbro_jump
			s_hammerbro_throw = A.spr_hammerbro_throw
			sprite_wings = A.spr_wings
		3.0:
			s_hammerbro = A.spr_NSMBU_hammerbro
			sprite_index = A.spr_NSMBU_hammerbro
			s_hammerbro_jump = A.spr_NSMBU_hammerbro_jump
			s_hammerbro_throw = A.spr_NSMBU_hammerbro_throw
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	dead_h = 0.0
	innave = 0.0
	direct = 1.0
	prev_hspeed = 0.4
	swimming = 0.0
	jump_high = -6.0
	throughsolid = 0.0
	jump_start = y
	hammers = (1.0 + GM.random(GM.gm_round(3.0)))
	trow = 0.0
	throw_lanzar = 0.0
	salto = "big"
	start = y
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.5
		alarm[7] = 360.0
	else:
		image_speed = 0.125
		alarm[1] = 360.0
	alarm[2] = 17.0


# from objects/obj_hammerbro/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x - (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = 1.0


# from objects/obj_hammerbro/Step_0.gml
func _step() -> void:
	_user_7()
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if paracaidas == 0.0:
		if throughsolid == 0.0:
			if hspeed <= 0.0 and x <= (xstart - 16.0):
				hspeed = (0.4 - (0.2 * swimming))
			elif hspeed >= 0.0 and x >= (xstart + 16.0):
				hspeed = (-((0.4 - (0.2 * swimming))))
		elif throughsolid > 0.0:
			hspeed = 0.0
		if vspeed > 0.0 and throughsolid == 1.0:
			throughsolid = 2.0
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
	if throughsolid == 0.0:
		_user_3()
		_user_4()
	else:
		if swimming == 1.0:
			gravity = 0.15
			if vspeed > 1.0:
				vspeed = 1.0
				gravity = 0.0
		else:
			gravity = 0.25
			if vspeed > 4.0:
				vspeed = 4.0
				gravity = 0.0
		if throughsolid == 2.0 and vspeed > 0.0:
			var ss = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, ((bbox_bottom + 1.0) + vspeed), A.obj_solidtop, false, false)
			var ps = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, ((bbox_bottom + 1.0) + vspeed), A.obj_physicssolid, false, false)
			if ss != null and ((salto == "small" and y > start) or salto == "big") and (not place_meeting((ss.x + 8.0), (ss.y - 16.0), A.obj_solid)) and ((not place_meeting((ss.x + 8.0), (ss.y - 16.0), A.obj_modelbgo)) or place_meeting((ss.x + 8.0), (ss.y - 16.0), A.obj_modelbgo_dec)) and (not place_meeting((ss.x + 8.0), (ss.y - 16.0), A.obj_physicssolid)):
				throughsolid = 0.0
				vspeed = 0.0
				y = (ss.y - 16.0)
				if G.apariencia < 3.0:
					hspeed = prev_hspeed
			elif ps != null and ((salto == "small" and y > start) or salto == "big") and (not place_meeting((ps.x + 8.0), (ps.y - 16.0), A.obj_solid)) and ((not place_meeting((ps.x + 8.0), (ps.y - 16.0), A.obj_modelbgo)) or place_meeting((ps.x + 8.0), (ps.y - 16.0), A.obj_modelbgo_dec)) and (not place_meeting((ps.x + 8.0), (ps.y - 16.0), A.obj_physicssolid)):
				throughsolid = 0.0
				vspeed = 0.0
				y = (ps.y - 16.0)
				if G.apariencia < 3.0:
					hspeed = prev_hspeed
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if wings == 1.0 and GM.instance_exists(A.obj_mario):
		if G.apariencia == 3.0:
			if gravity > 0.0:
				wings_anim += 1.5
			else:
				wings_anim += 1.0
		elif gravity > 0.0:
			wings_anim += 0.2
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
			hspeed = 0.0
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


# from objects/obj_hammerbro/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 3.0:
		return
	if not GM.instance_exists(A.obj_deadmario):
		if gravity > 0.0:
			if trow == 1.0:
				sprite_index = s_hammerbro_throw
				image_speed = 0.0
				image_index = (trow - 1.0)
			elif trow == 0.0 and G.apariencia == 2.0:
				sprite_index = s_hammerbro_jump
				image_speed = 0.0
			else:
				sprite_index = s_hammerbro
				image_speed = 0.125
		else:
			image_speed = 0.125
			if trow == 0.0:
				sprite_index = s_hammerbro
			elif trow > 0.5:
				sprite_index = s_hammerbro_throw
				image_index = (trow - 1.0)


# from objects/obj_hammerbro/Alarm_1.gml
func _alarm_1() -> void:
	if vspeed == 0.0:
		if wings == 1.0:
			altura_max = (-((7.0 - (4.0 * swimming))))
			altura_min = (-((4.5 - (3.0 * swimming))))
		else:
			altura_max = (-((6.19 - (3.0 * swimming))))
			altura_min = (-((2.5 - (1.0 * swimming))))
		start = (y + 16.0)
		if G.apariencia < 3.0 and hspeed != 0.0:
			prev_hspeed = hspeed
		if collision_rectangle(bbox_left, (bbox_top - 40.0), bbox_right, (bbox_top - 40.0), A.obj_blockparent, false, false) != null and collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + 8.0), A.obj_blockparent, false, false) != null:
			if (not place_meeting(x, (y + 32.0), A.obj_solidtop)) and (not place_meeting(x, (y + 48.0), A.obj_solidtop)) and (not place_meeting(x, (y + 64.0), A.obj_solidtop)) and (not place_meeting(x, (y + 80.0), A.obj_solidtop)) and (not place_meeting(x, (y + 112.0), A.obj_solidtop)) and (not place_meeting(x, (y + 128.0), A.obj_solidtop)):
				vspeed = altura_max
				salto = "big"
				alarm[4] = 1.0
			elif floorf(GM.random(50.0)) < 25.0 and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
				vspeed = altura_max
				salto = "big"
				alarm[4] = 1.0
			elif (y + 16.0) < GM.room_height and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
				vspeed = altura_min
				salto = "small"
				alarm[4] = 1.0
			else:
				vspeed = altura_max
				salto = "big"
				alarm[4] = 1.0
		elif collision_rectangle(bbox_left, (bbox_top - 40.0), bbox_right, (bbox_top - 40.0), A.obj_blockparent, false, false) != null and (y + 16.0) < GM.room_height and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
			vspeed = altura_max
			salto = "big"
			alarm[4] = 1.0
		elif collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + 8.0), A.obj_blockparent, false, false) != null and (y + 16.0) < GM.room_height and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
			vspeed = altura_min
			salto = "small"
			alarm[4] = 1.0
		else:
			vspeed = altura_max
			salto = "big"
			alarm[4] = 1.0
		if swimming == 1.0:
			gravity = 0.2
		else:
			gravity = 0.25
		if G.apariencia == 3.0:
			alarm[7] = 360.0
		else:
			alarm[1] = 360.0
	else:
		alarm[0] = 360.0


# from objects/obj_hammerbro/Alarm_2.gml
func _alarm_2() -> void:
	if sprite_index == A.spr_NSMBU_hammerbro_jump:
		alarm[2] = 5.0
		return
	if hammers > 0.0:
		trow = 1.0
		hammers -= 1.0
		if hspeed != 0.0:
			prev_hspeed = hspeed
		hspeed = 0.0
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_hammerbro_throw
			image_index = 0.0
			image_speed = 0.5
		else:
			alarm[3] = 10.0
			alarm[2] = 20.0
	else:
		trow = 0.0
		hammers = (0.0 + GM.random(GM.gm_round(3.0)))
		hspeed = prev_hspeed
		if G.apariencia == 3.0:
			alarm[2] = 120.0
		else:
			alarm[2] = 80.0


# from objects/obj_hammerbro/Alarm_3.gml
func _alarm_3() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_hammer_throw)
		GM.audio_play_sound(A.snd_NSMBU_hammer_throw, 0.0, false)
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x > x:
			for inst in GM.with_list(GM.instance_create((x - 5.0), (y - 8.0), A.obj_brohammer)):
				inst.hspeed = 1.5
				inst.direct = 1.0
		elif GM.instance_find(A.obj_mario, 0).x < x:
			for inst in GM.with_list(GM.instance_create((x + 5.0), (y - 8.0), A.obj_brohammer)):
				inst.hspeed = -1.5
				inst.direct = -1.0
	else:
		for inst in GM.with_list(GM.instance_create((x + 5.0), (y - 8.0), A.obj_brohammer)):
			inst.hspeed = (1.5 * self.direct)
			inst.direct = self.direct
	trow = 2.0
	if G.apariencia != 3.0:
		alarm[6] = 5.0


# from objects/obj_hammerbro/Alarm_4.gml
func _alarm_4() -> void:
	throughsolid = 1.0


# from objects/obj_hammerbro/Alarm_5.gml
func _alarm_5() -> void:
	throughsolid = 2.0


# from objects/obj_hammerbro/Alarm_6.gml
func _alarm_6() -> void:
	trow = 0.0
	hspeed = prev_hspeed


# from objects/obj_hammerbro/Alarm_7.gml
func _alarm_7() -> void:
	if sprite_index == A.spr_NSMBU_hammerbro_throw:
		alarm[7] = 5.0
		return
	sprite_index = A.spr_NSMBU_hammerbro_jump
	image_index = 0.0
	image_speed = 0.5
	if hspeed != 0.0:
		prev_hspeed = hspeed
	hspeed = 0.0


# from objects/obj_hammerbro/Alarm_10.gml
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


# from objects/obj_hammerbro/Other_7.gml
func _animation_end() -> void:
	if G.apariencia != 3.0:
		pass
	if sprite_index == A.spr_NSMBU_hammerbro_throw:
		sprite_index = A.spr_NSMBU_hammerbro
		image_speed = 0.5
		alarm[2] = 10.0
		alarm[6] = 1.0
	elif sprite_index == A.spr_NSMBU_hammerbro_jump:
		sprite_index = A.spr_NSMBU_hammerbro
		image_speed = 0.5
		hspeed = prev_hspeed


# from objects/obj_hammerbro/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 3.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_hammerbro_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_hammerbro_deads
		2.0:
			imdead.sprite_index = A.spr_hammerbro_deads
		3.0:
			imdead.sprite_index = s_hammerbro
	if G.apariencia == 3.0:
		imdead.image_index = 9.0
	else:
		match object_index:
			A.obj_firebro:
				imdead.image_index = 1.0
			A.obj_icebro:
				imdead.image_index = 2.0
			A.obj_boomerangbro:
				imdead.image_index = 3.0
			_:
				imdead.image_index = 0.0
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


# from objects/obj_hammerbro/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		_user_0()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0
		alarm[10] = 2.0


# from objects/obj_hammerbro/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
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
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0


# from objects/obj_hammerbro/Other_14.gml
func _user_4() -> void:
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_hammerbro/Other_17.gml
func _user_7() -> void:
	if G.apariencia == 3.0:
		if sprite_index == A.spr_NSMBU_hammerbro_throw:
			if image_index >= 17.0 and image_index < 17.5:
				alarm[3] = 1.0
		elif sprite_index == A.spr_NSMBU_hammerbro_jump:
			if image_index >= 7.0 and image_index < 7.5:
				alarm[1] = 1.0
			elif image_index >= 17.0 and vspeed != 0.0 and image_speed != 0.0:
				image_speed = 0.0
				image_index = 17.0
			elif vspeed == 0.0 and image_index > 7.5:
				if image_index <= 17.0:
					image_index = 18.0
					image_speed = 0.5


# from objects/obj_hammerbro/Other_25.gml
func _user_15() -> void:
	if vspeed == 0.0:
		if wings == 1.0:
			altura_max = (-((8.0 - (4.0 * swimming))))
			altura_min = (-((4.5 - (3.0 * swimming))))
		else:
			altura_max = (-((6.19 - (3.0 * swimming))))
			altura_min = (-((2.5 - (1.0 * swimming))))
		if collision_rectangle(bbox_left, (bbox_top - 40.0), bbox_right, (bbox_top - 40.0), A.obj_blockparent, false, false) != null and collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + 8.0), A.obj_blockparent, false, false) != null:
			if floorf(GM.random(50.0)) < 25.0 and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
				vspeed = altura_max
				alarm[4] = 2.0
				alarm[5] = 16.0
			elif (y + 16.0) < GM.room_height and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
				vspeed = altura_min
				alarm[4] = 2.0
				alarm[5] = 35.0
			else:
				vspeed = altura_max
				alarm[4] = 2.0
				alarm[5] = 16.0
		elif collision_rectangle(bbox_left, (bbox_top - 40.0), bbox_right, (bbox_top - 40.0), A.obj_blockparent, false, false) != null and (y + 16.0) < GM.room_height and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
			vspeed = altura_max
			alarm[4] = 2.0
			alarm[5] = 16.0
		elif collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + 8.0), A.obj_blockparent, false, false) != null and (y + 16.0) < GM.room_height and (y + 32.0) < GM.room_height and (y + 48.0) < GM.room_height and (y + 64.0) < GM.room_height:
			vspeed = altura_min
			alarm[4] = 2.0
			alarm[5] = 35.0
		else:
			vspeed = altura_max
			alarm[4] = 2.0
			alarm[5] = 35.0
		y -= 1.0
		if swimming == 1.0:
			gravity = 0.2
		else:
			gravity = 0.25
		if G.apariencia == 3.0:
			alarm[7] = 360.0
		else:
			alarm[1] = 360.0
	else:
		alarm[1] = 360.0


# from objects/obj_hammerbro/Draw_0.gml
func _gm_draw() -> void:
	var ypos: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		if G.apariencia == 3.0:
			ypos = 27.0
		else:
			ypos = 22.0
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (12.0 * direct)), (y - ypos), direct, 1.0, 0.0, GM.c_white, 1.0)
