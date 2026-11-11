extends "res://objects/obj_deactenemyparent.gd"

var cankill: float = 0.0
var ready_v: float = 0.0
var edible: float = 0.0
var kick: float = 0.0
var jumping: float = 0.0


# from objects/obj_beachkoopa/Create_0.gml
func _create() -> void:
	cankill = 0.0
	ready_v = 1.0
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	innave = 0.0
	direct = -1.0
	swimming = 0.0
	modo_lava = 0.0
	kick = 0.0
	jumping = 0.0
	dead_h = 0.0
	key = 0.0
	apilar = 0.0
	paracaidas = 0.0
	image_speed = 0.0
	alarm[10] = 2.0


# from objects/obj_beachkoopa/Step_0.gml
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
		if (sprite_index == A.spr_beachkoopa_walk or sprite_index == A.spr_beachkoopa_walk_red) and ready_v == 1.0 and (collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 4.0), A.obj_shell, false, false) == null):
			ready_v = 2.0
		elif ready_v == 2.0:
			shell = collision_rectangle((x + (5.0 * GM.gm_sign(direct))), bbox_top, (x + (8.0 * GM.gm_sign(direct))), (bbox_bottom - 4.0), A.obj_shell, false, false)
			if shell != null and shell.held == 0.0 and shell.sprite_height < 17.0:
				if shell.koopainside == 0.0 and jumping == 0.0:
					jumping = 1.0
					y -= 1.0
					if swimming == 1.0:
						vspeed = -1.2
					else:
						vspeed = -2.6
				elif shell.koopainside != 0.0:
					hspeed = (-hspeed)
			if jumping == 1.0 and gravity == 0.0:
				jumping = 0.0
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0


# from objects/obj_beachkoopa/Alarm_10.gml
func _alarm_10() -> void:
	if ready_v > 0.0:
		y -= 1.0
		vspeed = (-(2.0 - (1.375 * swimming)))
		super._alarm_10()
		if sprite_index == A.spr_beachkoopa:
			sprite_index = A.spr_beachkoopa_walk


# from objects/obj_beachkoopa/Alarm_11.gml
func _alarm_11() -> void:
	cankill = 1.0


# from objects/obj_beachkoopa/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0:
		vspeed = -2.0


# from objects/obj_beachkoopa/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if cankill == 1.0:
		if (sprite_index == A.spr_beachkoopa or sprite_index == A.spr_beachkoopa_red or sprite_index == A.spr_beachkoopa_b or sprite_index == A.spr_beachkoopa_red_b) and other.bbox_bottom >= ((bbox_top - vspeed) + 6.0):
			GM.audio_play_sound(A.snd_kick, 0.0, false)
			_user_0()
			for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
			for inst in GM.with_list(other):
				inst.event_user(7)
		else:
			super._collision_obj_mario(other)


# from objects/obj_beachkoopa/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	if other.held == 1.0:
		pass  # event_inherited(): 父类链无 Collision_obj_shell
	elif jumping == 1.0 and ready_v == 2.0 and other.sprite_index == A.spr_shell and place_meeting(x, (y - 4.0), other):
		for inst in GM.with_list(other):
			inst.sprite_index = A.spr_shell_inside
			inst.koopainside = 1.0
			inst.key = self.key
			inst.alarm[3] = 1.0
			inst.alarm[5] = 1.0
			inst.alarm[7] = 60.0
		instance_destroy()


# from objects/obj_beachkoopa/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	if sprite_index == A.spr_beachkoopa:
		imdead.sprite_index = A.spr_beachkoopa2_deads
	elif sprite_index == A.spr_beachkoopa_walk:
		imdead.sprite_index = A.spr_beachkoopa_deads
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
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


# from objects/obj_beachkoopa/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
		if self.object_index == A.obj_beachkoopa_red:
			inst.sprite_index = A.spr_koopa_sq_red
		else:
			inst.sprite_index = A.spr_koopa_sq
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	instance_destroy()


# from objects/obj_beachkoopa/Other_12.gml
func _user_2() -> void:
	if ready_v < 2.0:
		return
	super._user_2()


# from objects/obj_beachkoopa/Other_13.gml
func _user_3() -> void:
	var col_enemy_shell_left
	var col_enemy_shell_right
	var col_one_left
	var col_one_right
	col_enemy_shell_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false)
	col_enemy_shell_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false)
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and col_enemy_shell_left != null and col_enemy_shell_left.held == 0.0 and col_enemy_shell_left.sprite_index != A.spr_shell) or (hspeed > 0.0 and col_enemy_shell_right != null and col_enemy_shell_right.held == 0.0 and col_enemy_shell_right.sprite_index != A.spr_shell):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
		if hspeed < 0.0 and col_one_right != null:
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
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


# from objects/obj_beachkoopa/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
