# from objects/obj_enemyfrozen（第 5 批移植，已核对）
extends "res://objects/obj_enemyparent_held.gd"

var sprite = null  # 存 sprite 编号，由 obj_snowball 写入
var index: float = 0.0
var sprite_break: float = 0.0
var pos_y: float = 0.0
var enemy = null  # 存 object 编号，由 obj_snowball 写入
var vel: float = 0.0
var enable_gravity: float = 0.0
var rotacion: float = 0.0
var breaker: float = 0.0
var mytop = null  # 存实例，或 object 编号 obj_lighting（当作“已拆掉”的标记）
var object = null


# from objects/obj_enemyfrozen/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.0
	image_index = G.apariencia
	sprite = -4  # PORT: 存的是 sprite 编号（不是实例），-4 照原值写成 int，传给 draw_sprite_ext 的 int 形参
	index = 0.0
	if G.apariencia == 3.0:
		sprite_break = A.spr_frozenblock_break
	else:
		sprite_break = A.spr_icicle_break
	pos_y = 2.0
	direct = 1.0
	enemy = -4  # PORT: 存的是 object 编号（不是实例），-4 照原值写成 int
	shake = 0.0
	vel = 0.0
	enable_gravity = 1.0
	rotacion = 0.0
	breaker = 0.0
	mytop = GM.instance_create(x, y, A.obj_solidphy)
	mytop.image_xscale = (sprite_width / 16.0)
	alarm[7] = 2.0


# from objects/obj_enemyfrozen/Destroy_0.gml
func _destroy() -> void:
	# PORT: mytop 可能是实例也可能是 int（obj_lighting），GDScript 里 Object != int 是运行时错误，用 GM.veq
	if not GM.veq(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
			inst.isduckhold = 0.0
		for inst in GM.with_list(A.obj_player_warp):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_doormario):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_doormario_exit):
			inst.holding = 0.0


# from objects/obj_enemyfrozen/Step_1.gml
func _step_begin() -> void:
	if not GM.veq(mytop, A.obj_lighting) and GM.instance_exists(mytop) and GM.instance_exists(A.obj_mario):
		mytop.x = (x - bbox_left)
		mytop.y = (y - bbox_top)


# from objects/obj_enemyfrozen/Step_0.gml
func _step() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, (bbox_top + 6.0), A.obj_mario, false, false) != null and inmune == 0.0 and vspeed > 0.0 and i_mario.state < 2.0 and gravity != 0.0:
		for inst in GM.with_list(A.obj_mario):
			inst.x += hspeed
		for inst in GM.with_list(A.obj_mario):
			inst.y = ceilf((bbox_top - (31.0 - vspeed)))
		for inst in GM.with_list(A.obj_mario):
			inst.gravity = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = 0.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(15)
		GM.other = _o
	var col_estalactita = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_icicle, true, false)
	if col_estalactita != null and col_estalactita.vspeed > 0.0 and held == 0.0:
		_user_0()
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_estalactita):
			inst.event_user(0)
		GM.other = _o2
	if held == 0.0:
		var col_mario_left = collision_rectangle((bbox_left - 6.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_mario, false, false)
		var col_mario_right = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 6.0), (bbox_bottom - 4.0), A.obj_mario, false, false)
		if GM.instance_exists(A.obj_mario) and ((col_mario_left != null and i_mario.direct == 1.0) or (col_mario_right != null and i_mario.direct == -1.0)) and Scr.scr_canhold(self) > 0.5 and inmune == 0.0:
			if not GM.veq(mytop, A.obj_lighting) and GM.instance_exists(mytop):
				for inst in GM.with_list(mytop):
					inst.instance_destroy()
				mytop = A.obj_lighting
			for inst in GM.with_list(A.obj_mario):
				inst.holding = 2.0
			if G.apariencia == 3.0:
				GM.audio_play_sound(GM.choose(A.snd_NSMBU_hold1, A.snd_NSMBU_hold2), 0.0, false)
				for inst in GM.with_list(GM.other):  # UNSURE: Step 事件里的 other.id，原版意图疑为 obj_mario；按字面取 GM.other（同 obj_holdparent）
					inst.triple_jump = 0.0
					inst.triple_count = 0.0
			held = 1.0
			depth = -7.0
			gravity = 0.0
			speed = 0.0
			enable_gravity = 1.0
			alarm[4] = -1.0
			alarm[5] = -1.0
			alarm[6] = -1.0
		if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			swimming = 1.0
		else:
			swimming = 0.0
		if GM.instance_exists(A.obj_mario):
			if inwall == 0.0:
				var col_shell2 = collision_rectangle((bbox_left - 1.0), (bbox_top + 2.0), (bbox_right + 1.0), (bbox_bottom - 2.0), A.obj_shell_held, false, false)
				if col_shell2 != null and col_shell2.bbox_bottom > (bbox_top + 5.0):
					_user_0()
				if enable_gravity == 1.0:
					_user_3()
					_user_4()
				if gravity == 0.0:
					if swimming == 0.0:
						if absf(hspeed) >= 2.0:
							if hspeed > 0.0:
								if hspeed > 3.0:
									hspeed = 3.0
								else:
									hspeed += 0.1
							elif hspeed < 0.0:
								if hspeed < -3.0:
									hspeed = -3.0
								else:
									hspeed -= 0.1
						else:
							hspeed = (maxf(0.0, (absf(hspeed) - 0.145)) * GM.gm_sign(hspeed))
							if absf(hspeed) < 0.145:
								hspeed = 0.0
					elif swimming == 1.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.145)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.145:
							hspeed = 0.0
			else:
				gravity /= 2.0
				if vspeed > 1.0:
					vspeed = 1.0
				hspeed = 0.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x += 1.0
				if collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) == null:
					inwall = 0.0
		else:
			_user_3()
			_user_4()
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
			_user_0()
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_posion)
			_user_0()
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0 and modo_lava == 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
			_user_0()
		elif y > GM.room_height and held == 0.0:
			instance_destroy()
		if GM.instance_exists(A.obj_lava_water) and y <= (i_lava_water.y - 12.0) and swimming == 1.0:
			y = (i_lava_water.y - 12.0)
			vspeed = 0.0
		elif swimming == 1.0:
			if vspeed <= -0.4:
				vspeed = -0.4
			else:
				vspeed -= 0.04
	elif not GM.veq(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()
		mytop = A.obj_lighting


# from objects/obj_enemyfrozen/Alarm_4.gml
func _alarm_4() -> void:
	if swimming == 0.0:
		if shake == 0.0:
			x += 1.0
			shake = 1.0
		else:
			x -= 1.0
			shake = 0.0
		alarm[4] = 2.0


# from objects/obj_enemyfrozen/Alarm_5.gml
func _alarm_5() -> void:
	if swimming == 1.0:
		return
	if GM.instance_exists(A.obj_player_warp):
		alarm[5] = 240.0
	else:
		GM.audio_stop_sound(A.snd_NSMBU_estalactita_break)
		GM.audio_play_sound(A.snd_NSMBU_estalactita_break, 0.0, false)
		for inst in GM.with_list(GM.instance_create(GM.other.x, GM.other.y, A.obj_smoke)):  # UNVERIFIED(U14): Alarm 里的 other，兼容层设成实例自身
			inst.sprite_index = A.spr_NSMBU_smoke_foo
			inst.image_speed = 0.5
		for inst in GM.with_list(GM.instance_create((x + 6.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(45.0, 4.0)
			inst.sprite_index = A.spr_frozenblock_break
			inst.image_index = 0.0
			inst.dir = 1.0
		for inst in GM.with_list(GM.instance_create((x + 6.0), y, A.obj_shard)):
			inst.motion_set(60.0, 4.0)
			inst.sprite_index = A.spr_frozenblock_break
			inst.image_index = 1.0
			inst.dir = 1.0
		for inst in GM.with_list(GM.instance_create((x - 6.0), y, A.obj_shard)):
			inst.motion_set(120.0, 4.0)
			inst.sprite_index = A.spr_frozenblock_break
			inst.image_index = 2.0
			inst.dir = 0.0
		for inst in GM.with_list(GM.instance_create((x - 6.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(135.0, 4.0)
			inst.sprite_index = A.spr_frozenblock_break
			inst.image_index = 3.0
			inst.dir = 0.0
		if enemy == A.obj_shell_held:
			object = GM.instance_create(x, (y - 2.0), A.obj_shell)
			object.direct = direct
			object.sprite_index = sprite
		elif enemy == A.obj_piranhaplant:
			object = GM.instance_create(x, (y - 2.0), A.obj_jumppiranha)
			object.direct = direct
			object.sprite_index = sprite
		else:
			object = GM.instance_create(x, (y - 2.0), enemy)
			object.direct = direct
		instance_destroy()


# from objects/obj_enemyfrozen/Alarm_6.gml
func _alarm_6() -> void:
	enable_gravity = 1.0
	breaker = 1.0
	alarm[4] = -1.0


# from objects/obj_enemyfrozen/Alarm_7.gml
func _alarm_7() -> void:
	if held == 0.0:
		if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid):
			_user_0()


# from objects/obj_enemyfrozen/Other_10.gml
func _user_0() -> void:
	_user_8()
	for inst in GM.with_list(GM.instance_create((x + 6.0), (y + 8.0), A.obj_shard)):
		inst.motion_set(45.0, 4.0)
		inst.sprite_index = int(self.sprite_break)  # PORT: sprite_break 声明为 float（存 sprite 编号），赋给 int 型 sprite_index 时显式转换
		if G.apariencia == 3.0:
			inst.image_index = 0.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 6.0), y, A.obj_shard)):
		inst.motion_set(60.0, 4.0)
		inst.sprite_index = int(self.sprite_break)
		if G.apariencia == 3.0:
			inst.image_index = 1.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x - 6.0), y, A.obj_shard)):
		inst.motion_set(120.0, 4.0)
		inst.sprite_index = int(self.sprite_break)
		if G.apariencia == 3.0:
			inst.image_index = 2.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 0.0
	for inst in GM.with_list(GM.instance_create((x - 6.0), (y + 8.0), A.obj_shard)):
		inst.motion_set(135.0, 4.0)
		inst.sprite_index = int(self.sprite_break)
		if G.apariencia == 3.0:
			inst.image_index = 3.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 0.0
	object = GM.instance_create(x, (y + 8.0), enemy)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(object):
		inst.visible = false
		if inst.object_index == A.obj_shell or inst.object_index == A.obj_shell_held:
			inst.sprite_index = self.sprite
		inst.stomp = -1.0
		inst.event_user(0)
	GM.other = _o
	instance_destroy()


# from objects/obj_enemyfrozen/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
		_user_0()


# from objects/obj_enemyfrozen/Other_14.gml
func _user_4() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	var block
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	# ORIG-BUG: 括号位置与同类文件 (A && !B) || (C && !D) 不同，照搬原文的 A && (!B || C) && !D
	if collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and ((collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null) or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null) and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			if breaker == 1.0:
				_user_0()
			bouncy = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif modo_lava == 1.0:
		hspeed = 0.0
		gravity = 0.02
		if vspeed > 0.03:
			vspeed = 0.03
	elif swimming <= 0.5:
		gravity = 0.15
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_hurtsolid2, true, false) != null and (not place_meeting(x, y, A.obj_hurtsolid2)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			_user_0()
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_enemyfrozen/Other_18.gml
func _user_8() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_estalactita_break)
			GM.audio_play_sound(A.snd_estalactita_break, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_estalactita_break)
			GM.audio_play_sound(A.snd_NSMBU_estalactita_break, 0.0, false)


# from objects/obj_enemyfrozen/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite, index, GM.gm_round(x), (y - pos_y), direct, 1.0, rotacion, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 0.3)
