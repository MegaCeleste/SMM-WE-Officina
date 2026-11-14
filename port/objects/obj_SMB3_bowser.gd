extends "res://objects/obj_bossparent.gd"

var groundpount: float = 0.0
var groundpount_cont: float = 0.0
var y_start: float = 0.0
var walk_jump: float = 0.0
var down_groundpount: float = 0.0
var stop_bowser: float = 0.0
var imdead = null


# from objects/obj_SMB3_bowser/Create_0.gml
func _create() -> void:
	super._create()
	groundpount = 0.0
	groundpount_cont = 0.0
	y_start = y
	walk_jump = 0.0
	cooldown = 0.0
	swimming = 0.0
	prevhspeed = 0.0
	image_speed = 0.1
	paracaidas = 0.0
	down_groundpount = 0.0
	firehitpoints = 40.0
	key = 0.0
	stop_bowser = 0.0
	alarm[10] = 2.0


# from objects/obj_SMB3_bowser/Step_0.gml
func _step() -> void:
	var ground_block
	if GM.instance_exists(A.obj_mario) and groundpount == 0.0:
		if GM.instance_find(A.obj_mario, 0).x > x:
			if stop_bowser == 0.0:
				hspeed = 0.2
			else:
				if prevhspeed == 0.0 and hspeed != 0.0:
					prevhspeed = hspeed
				hspeed = 0.0
		elif stop_bowser == 0.0:
			if prevhspeed != 0.0:
				hspeed = prevhspeed
				prevhspeed = 0.0
			else:
				hspeed = -0.2
		else:
			if prevhspeed == 0.0 and hspeed != 0.0:
				prevhspeed = hspeed
			hspeed = 0.0
	_user_3()
	_user_4()
	if gravity > 0.0:
		if groundpount == 2.0:
			gravity = 0.2
			if vspeed > 6.0:
				vspeed = 6.0
		else:
			gravity = 0.1
			if vspeed > 3.2:
				vspeed = 3.2
	if cooldown > 0.0:
		cooldown -= 1.0
	if groundpount_cont > 0.0:
		groundpount_cont -= 1.0
		ground_block = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_blockparent, false, false)
		if ground_block != null and ground_block.object_index != A.obj_noteblock and ground_block.object_index != A.obj_musicblock and ground_block.object_index != A.obj_noteblock_s and ground_block.ready_v == 0.0:
			if ground_block.object_index == A.obj_flipblock:
				for inst in GM.with_list(ground_block):
					inst.alarm[2] = 1.0
			else:
				var _other_1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(ground_block):
					inst.event_user(3)
				GM.other = _other_1
	if GM.instance_exists(A.obj_mario) and groundpount == 1.0:
		if (GM.instance_find(A.obj_mario, 0).x > (x - 16.0) and GM.instance_find(A.obj_mario, 0).x < (x + 16.0) and y < (y_start - 64.0)) or y < (y_start - 160.0) or (hspeed > 2.0 and x > (GM.instance_find(A.obj_mario, 0).x + 144.0)) or (hspeed < -2.0 and x < (GM.instance_find(A.obj_mario, 0).x - 144.0)) or y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 32.0) or down_groundpount == 1.0:
			sprite_index = A.spr_SMB3_bowser_attack
			image_speed = 0.0
			image_index = 0.0
			vspeed = 2.0
			hspeed = 0.0
			groundpount = 2.0
			down_groundpount = 0.0


# from objects/obj_SMB3_bowser/Step_2.gml
func _step_end() -> void:
	if sprite_index == A.spr_SMB3_bowser_walk:
		image_speed = 0.0
		if vspeed != 0.0 and groundpount == 0.0:
			image_index = 1.0
			stop_bowser = 0.0


# from objects/obj_SMB3_bowser/Alarm_0.gml
func _alarm_0() -> void:
	if vspeed == 0.0:
		# ORIG-BUG: 原版顶部检测重复检查 obj_bullebill_base，照搬。
		if collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null:
			vspeed = -0.5
		else:
			vspeed = GM.choose(-3.0, -1.5, -1.5, -3.0, -1.5)
		alarm[0] = 30.0
	else:
		alarm[0] = 30.0


# from objects/obj_SMB3_bowser/Alarm_1.gml
func _alarm_1() -> void:
	sprite_index = A.spr_SMB3_bowser_fire
	image_speed = 0.15
	image_index = 0.0


# from objects/obj_SMB3_bowser/Alarm_2.gml
func _alarm_2() -> void:
	GM.audio_play_sound(A.snd_SMB3_bowser_fire, 0.0, false)
	if direct == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 20.0), (y - 14.0), A.obj_bowser_fire)):
			inst.hspeed = (1.5 * self.direct)
			inst.direct = self.direct
			inst.decender = GM.choose(0.0, 1.0, 2.0, 1.0, 0.0, 2.0)
	else:
		for inst in GM.with_list(GM.instance_create((x - 20.0), (y - 14.0), A.obj_bowser_fire)):
			inst.hspeed = (1.5 * self.direct)
			inst.direct = self.direct
			inst.decender = GM.choose(0.0, 1.0, 2.0, 1.0, 0.0, 2.0)
	alarm[1] = GM.choose(90.0, 90.0, 60.0, 90.0)


# from objects/obj_SMB3_bowser/Alarm_3.gml
func _alarm_3() -> void:
	if vspeed == 0.0:
		sprite_index = A.spr_SMB3_bowser_walk
		image_speed = 0.0
		image_index = 0.0
		stop_bowser = 1.0
		y_start = y
		alarm[0] = -1.0
		alarm[1] = -1.0
		alarm[2] = -1.0
		alarm[11] = -1.0
		alarm[4] = 20.0
		alarm[3] = GM.choose(460.0, 660.0, 600.0, 460.0)
	else:
		alarm[3] = 2.0


# from objects/obj_SMB3_bowser/Alarm_4.gml
func _alarm_4() -> void:
	groundpount = 1.0
	# ORIG-BUG: 原版顶部检测重复检查 obj_bullebill_base，照搬。
	if collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null:
		vspeed = -0.5
	else:
		vspeed = -5.0
	stop_bowser = 0.0
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > (x - 24.0) and GM.instance_find(A.obj_mario, 0).x < (x + 24.0):
		return
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = -5.0
	else:
		hspeed = 5.0


# from objects/obj_SMB3_bowser/Alarm_5.gml
func _alarm_5() -> void:
	sprite_index = A.spr_SMB3_bowser_search
	image_speed = 0.1
	image_index = 0.0


# from objects/obj_SMB3_bowser/Alarm_10.gml
func _alarm_10() -> void:
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > x:
		hspeed = 0.2
	else:
		hspeed = -0.2
	alarm[0] = GM.choose(30.0, 20.0, 30.0)
	alarm[1] = 90.0
	alarm[11] = 30.0
	alarm[3] = GM.choose(360.0, 660.0, 600.0, 360.0)


# from objects/obj_SMB3_bowser/Alarm_11.gml
func _alarm_11() -> void:
	if vspeed == 0.0:
		alarm[11] = 30.0
		if GM.instance_exists(A.obj_mario):
			if (GM.instance_find(A.obj_mario, 0).x < x and direct == 1.0) or (GM.instance_find(A.obj_mario, 0).x > x and direct == -1.0):
				stop_bowser = 1.0
				sprite_index = A.spr_SMB3_bowser_turning
				image_speed = 0.15
				image_index = 0.0
				alarm[0] = -1.0
				alarm[1] = -1.0
				alarm[2] = -1.0
	else:
		alarm[11] = 10.0


# from objects/obj_SMB3_bowser/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and groundpount == 0.0 and groundpount_cont == 0.0:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			vspeed = -0.5
		else:
			vspeed = -1.5


# from objects/obj_SMB3_bowser/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_invincibility):
		return
	if G.yoshi > 0.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		if GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_find(A.obj_kuribo_drybones, 0).get("gran_golpe") == 1.0:
			GM.audio_play_sound(A.snd_SMB_kick, 0.0, false)
			var _other_2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _other_2
			for inst in GM.with_list(A.obj_kuribo_drybones):
				inst.gran_golpe = 0.0
			_user_0()
		else:
			_user_15()
			firehitpoints -= 1.0
			cooldown = 6.0
			if firehitpoints <= 0.0:
				_user_0()
			other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, (other.y + 16.0)))
			var _other_3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _other_3
	else:
		var _other_4: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)


		GM.other = _other_4
# from objects/obj_SMB3_bowser/Other_7.gml
func _animation_end() -> void:
	match sprite_index:
		A.spr_SMB3_bowser_fire:
			sprite_index = A.spr_SMB3_bowser_walk
			alarm[2] = 1.0
		A.spr_SMB3_bowser_turning:
			sprite_index = A.spr_SMB3_bowser_walk
			direct = (-direct)
			stop_bowser = 0.0
			hspeed = (0.3 * direct)
			alarm[0] = GM.choose(30.0, 20.0, 30.0)
			alarm[1] = 90.0
		A.spr_SMB3_bowser_search:
			sprite_index = A.spr_SMB3_bowser_walk
			image_index = 0.0
			groundpount = 0.0
			stop_bowser = 0.0
			hspeed = (0.3 * direct)
			alarm[0] = GM.choose(30.0, 20.0, 30.0)
			alarm[1] = 90.0
			alarm[11] = 2.0


# from objects/obj_SMB3_bowser/Other_10.gml
func _user_0() -> void:
	if key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	GM.audio_play_sound(A.snd_SMB3_bowser_dead, 0.0, false)
	imdead = GM.instance_create(x, y, A.obj_bowser_dead)
	imdead.direct = direct
	imdead.vspeed = -3.5
	if direct == 1.0:
		imdead.hspeed = -1.0
	else:
		imdead.hspeed = 1.0
	instance_destroy()


# from objects/obj_SMB3_bowser/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _other_5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_5
		if hspeed < 0.0 and col_one_right != null:
			var _other_6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_6
		if (direct == 1.0 and hspeed > 0.0) or groundpount != 0.0:
			if groundpount != 0.0:
				down_groundpount = 1.0
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


# from objects/obj_SMB3_bowser/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
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
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _other_7: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_7
			if sprite_index == A.spr_SMB3_bowser_walk:
				image_index = 0.0
				stop_bowser = 1.0
			if groundpount == 2.0:
				image_index = 1.0
				GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
				if GM.instance_exists(A.obj_levelmanager):
					for inst in GM.with_list(A.obj_levelmanager):
						inst.alarm[11] = 1.0
				if GM.instance_exists(A.obj_mario):
					if GM.instance_find(A.obj_mario, 0).get("state") < 2.0:
						for inst in GM.with_list(A.obj_mario):
							if not GM.instance_exists(A.obj_shake_mario):
								GM.instance_create(inst.x, (inst.y + 5.0), A.obj_shake_mario)
							inst.shake = 1.0
							inst.stuntime = 90.0
							inst.hspeed = 0.0
							inst.disablecontrols = 1.0
				GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
				GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
				alarm[5] = 30.0
				groundpount_cont = 5.0
				groundpount = 3.0
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _other_8: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_8
			if groundpount != 0.0:
				down_groundpount = 1.0
			vspeed = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)):
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		GM.audio_stop_sound(A.snd_SMB3_bowser_dead)
		GM.audio_play_sound(A.snd_SMB3_bowser_dead, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_bowser_dead)):
			inst.direct = self.direct
		instance_destroy()
	elif (bbox_top - 16.0) > GM.room_height and G.bg_level != "castle" and G.bg_level != "forest" and G.bg_level != "beach":
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		GM.audio_stop_sound(A.snd_SMB3_bowser_dead)
		GM.audio_play_sound(A.snd_SMB3_bowser_dead, 0.0, false)
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.dead_bowser = 1.0
				inst.alarm[11] = 120.0
		instance_destroy()
	_user_14()


# from objects/obj_SMB3_bowser/Draw_0.gml
func _gm_draw() -> void:
	if cooldown > 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.make_colour_rgb(255.0, 60.0, 109.0), (cooldown / 4.0))
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
