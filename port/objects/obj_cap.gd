# from objects/obj_cap（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var ready_v: float = 0.0  # PORT: 原名 ready 与 Node 成员冲突，改名
var xprevprev: float = 0.0
var up: float = 0.0


# from objects/obj_cap/Create_0.gml
func _create() -> void:
	if G.apariencia == 1.0:
		sprite_index = A.spr_leaf
		sprite_wings = A.spr_SMB3_wings2
	else:
		sprite_wings = A.spr_wings_items
	swimming = 0.0
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	xprevprev = x
	alarm[0] = 2.0
	alarm[10] = 1.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	up = 0.0


# from objects/obj_cap/Step_0.gml
func _step() -> void:
	if wings == 0.0 and ready_v == 1.0:
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship"):
			gravity = 0.0
			vspeed = -0.2
			if vspeed < -0.2:
				vspeed = -0.2
		else:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
		if x > xprevprev:
			image_index = 2.0
		else:
			image_index = 1.0
		xprevprev = xprevious
	if (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle") or (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.depth = -10.0
		instance_destroy()
	if paracaidas == 1.0:
		if x > (xstart + 16.0):
			if hspeed < -0.5:
				hspeed = -0.5
			else:
				hspeed -= 0.015
		elif x < (xstart - 16.0):
			if hspeed > 0.5:
				hspeed = 0.5
			else:
				hspeed += 0.015
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	if wings == 1.0 and paracaidas == 0.0:
		wings_anim += 0.12
		if y > (ystart + 12.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.085
		elif y < (ystart - 12.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.085
	if bbox_top > GM.room_height and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		instance_destroy()


# from objects/obj_cap/Alarm_0.gml
func _alarm_0() -> void:
	if wings == 0.0 and paracaidas == 0.0:
		vspeed = 0.0
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			path_start(A.pth_leafpath, -1.5, GM.path_action_continue, false)
		else:
			path_start(A.pth_leafpath, 1.5, GM.path_action_continue, false)
		ready_v = 1.0


# from objects/obj_cap/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	elif paracaidas == 0.0:
		if up == 1.0:
			if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				vspeed = -1.0
				swimming = 1.0
			else:
				vspeed = -2.0
				swimming = 0.0


# from objects/obj_cap/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup == 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_pinchos, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_muncher, true, false) != null):
		if other.holding == 2.0 and G.apariencia == 2.0:
			other.isduck = 1.0
			other.isduckhold = 1.0
		else:
			other.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	if G.apariencia == 1.0:
		if G.powerup == 0.0:
			if GM.instance_find(A.obj_mario, 0).holding != 2.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
			GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_smoke_cap)
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.sprite_powerup = sprite_index
					GM.audio_play_sound(A.snd_changeleaf, 0.0, false)
		elif G.powerup == 2.0 or G.powerup == -46.0:
			if GM.instance_find(A.obj_mario, 0).holding != 2.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
			GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_smoke_cap)
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.sprite_powerup = sprite_index
					GM.audio_play_sound(A.snd_changeleaf, 0.0, false)
		elif G.powerup == 1.0:
			if GM.instance_find(A.obj_mario, 0).holding != 2.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
			GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_smoke_cap)
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.sprite_powerup = sprite_index
					GM.audio_play_sound(A.snd_changeleaf, 0.0, false)
		else:
			GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	elif G.apariencia == 2.0:
		if G.powerup == 0.0:
			if GM.instance_find(A.obj_mario, 0).holding != 2.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
			GM.instance_create(other.x, other.y, A.obj_cap_mario)
			GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_smoke_cap)
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.cap = 1.0
					inst.sprite_powerup = sprite_index
					GM.audio_play_sound(A.snd_powerup_cap, 0.0, false)
		elif G.powerup == 2.0:
			if GM.instance_find(A.obj_mario, 0).holding != 2.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
			GM.instance_create(other.x, other.y, A.obj_cap_mario)
			GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_smoke_cap)
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.cap = 1.0
					inst.sprite_powerup = A.spr_cap
					GM.audio_play_sound(A.snd_powerup_cap, 0.0, false)
		elif G.powerup == 1.0:
			if GM.instance_find(A.obj_mario, 0).holding != 2.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
			GM.instance_create(other.x, other.y, A.obj_cap_mario)
			GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_smoke_cap)
			G.powerup = 3.0
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.cap = 1.0
					GM.audio_play_sound(A.snd_powerup_cap, 0.0, false)
		else:
			GM.audio_play_sound(A.snd_powerup, 0.0, false)
	instance_destroy()
