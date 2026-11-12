# 第 7 批移植，已核对。
extends "res://objects/obj_deactivation.gd"

var salto: float = 0.0
var bort = null


# from objects/obj_bortice/Create_0.gml
func _create() -> void:
	image_speed = 0.2
	salto = 0.0
	bort = null  # GML: -4（noone），按第 15 条用 null
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_bortice_start
		image_speed = 0.3


# from objects/obj_bortice/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -7.0


# from objects/obj_bortice/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	var o = other  # PORT: 取别的 object 的自定义变量（第 8a 条）
	if o.held == 0.0 and other.y < (y + 8.0):
		if other.vspeed > 0.0:
			other.vspeed -= 0.4
		elif other.y <= (y - 92.0):
			other.vspeed -= 1.0
			if other.vspeed < -3.0:
				other.vspeed = -3.0
		else:
			other.vspeed -= 1.0
			if other.vspeed < -2.0:
				other.vspeed = -2.0


# from objects/obj_bortice/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.stompstyle = 0.0
		inst.groundpount = 0.0
		inst.skidnow = 0.0
	if other.vspeed >= 0.0:
		other.vspeed -= 0.4
		salto = 0.0
	elif salto == 0.0:
		if other.y <= (y - 92.0):
			other.vspeed -= 1.0
			if other.vspeed < -3.2:
				other.vspeed = -3.2
		else:
			other.vspeed -= 0.5
			if other.vspeed < -2.2:
				other.vspeed = -2.2
	if (GM.keyboard_check_pressed(G.saltar) or GM.keyboard_check_pressed(G.saltar_spin)) and other.y <= (y - 84.0):
		salto = 1.0
		for inst in GM.with_list(other):
			if inst.isswim == 1.0:
				inst.vspeed = -2.0
			else:
				inst.vspeed = -4.125
			inst.jumpnow = 1.0
			inst.state = 2.0


# from objects/obj_bortice/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	var v1
	var v2
	var v3
	if other.y < (y + 8.0):
		if (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) == null):
			v1 = 0.4
			v2 = 3.0
			v3 = 2.0
			if other.vspeed > 0.0:
				other.vspeed -= v1
			elif other.y <= (y - 92.0):
				other.vspeed -= 1.0
				if other.vspeed < (-v2):
					other.vspeed = (-v2)
			else:
				other.vspeed -= 1.0
				if other.vspeed < (-v3):
					other.vspeed = (-v3)


# from objects/obj_bortice/Collision_obj_physicsparent.gml
func _collision_obj_physicsparent(other: GMObject) -> void:
	var v1
	var v2
	var v3
	var o = other  # PORT: 取别的 object 的自定义变量（第 8a 条）
	if other.y < (y + 8.0):
		if other.object_index == A.obj_jumppiranha and o.inup > 0.0:
			return
		if (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) == null):
			if (other.object_index != A.obj_grinder and other.object_index != A.obj_banzaibill and other.object_index != A.obj_billbanzai_red and other.object_index != A.obj_bulletbill and other.object_index != A.obj_bulletbull_red and other.object_index != A.obj_fireball and other.object_index != A.obj_snowball and other.object_index != A.obj_boo and other.object_index != A.obj_fire_clown and other.object_index != A.obj_fire_clown_small and other.object_index != A.obj_angrysun and other.object_index != A.obj_torbellino and other.object_index != A.obj_cap_mario and other.object_index != A.obj_helmet and other.object_index != A.obj_podoboo and other.object_index != A.obj_yoshifire and other.object_index != A.obj_yoshifire_one and other.object_index != A.obj_cannon and other.object_index != A.obj_cannon_red and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red and other.object_index != A.obj_cannon and other.object_index != A.obj_bullebill_base and other.object_index != A.obj_player_goal_smb1 and other.object_index != A.obj_player_goal_smw_castle and other.object_index != A.obj_magikoopa and other.object_index != A.obj_pokey and other.object_index != A.obj_floruga and other.object_index != A.obj_floruga_body and other.object_index != A.obj_foo and other.object_index != A.obj_rocky and other.object_index != A.obj_piranhaplant and other.object_index != A.obj_lakitu) or (other.bbox_bottom < bbox_top and other.object_index == A.obj_player_goal_smb1 and (o.ready_v == 2.0 or o.ready_v == 3.0)) or (other.bbox_bottom < bbox_top and other.object_index == A.obj_player_goal_smw_castle and o.fall == 1.0):
				if other.object_index == A.obj_clown or other.object_index == A.obj_clown_fire:
					v1 = 0.2
					v2 = 0.4
					v3 = 0.3
				else:
					v1 = 0.4
					v2 = 3.0
					v3 = 2.0
				if other.vspeed > 0.0:
					other.vspeed -= v1
				elif other.y <= (y - 92.0):
					other.vspeed -= 1.0
					if other.vspeed < (-v2):
						other.vspeed = (-v2)
				else:
					other.vspeed -= 1.0
					if other.vspeed < (-v3):
						other.vspeed = (-v3)


# from objects/obj_bortice/Collision_obj_thwomp.gml
func _collision_obj_thwomp(other: GMObject) -> void:
	var o = other  # PORT: 取别的 object 的自定义变量（第 8a 条）
	if o.direct_t == 1.0 and o.ready_v == 1.0:
		other.vspeed -= 1.0
		if other.vspeed < -2.0:
			other.vspeed = -2.0


# from objects/obj_bortice/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_bortice_start:
		sprite_index = A.spr_bortice
		image_speed = 0.3
	elif sprite_index == A.spr_NSMBU_bortice_start:
		sprite_index = A.spr_NSMBU_bortice
		image_speed = 0.3
