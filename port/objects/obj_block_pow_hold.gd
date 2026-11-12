# from objects/obj_block_pow_hold（第 5 批移植，已核对）
# PORT: mytop 在“没有”时存 A.obj_lighting（int，原版用 obj_lighting 当占位），有时存实例。
# GDScript 里 Object 和 int 用 ==/!= 比较会报运行时错误，所以占位判断统一写 is_same()。
extends "res://objects/obj_holdparent.gd"

# explode 由 obj_holdparent 声明（第 4 批补）
var mytop = null


# from objects/obj_block_pow_hold/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pow
		1.0:
			sprite_index = A.spr_SMB3_pow
		2.0:
			sprite_index = A.spr_block_pow
		3.0:
			sprite_index = A.spr_NSMBU_pow
	image_speed = 0.15
	explode = 0.0
	inmune = 0.0
	mytop = GM.instance_create(x, y, A.obj_solidphy)


# from objects/obj_block_pow_hold/Destroy_0.gml
func _destroy() -> void:
	super._destroy()
	if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()


# from objects/obj_block_pow_hold/Step_1.gml
func _step_begin() -> void:
	if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop) and GM.instance_exists(A.obj_mario):
		mytop.x = x
		mytop.y = y


# from objects/obj_block_pow_hold/Step_0.gml
func _step() -> void:
	var col_mario
	var col_estalactita
	var col_mario_left
	var col_mario_right
	var col_shell1
	var col_shell2
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if y < -20.0 and vspeed < 0.0:
		y = -20.0
	col_mario = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_mario, true, false)
	if GM.instance_exists(A.obj_mario):
		if col_mario != null and G.powerup == -77.0 and G.yoshi == 0.0 and i_mario.can_break_block == 1.0:
			explode = 1.0
			_user_6()
			for inst in GM.with_list(A.obj_mario):
				inst.jumpnow = 2.0
				inst.state = 2.0
				inst.alarm[4] = 15.0
				if inst.isswim == 1.0:
					inst.vspeed = -2.0
				else:
					inst.vspeed = -4.0
				inst.y -= 1.0
		elif col_mario != null and col_mario.groundpount == 2.0:
			explode = 1.0
			_user_6()
	if collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, (bbox_top + 6.0), A.obj_mario, false, false) != null and inmune == 0.0 and modo_lava == 0.0 and vspeed > 0.0 and i_mario.state < 2.0 and gravity != 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.075)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.075:
			hspeed = 0.0
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
	col_estalactita = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_icicle, true, false)
	if col_estalactita != null and col_estalactita.vspeed > 0.0 and held == 0.0:
		explode = 1.0
		_user_6()
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_estalactita):
			inst.event_user(0)
		GM.other = _o2
	if held == 0.0:
		col_mario_left = collision_rectangle((bbox_left - 6.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_mario, false, false)
		col_mario_right = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 6.0), (bbox_bottom - 4.0), A.obj_mario, false, false)
		if GM.instance_exists(A.obj_mario) and ((col_mario_left != null and i_mario.direct == 1.0) or (col_mario_right != null and i_mario.direct == -1.0)) and Scr.scr_canhold(self) > 0.5 and inmune == 0.0:
			if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
				for inst in GM.with_list(mytop):
					inst.instance_destroy()
				mytop = A.obj_lighting
			for inst in GM.with_list(A.obj_mario):
				inst.holding = 2.0
			if G.apariencia == 2.0 and i_mario.isduck == 1.0:
				for inst in GM.with_list(A.obj_mario):
					inst.isduckhold = 1.0
			if G.apariencia == 3.0:
				GM.audio_play_sound(GM.choose(A.snd_NSMBU_hold1, A.snd_NSMBU_hold2), 0.0, false)
				for inst in GM.with_list(GM.other):  # UNSURE: Step 事件里的 other.id，原版意图疑为 obj_mario；按字面取 GM.other（U14，同 obj_holdparent/Step_0）
					# PORT: 此处 GM.other 是本实例（obj_block_pow_hold），它没有声明 triple_jump/triple_count，直接赋值会报错，改用 set()（不存在时静默无效）
					inst.triple_jump = 0.0
					inst.triple_count = 0.0
			held = 1.0
			explode = 0.0
			depth = -7.0
			gravity = 0.0
			speed = 0.0
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
			swimming = 1.0
		else:
			swimming = 0.0
		if GM.instance_exists(A.obj_mario):
			if inwall == 0.0:
				col_shell1 = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_enemyparent_held, false, false)
				if col_shell1 != null and col_shell1.vspeed < 0.0 and col_shell1.held == 0.0:
					explode = 1.0
					_user_6()
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(col_shell1):
						inst.event_user(0)
					GM.other = _o3
				col_shell2 = collision_rectangle((bbox_left - 1.0), (bbox_top + 2.0), (bbox_right + 1.0), (bbox_bottom - 2.0), A.obj_shell_held, false, false)
				if col_shell2 != null and col_shell2.bbox_bottom > (bbox_top + 5.0):
					explode = 1.0
					_user_6()
					var _o4: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(col_shell2):
						inst.event_user(0)
					GM.other = _o4
				_user_3()
				_user_4()
				if gravity == 0.0:
					if swimming == 0.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.145)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.145:
							hspeed = 0.0
					elif swimming == 1.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.245)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.244:
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
		elif GM.instance_exists(A.obj_deadmario):
			vspeed = 0.0
			gravity = 0.0
		else:
			_user_3()
			_user_4()
		if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (i_lava_water.y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
			if G.apariencia != 0.0:
				GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_lava)
			modo_lava = 1.0
		elif GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= i_lava_water.y and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
			if G.apariencia != 0.0:
				GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_posion)
			modo_lava = 1.0
		elif GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= i_lava_water.y and G.bg_level == "mountain" and G.modo_noche == 1.0 and modo_lava == 0.0:
			if G.apariencia != 0.0:
				GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_lava)
			modo_lava = 1.0
		elif y > GM.room_height and held == 0.0:
			instance_destroy()
		if GM.instance_exists(A.obj_lava_water) and (y + 8.0) <= (i_lava_water.y - 12.0) and i_lava_water.vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
			y = (i_lava_water.y - 20.0)
	elif not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()
		mytop = A.obj_lighting


# from objects/obj_block_pow_hold/Alarm_1.gml
func _alarm_1() -> void:
	inmune = 0.0
	if not place_meeting(x, y, A.obj_mario):
		if is_same(mytop, A.obj_lighting):
			mytop = GM.instance_create(x, y, A.obj_solidphy)
	else:
		alarm[1] = 1.0


# from objects/obj_block_pow_hold/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if held == 0.0 and other.vspeed < 0.0:
		explode = 1.0
		_user_6()


# from objects/obj_block_pow_hold/Collision_obj_boomboom.gml
func _collision_obj_boomboom(other: GMObject) -> void:
	if other.object_index != A.obj_grinder:
		if explode == 1.0:
			var _o5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.dead_h = 1.0
				inst.event_user(0)
			GM.other = _o5
			_user_6()
			instance_destroy()


# from objects/obj_block_pow_hold/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.object_index != A.obj_grinder:
		if explode == 1.0:
			var _o6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.dead_h = 1.0
				inst.event_user(0)
			GM.other = _o6
			_user_6()
			instance_destroy()


# from objects/obj_block_pow_hold/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if held == 0.0 and inmune == 0.0 and bouncy == 1.0:
		if hspeed > 0.0 and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			hspeed = (other.hspeed + 1.2)
			vspeed = -1.5
			explode = 0.0
		elif hspeed < 0.0 and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			hspeed = (other.hspeed - 1.2)
			vspeed = -1.5
			explode = 0.0
		elif hspeed > 0.0:
			hspeed = (other.hspeed + 1.2)
			vspeed = -1.5
			explode = 0.0


# from objects/obj_block_pow_hold/Collision_obj_thwomp.gml
func _collision_obj_thwomp(other: GMObject) -> void:
	if other.ready_v == 1.0 and held == 0.0:
		var _o7: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o7
		explode = 1.0
		_user_6()
	elif explode == 1.0:
		var _o8: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.dead_h = 1.0
			inst.event_user(0)
		GM.other = _o8
		_user_6()
		instance_destroy()


# from objects/obj_block_pow_hold/Other_12.gml
func _user_2() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if GM.keyboard_check(G.abajo):
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null:
			inwall = 1.0
			hspeed = 0.0
		hspeed = (1.0 * i_mario.direct)
		inmune = 1.0
		alarm[1] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
	elif GM.keyboard_check(G.arriba) and G.apariencia == 2.0:
		explode = 1.0
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o9: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o9
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) == null:
			if i_mario.hspeed == 0.0:
				hspeed = 0.0
			else:
				hspeed = (i_mario.direct / 2.0)
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				vspeed = -2.4
				swimming = 1.0
			else:
				vspeed = -7.0
		else:
			inwall = 1.0
		inmune = 1.0
		alarm[1] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
	else:
		explode = 1.0
		if G.apariencia == 3.0:
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_throw1, A.snd_NSMBU_throw2), 0.0, false)
		else:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
		var _o10: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o10
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		y += 1.0
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) == null:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				vspeed = -0.2
				swimming = 1.0
			else:
				vspeed = -1.2
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = ((1.0 + absf(i_mario.hspeed)) * GM.gm_sign(i_mario.direct))
			else:
				hspeed = ((3.0 + absf(i_mario.hspeed)) * GM.gm_sign(i_mario.direct))
		else:
			inwall = 1.0
		inmune = 1.0
		alarm[1] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0


# from objects/obj_block_pow_hold/Other_13.gml
func _user_3() -> void:
	var solidphy_right
	var solidphy_left
	var col_one_left
	var col_one_right
	var mi_solidphy_right
	var mi_solidphy_left
	solidphy_right = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false)
	solidphy_left = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false)
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and solidphy_right != null and ((not is_same(mytop, A.obj_lighting) and solidphy_right != mytop) or is_same(mytop, A.obj_lighting))) or (hspeed < 0.0 and solidphy_left != null and ((not is_same(mytop, A.obj_lighting) and solidphy_left != mytop) or is_same(mytop, A.obj_lighting))) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_helmet, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_helmet, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o11: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o11
		if hspeed < 0.0 and col_one_right != null:
			var _o12: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o12
		hspeed = 0.0
		_user_6()
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		mi_solidphy_right = collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false)
		mi_solidphy_left = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false)
		if mi_solidphy_right != null and mi_solidphy_right != mytop:
			x -= 1.0
		if mi_solidphy_left != null and mi_solidphy_left != mytop:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_block_pow_hold/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var solidphy
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
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			if bouncy == 1.0:
				if vspeed > 0.5:
					vspeed = ((-vspeed) / 2.0)
				else:
					vspeed = 0.0
					bouncy = 0.0
			else:
				vspeed = 0.0
				_user_6()
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o13: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o13
	elif modo_lava == 1.0:
		hspeed = 0.0
		gravity = 0.02
		if vspeed > 0.03:
			vspeed = 0.03
	elif swimming <= 0.5:
		if collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 2.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null:
			gravity = 0.2
			if vspeed > 3.0:
				vspeed = 3.0
		else:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		solidphy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false)
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_hurtsolid2, true, false) != null or (solidphy != null and not is_same(mytop, A.obj_lighting) and solidphy != mytop) or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_hurtsolid2, true, false) != null and (not place_meeting(x, y, A.obj_hurtsolid2)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o14: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o14
			block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o15: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o15
			vspeed = 0.0
			_user_6()


# from objects/obj_block_pow_hold/Other_16.gml
func _user_6() -> void:
	if explode == 1.0:
		Scr.init_shake(self, 1.0)
		GM.instance_create(x, y, A.obj_block_pow_active)
		instance_destroy()


# from objects/obj_block_pow_hold/Draw_0.gml
func _gm_draw() -> void:
	var i_levelmanager = GM.instance_find(A.obj_levelmanager, 0)
	var anim = i_levelmanager.banim
	GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
