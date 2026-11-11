extends "res://objects/obj_deactivation.gd"

var swimming = null
var direct = null
var bouncy = null
var paracaidas = null


# from objects/obj_physicsparent/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	_user_3()
	_user_4()


# from objects/obj_physicsparent/Step_2.gml
func _step_end() -> void:
	pass  # 原文件为空


# from objects/obj_physicsparent/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0):
		if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
				vspeed = -1.8
			else:
				vspeed = -3.0


# from objects/obj_physicsparent/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_thwomp, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_thwomp, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
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
		if object_index == A.obj_galoomba_hold or object_index == A.obj_bobomb_hold:
			direct = (-direct)
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


# from objects/obj_physicsparent/Other_14.gml
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
	var bottomCheck1 = collision_rectangle(bbox_left, bbox_bottom - 1.0, bbox_right, bbox_bottom + 1.0, A.obj_solidtop, false, false)
	var bottomCheck2 = collision_rectangle(bbox_left, bbox_bottom - 4.0, bbox_right, bbox_bottom - 4.0, A.obj_solidtop, false, false)
	var slopeCheck = collision_rectangle(bbox_left, bbox_bottom - 1.0, bbox_right, bbox_bottom + 1.0, A.obj_slopeparent, true, false)
	var physicsSolidCheck1 = collision_rectangle(bbox_left, bbox_bottom - 1.0, bbox_right, bbox_bottom + 1.0, A.obj_physicssolid, false, false)
	var physicsSolidCheck2 = collision_rectangle(bbox_left, bbox_bottom - 4.0, bbox_right, bbox_bottom - 4.0, A.obj_physicssolid, false, false)
	if (bottomCheck1 != null and bottomCheck2 == null) or slopeCheck != null or (physicsSolidCheck1 != null and (physicsSolidCheck2 == null or slopeCheck != null)):
		gravity = 0.0
		if vspeed > 0.0:
			if GM.variable_instance_exists(self, "bouncy") and bouncy == 1.0:
				if vspeed > 0.5:
					vspeed = ((-vspeed) / 2.0)
				else:
					vspeed = 0.0
					bouncy = 0.0
			else:
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
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_bullebill_base, true, false) != null and (not place_meeting(x, y, A.obj_bullebill_base)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o
			vspeed = 0.0
	if ((bbox_top - 16.0) > GM.room_height and object_index != A.obj_player_goal_parent and object_index != A.obj_podoboo) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)) and object_index != A.obj_podoboo and object_index != A.obj_grrrol and object_index != A.obj_spring_land and object_index != A.obj_player_goal_parent):
		instance_destroy()
	_user_14()


# from objects/obj_physicsparent/Other_24.gml
func _user_14() -> void:
	var lava_lift = collision_rectangle(bbox_left, (bbox_bottom - 3.0), bbox_right, ((bbox_bottom + 4.0) + vspeed), A.obj_platform_parent, false, false)
	if lava_lift != null and vspeed >= 0.0:
		var check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_solidtop, false, false)
		var phy_check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_physicssolid, false, false)
		if (check != null and check != lava_lift) or phy_check != null:
			return
		y = (lava_lift.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		var spd = lava_lift.hspeed
		if (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
			x += lava_lift.hspeed
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= absf(lava_lift.hspeed)
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += absf(lava_lift.hspeed)


# from objects/obj_physicsparent/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
