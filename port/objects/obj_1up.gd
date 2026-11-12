# from objects/obj_1up（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var rotten: float = 0.0
var hardness: float = 0.0
var stomp: float = 0.0
var edible: float = 0.0
var delay: float = 0.0
var charge: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready 与 Node 成员冲突，改名
var xscale2: float = 0.0
var yscale2: float = 0.0


# from objects/obj_1up/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if G.modo_noche == 1.0 and G.bg_level == "ground":
		rotten = 1.0
		sprite_index = A.spr_rotten_b
		match G.apariencia:
			0.0:
				sprite_wings = A.spr_SMB_wings_16x16
			1.0:
				sprite_wings = A.spr_SMB3_wings2
			2.0:
				sprite_wings = A.spr_wings_items
			3.0:
				sprite_wings = A.spr_NSMBU_wings_items
	else:
		rotten = 0.0
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_1up
				image_index = 1.0
				sprite_wings = A.spr_SMB_wings_16x16
			1.0:
				sprite_index = A.spr_SMB3_1up
				image_index = 1.0
				sprite_wings = A.spr_SMB3_wings2
			2.0:
				sprite_index = A.spr_1up
				image_index = 1.0
				sprite_wings = A.spr_wings_items
			3.0:
				sprite_index = A.spr_NSMBU_1up
				image_speed = 0.25
				sprite_wings = A.spr_NSMBU_wings_items
	swimming = 0.0
	hardness = 100.0
	stomp = -1.0
	edible = 0.0
	direct = -1.0
	delay = 0.0
	charge = 0.0
	ready_v = 0.0
	xscale2 = 1.0
	yscale2 = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	alarm[10] = 2.0


# from objects/obj_1up/Step_0.gml
func _step() -> void:
	super._step()
	if charge == 1.0:
		if gravity == 0.0 and wings == 0.0:
			if not GM.instance_exists(A.obj_invincibility):
				if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
					hspeed -= 0.0324
					if hspeed < -1.0:
						hspeed = -1.0
				else:
					hspeed += 0.0324
					if hspeed > 1.0:
						hspeed = 1.0
			elif (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
				hspeed += 0.0324
				if hspeed > 1.0:
					hspeed = 1.0
			else:
				hspeed -= 0.0324
				if hspeed < -1.0:
					hspeed = -1.0
			if delay > 0.0:
				delay -= 1.0
		if ready_v == 0.0:
			xscale2 += 0.025
			yscale2 -= 0.025
			if xscale2 > 1.25:
				ready_v = 1.0
		elif ready_v == 1.0:
			xscale2 -= 0.025
			yscale2 += 0.025
			if xscale2 < 0.75:
				ready_v = 0.0


# from objects/obj_1up/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	elif paracaidas == 0.0:
		if G.modo_noche == 1.0 and G.bg_level == "ground":
			charge = 1.0
			if wings == 1.0:
				hspeed = (0.6 * direct)
				vspeed = -0.5
		elif vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null:
			if G.modo_noche == 1.0:
				if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
					hspeed = (1.0 - (0.5 * swimming))
				else:
					hspeed = (-(1.0 - (0.5 * swimming)))
			else:
				hspeed = (1.0 - (0.5 * swimming))
		else:
			alarm[10] = 2.0


# from objects/obj_1up/Alarm_11.gml
func _alarm_11() -> void:
	if paracaidas == 0.0:
		if G.modo_noche == 1.0 and G.bg_level == "ground":
			charge = 1.0


# from objects/obj_1up/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and other.y < (other.ystart - 2.0) and bbox_bottom < (other.yprevious + 5.0) and wings == 0.0:
		if collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			GM.instance_create(x, y, A.obj_smoke)
			instance_destroy()
		else:
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
				vspeed = -1.8
			else:
				vspeed = -3.0
			if hspeed == 0.0:
				hspeed = 1.0
			elif (x + (sprite_width / 2.0)) > (other.x + (sprite_width / 2.0)):
				hspeed = 1.0
			elif (x + (sprite_width / 2.0)) < (other.x + (sprite_width / 2.0)):
				hspeed = -1.0
	elif other.vspeed > 0.0 and bbox_top > (other.y + 15.0) and vspeed == 0.0 and gravity == 0.0:
		GM.instance_create(x, y, A.obj_smoke)
		instance_destroy()


# from objects/obj_1up/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if rotten == 1.0:
		if GM.instance_exists(A.obj_invincibility):
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_score)):
				inst.event_user(9)
			GM.other = _o
			GM.instance_create(x, y, A.obj_smoke)
			instance_destroy()
		elif (not GM.instance_exists(A.obj_invincibility)) and GM.instance_find(A.obj_mario, 0).invincible == 0.0:
			for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_smoke)):
				inst.sprite_index = A.spr_smoke_rotten
				inst.depth = -11.0
			GM.instance_create(other.x, other.y, A.obj_rotten_signal)
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o2
			instance_destroy()
	else:
		match G.apariencia:
			2.0:
				GM.audio_stop_sound(A.snd_1up)
				GM.audio_play_sound(A.snd_1up, 0.0, false)
			3.0:
				GM.audio_stop_sound(A.snd_NSMBU_1up_original)
				GM.audio_play_sound(A.snd_NSMBU_1up_original, 0.0, false)
			_:
				GM.audio_stop_sound(A.snd_SMB3_1up)
				GM.audio_play_sound(A.snd_SMB3_1up, 0.0, false)
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(7)
		GM.other = _o3
		instance_destroy()


# from objects/obj_1up/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if rotten == 0.0:
		super._user_3()
	else:
		if (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null):
			col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
			col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
			var _o: GMObject = GM.other
			GM.other = self
			if hspeed > 0.0 and col_one_left != null:
				for inst in GM.with_list(col_one_left):
					inst.rot = 1.0
					inst.event_user(0)
			if hspeed < 0.0 and col_one_right != null:
				for inst in GM.with_list(col_one_right):
					inst.rot = 1.0
					inst.event_user(0)
			GM.other = _o
			if delay == 0.0 and gravity == 0.0:
				if swimming == 1.0:
					vspeed = -2.4
					GM.audio_stop_sound(A.snd_rotten)
					GM.audio_play_sound(A.snd_rotten, 0.0, false)
				else:
					vspeed = -4.8
					GM.audio_stop_sound(A.snd_rotten)
					GM.audio_play_sound(A.snd_rotten, 0.0, false)
				delay = 6.0
				y -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null:
			x -= 1.0


# from objects/obj_1up/Draw_0.gml
func _gm_draw() -> void:
	if rotten == 1.0:
		GM.draw_sprite_ext(A.spr_rotten, G.apariencia, GM.gm_round((x + 8.0)), GM.gm_round((y + 16.0)), (xscale2 * direct), yscale2, 0.0, GM.c_white, 1.0)
		if wings == 1.0:
			if G.apariencia > 1.0:
				GM.draw_sprite(int(sprite_wings), wings_anim, x, y)
			else:
				GM.draw_sprite(int(sprite_wings), wings_anim, (x + 8.0), y)
		if paracaidas == 1.0:
			GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	else:
		super._gm_draw()
