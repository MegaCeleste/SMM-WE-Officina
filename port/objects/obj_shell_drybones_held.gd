# from objects/obj_shell_drybones_held（第 5 批移植，已核对）
extends "res://objects/obj_shell_held.gd"

var imdead2 = null
var imdead3 = null


# from objects/obj_shell_drybones_held/Other_10.gml
func _user_0() -> void:
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	match G.apariencia:
		0.0:
			s_dry = A.spr_SMB_shell_drybones_deads
		1.0:
			s_dry = A.spr_SMB3_shell_drybones_deads
		2.0:
			s_dry = A.spr_shell_drybones_deads2
		3.0:
			s_dry = A.spr_NSMBU_shell_drybones_deads
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = int(s_dry)  # PORT: s_dry 声明为 float（存的是 sprite 编号），赋给 int 型 sprite_index 时显式转换
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.direct = direct
	imdead.gravity = 0.16
	imdead2 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead2.girar = 1.0
	imdead2.sprite_index = int(s_dry)
	imdead2.image_speed = 0.0
	imdead2.image_index = 1.0
	imdead2.direct = direct
	imdead2.gravity = 0.16
	imdead3 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead3.girar = 1.0
	imdead3.sprite_index = int(s_dry)
	imdead3.image_speed = 0.0
	imdead3.image_index = 2.0
	imdead3.direct = direct
	imdead3.gravity = 0.16
	imdead.hspeed = -0.5
	imdead.vspeed = -0.5
	imdead2.hspeed = -0.5
	imdead3.hspeed = 0.5
	instance_destroy()


# from objects/obj_shell_drybones_held/Other_11.gml
func _user_1() -> void:
	GM.instance_create(x, y, A.obj_shell_drybones)
	instance_destroy()


# from objects/obj_shell_drybones_held/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
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
		var block_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		var block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		if hspeed < 0.0 and block_right != null and block_right.ready_v == 0.0:
			if block_right.object_index == A.obj_flipblock and G.apariencia == 1.0:
				for inst in GM.with_list(block_right):
					inst.alarm[2] = 1.0
			elif block_right.object_index == A.obj_onoffblock:
				var _o3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.event_user(1)
				GM.other = _o3
			else:
				var _o4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.ready_v = 1.0
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o4
		elif hspeed > 0.0 and block_left != null and block_left.ready_v == 0.0:
			if block_left.object_index == A.obj_flipblock and G.apariencia == 1.0:
				for inst in GM.with_list(block_left):
					inst.alarm[2] = 1.0
			elif block_left.object_index == A.obj_onoffblock:
				var _o5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.event_user(1)
				GM.other = _o5
			else:
				var _o6: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.ready_v = 1.0
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o6
		_user_0()


# from objects/obj_shell_drybones_held/Other_14.gml
func _user_4() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		var solidlava = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if solidlava != null and bbox_bottom < (solidlava.yprevious + 5.0):
			y = (solidlava.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_lava_water_drybones, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_lava_water_drybones, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif swimming <= 0.5:
		gravity = 0.22
		if vspeed > 7.0:
			vspeed = 7.0
	else:
		gravity = 0.02
		if vspeed > 2.0:
			vspeed = 2.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			# 原文是数字 40、103，按 port-plan §9 Q3 当作 obj_holdparent、obj_enemyparent_held
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_shell_drybones_held/Other_15.gml
func _user_5() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	imheld = GM.instance_create(x, (y - 2.0), A.obj_shell_drybones)
	imheld.sprite_index = sprite_index
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > i_lava_water.y and G.bg_level == "forest" and G.modo_noche == 0.0):
		imheld.vspeed = -1.8
	else:
		imheld.vspeed = -3.0
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = -0.5
	instance_destroy()
