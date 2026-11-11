extends "res://objects/obj_physicsparent.gd"

var sequence: float = 0.0
var modo_lava: float = 0.0
var wings: float = 0.0
var wings_anim: float = 0.0
var progresivo: float = 0.0
var sprite_wings: float = 0.0


# from objects/obj_powerupparent/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	sequence = 0.0
	swimming = 0.0
	modo_lava = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	match G.apariencia:
		0.0:
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_wings = A.spr_NSMBU_wings_items
	alarm[10] = 4.0


# from objects/obj_powerupparent/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.set("direct", -1.0)
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.set("direct", -1.0)


# from objects/obj_powerupparent/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle") or (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "mountain" and G.modo_noche == 1.0):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.depth = -10.0
		instance_destroy()
	if progresivo == 1.0 and Scr.outside_view(self) == 0.0:  # !outside_view()，返回值只有 1/0
		if G.powerup == 0.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_mushroom)):
				inst.wings = wings
				inst.paracaidas = paracaidas
			instance_destroy()
	if (wings == 0.0 or paracaidas == 1.0) and object_index != A.obj_propellershroom:
		_user_3()
		_user_4()
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
		if gravity == 0.0:
			GM.instance_create((x + 8.0), y, A.obj_paracaidas_go)
			paracaidas = 0.0
			ystart = (y - 32.0)
			y += 1.0
			hspeed = 0.0
			alarm[10] = 10.0
	if wings == 1.0 and paracaidas == 0.0:
		if not GM.instance_exists(A.obj_deadmario):
			if G.apariencia == 3.0:
				wings_anim += 0.5
			else:
				wings_anim += 0.12
		if y > (ystart + 16.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.085
		elif y < (ystart - 16.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.085


# from objects/obj_powerupparent/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6


# from objects/obj_powerupparent/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and other.y < (other.ystart - 2.0) and bbox_bottom < (other.yprevious + 5.0) and vspeed >= 0.0:
		if collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			GM.instance_create(x, y, A.obj_smoke)
			instance_destroy()
		elif G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			vspeed = -1.8
		else:
			vspeed = -3.0
	elif other.vspeed > 0.0 and bbox_top > (other.y + 15.0) and vspeed == 0.0 and gravity == 0.0:
		GM.instance_create(x, y, A.obj_smoke)
		instance_destroy()


# from objects/obj_powerupparent/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup == 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_hurtsolid2, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null):
		if o.holding == 2.0 and (G.apariencia == 2.0 or G.apariencia == 4.0):
			o.isduck = 1.0
			o.isduckhold = 1.0
		else:
			o.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	if G.apariencia == 3.0:
		for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_effect_powerup
			inst.image_speed = 0.25
			inst.depth = -10.0
	if G.powerup != Scr.scr_sprite_get_constant(self, sprite_index):
		other.vspeed = 0.0
		other.gravity = 0.0
		if G.powerup == 0.0:
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.set("c_powerup", 1.0)
					inst.set("sprite_powerup", sprite_index)
				if object_index == A.obj_superflower:
					GM.audio_stop_sound(A.snd_SMB_powerup_superflower)
					GM.audio_play_sound(A.snd_SMB_powerup_superflower, 0.0, false)
				elif object_index == A.obj_megamushroom:
					GM.audio_stop_sound(A.snd_SMB_powerup_supermushroom)
					GM.audio_play_sound(A.snd_SMB_powerup_supermushroom, 0.0, false)
				else:
					GM.audio_stop_sound(Scr.scr_snd_powerup(self))
					GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
		elif G.powerup == 3.0:
			if GM.instance_exists(A.obj_mario):
				if GM.instance_exists(A.obj_cap_mario):
					for inst in GM.with_list(A.obj_cap_mario):
						inst.set("cap_invisible", 1.0)
						inst.visible = false
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.set("c_powerup", 1.0)
					inst.set("cap", 2.0)
					inst.set("sprite_powerup", sprite_index)
				GM.audio_stop_sound(Scr.scr_snd_powerup(self))
				GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
		else:
			if G.powerup == -50.0 or G.powerup == -85.0:
				for inst in GM.with_list(A.obj_levelmanager):
					inst.mchange = 3.0
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.set("c_powerup", 1.0)
					inst.set("sprite_powerup", sprite_index)
				if object_index == A.obj_megamushroom:
					GM.audio_stop_sound(A.snd_SMB_powerup_supermushroom)
					GM.audio_play_sound(A.snd_SMB_powerup_supermushroom, 0.0, false)
				else:
					GM.audio_stop_sound(Scr.scr_snd_powerup(self))
					GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	elif G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_powerup_second)
		GM.audio_play_sound(A.snd_NSMBU_powerup_second, 0.0, false)
	else:
		GM.audio_stop_sound(Scr.scr_snd_powerup(self))
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	instance_destroy()


# from objects/obj_powerupparent/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		var _o: GMObject = GM.other
		GM.other = self
		if hspeed > 0.0 and col_one_left != null:
			for inst in GM.with_list(col_one_left):
				inst.set("rot", 1.0)
				inst.event_user(0)
		if hspeed < 0.0 and col_one_right != null:
			for inst in GM.with_list(col_one_right):
				inst.set("rot", 1.0)
				inst.event_user(0)
		GM.other = _o
		if object_index == A.obj_fireflower or object_index == A.obj_superflower:
			hspeed = 0.0
		else:
			hspeed = (-hspeed)
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_powerupparent/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		if G.apariencia > 1.0 or object_index == A.obj_megamushroom:
			GM.draw_sprite(int(sprite_wings), wings_anim, x, y)
		else:
			GM.draw_sprite(int(sprite_wings), wings_anim, (x + 8.0), y)
	if paracaidas == 1.0:
		if object_index == A.obj_megamushroom:
			GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, (y - 16.0), 1.0, 1.0, image_angle, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
