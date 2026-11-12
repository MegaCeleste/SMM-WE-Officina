extends "res://objects/obj_beachkoopa.gd"


# from objects/obj_beachkoopa_b/Step_0.gml
func _step() -> void:
	var shell
	super._step()
	if jumping == 1.0:
		swimming = 0.0
	if ready_v == 0.0:
		if gravity == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.05)) * GM.gm_sign(hspeed))
		if hspeed < 0.05 and hspeed > -0.05:
			hspeed = 0.0
			image_speed = 0.15
			ready_v = 1.0
			alarm[10] = 90.0
	elif ready_v > 0.0:
		if (sprite_index == A.spr_beachkoopa_walk_b or sprite_index == A.spr_beachkoopa_walk_red_b) and ready_v == 1.0 and (collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 4.0), A.obj_shell, false, false) == null):
			ready_v = 2.0
		elif ready_v == 2.0:
			shell = collision_rectangle((x + (10.0 * GM.gm_sign(direct))), bbox_top, (x + (16.0 * GM.gm_sign(direct))), (bbox_bottom - 4.0), A.obj_shell, false, false)
			if shell != null and shell.held == 0.0 and shell.sprite_height > 16.0:
				if shell.koopainside == 0.0 and jumping == 0.0:
					jumping = 1.0
					y -= 1.0
					hspeed = (0.6 * GM.gm_sign(direct))
					if swimming == 1.0:
						vspeed = -1.6
					else:
						vspeed = -4.0
				elif shell.koopainside != 0.0:
					hspeed = (-hspeed)
			if jumping == 1.0 and gravity == 0.0 and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_shell, false, false) == null):
				jumping = 0.0
				if absf(hspeed) > 0.5:
					hspeed = (0.5 * GM.gm_sign(direct))
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0


# from objects/obj_beachkoopa_b/Alarm_10.gml
func _alarm_10() -> void:
	if ready_v > 0.0:
		y -= 1.0
		if not (swimming > 0.5):
			vspeed = -2.5
		else:
			vspeed = -1.125
		super._alarm_10()
		if sprite_index == A.spr_beachkoopa_b:
			sprite_index = A.spr_beachkoopa_walk_b


# from objects/obj_beachkoopa_b/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	if other.held == 1.0:
		super._collision_obj_shell(other)
	elif jumping == 1.0 and ready_v == 2.0 and other.sprite_index == A.spr_shell_b and place_meeting(x, (y - 4.0), other):
		for inst in GM.with_list(other):
			inst.sprite_index = A.spr_shell_inside_b
			inst.koopainside = 1.0
			inst.key = self.key
			inst.alarm[3] = 1.0
			inst.alarm[5] = 1.0
			inst.alarm[7] = 70.0
		instance_destroy()


# from objects/obj_beachkoopa_b/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = sprite_index
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
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


# from objects/obj_beachkoopa_b/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
		inst.sprite_index = A.spr_koopa_sq_b
		if self.object_index == A.obj_beachkoopa_red_b:
			inst.image_index = 1.0
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	instance_destroy()


# from objects/obj_beachkoopa_b/Other_13.gml
func _user_3() -> void:
	# ORIG-BUG: 原版 col_enemy_shell_right（左侧检测）也配的是 hspeed > 0（疑似应为 < 0），照搬
	var col_enemy_shell_left
	var col_enemy_shell_right
	var col_one_left
	var col_one_right
	col_enemy_shell_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false)
	col_enemy_shell_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false)
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and col_enemy_shell_left != null and col_enemy_shell_left.held == 0.0 and col_enemy_shell_left.sprite_index != A.spr_shell_b) or (hspeed > 0.0 and col_enemy_shell_right != null and col_enemy_shell_right.held == 0.0 and col_enemy_shell_right.sprite_index != A.spr_shell_b):
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
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if ready_v == 0.0:
			hspeed = 0.0
		else:
			hspeed = (-hspeed)
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
