# from objects/obj_buzzy_ceiling（第 6e 批移植，已核对）
extends "res://objects/obj_enemyparent.gd"

var edible: float = 0.0
var obj_generador: float = 0.0
var inup: float = 0.0
var draw_invert: float = 0.0
var big: float = 0.0
var w_wings: float = 0.0
var mytop = null
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名


# from objects/obj_buzzy_ceiling/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		image_speed = 0.25
	else:
		image_speed = 0.2
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	obj_generador = 0.0
	inup = 0.0
	draw_invert = 0.0
	big = 0.0
	wings = 0.0
	w_wings = 0.0
	mytop = A.obj_lighting
	mytopid = A.obj_lighting
	ready_v = 0.0
	innave = 0.0
	dead_h = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0
	paracaidas = 0.0


# from objects/obj_buzzy_ceiling/Step_0.gml
func _step() -> void:
	super._step()
	if gravity == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell_held)):
			inst.sprite_index = self.sprite_index
			inst.koopainside = -1.0
			inst.direct = self.direct
			inst.hardness = 100.0
			inst.flip = 1.0
			if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < inst.x:
				inst.prevhspeed = -2.5
				inst.hspeed = -2.5
			else:
				inst.prevhspeed = 2.5
				inst.hspeed = 2.5
		instance_destroy()


# from objects/obj_buzzy_ceiling/Alarm_10.gml
func _alarm_10() -> void:
	hspeed = 0.0


# from objects/obj_buzzy_ceiling/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	match sprite_index:
		A.spr_SMB_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB_shell_buzzy_night_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB_shell_buzzy:
			imdead.sprite_index = A.spr_SMB_shell_buzzy_deads
			imdead.image_index = 0.0
			imdead.image_speed = 0.0
		A.spr_SMB_shell_buzzy_night:
			imdead.sprite_index = A.spr_SMB_shell_buzzy_deads
			imdead.image_index = 1.0
			imdead.image_speed = 0.0
		A.spr_SMB_spiny_dead:
			imdead.sprite_index = A.spr_SMB_shell_spiny_deads
		A.spr_SMB3_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB3_shell_buzzy_night_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB3_shell_buzzy:
			imdead.sprite_index = A.spr_SMB3_shell_buzzy_deads
			imdead.image_index = 0.0
			imdead.image_speed = 0.0
		A.spr_SMB3_shell_buzzy_night:
			imdead.sprite_index = A.spr_SMB3_shell_buzzy_deads
			imdead.image_index = 1.0
			imdead.image_speed = 0.0
		A.spr_SMB3_spiny_dead:
			imdead.sprite_index = A.spr_SMB3_shell_spiny_deads
		A.spr_shell_buzzy:
			imdead.sprite_index = A.spr_shell_buzzy_deads
		A.spr_shell_buzzy_b:
			imdead.sprite_index = A.spr_shell_buzzy_b
		A.spr_spiny_dead:
			imdead.sprite_index = A.spr_shell_spiny_deads
		A.spr_NSMBU_shell_buzzy:
			imdead.sprite_index = A.spr_NSMBU_shell_buzzy_deads
		A.spr_NSMBU_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_NSMBU_spiny_dead:
			imdead.sprite_index = A.spr_NSMBU_shell_spiny_deads
		_:
			imdead.sprite_index = A.spr_shell_deads
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


# from objects/obj_buzzy_ceiling/Other_11.gml
func _user_1() -> void:
	var dark
	if collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.0, A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.0, A.obj_slopeparent, false, false) != null:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				dark = 1.0
			else:
				dark = 0.0
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
			inst.koopainside = -1.0
			inst.hardness = 100.0
			inst.flip = 1.0
			inst.alarm[3] = 540.0
			inst.alarm[4] = 640.0
		instance_destroy()


# from objects/obj_buzzy_ceiling/Other_14.gml
func _user_4() -> void:
	var semisolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o_col_one_top: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o_col_one_top
	elif not (swimming > 0.5):
		gravity = 0.4
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
				var _o_col_one_bottom: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o_col_one_bottom
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_buzzy_ceiling/Other_24.gml
func _user_14() -> void:
	return


# from objects/obj_buzzy_ceiling/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 16.0), 1.0, -1.0, 0.0, GM.c_white, 1.0)
