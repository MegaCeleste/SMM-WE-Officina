extends "res://objects/obj_bossparent.gd"

var s_walk: int = 0
var s_fire: int = 0
var s_jump: int = 0
var s_groundpount: int = 0
var s_hammer: int = 0
var wings_x: float = 0.0
var state: float = 0.0
var groundpount: float = 0.0
var groundpount_cont: float = 0.0
var groundpount_jump: float = 0.0
var groundpount_wings: float = 0.0
var fire: float = 0.0
var fire_anim: float = 0.0
var imdead = null


# from objects/obj_bowserjr/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			s_walk = A.spr_SMB_bowserjr_walk
			s_fire = A.spr_SMB_bowserjr_fire
			s_jump = A.spr_SMB_bowserjr_groundpount
			s_groundpount = A.spr_SMB_bowserjr_groundpount
			s_hammer = A.spr_SMB_bowserjr_walk
			sprite_wings = A.spr_SMB_wings
			wings_x = 12.0
		1.0:
			sprite_index = A.spr_SMB3_bowserjr_walk
			s_walk = A.spr_SMB3_bowserjr_walk
			s_fire = A.spr_SMB3_bowserjr_fire
			s_jump = A.spr_SMB3_bowserjr_jump
			s_groundpount = A.spr_SMB3_bowserjr_groundpount
			s_hammer = A.spr_SMB3_bowserjr_hammer
			sprite_wings = A.spr_SMB3_wings
			wings_x = 12.0
		2.0:
			sprite_index = A.spr_bowserjr_walk
			s_walk = A.spr_bowserjr_walk
			s_fire = A.spr_bowserjr_fire
			s_jump = A.spr_bowserjr_jump
			s_groundpount = A.spr_bowserjr_groundpount
			s_hammer = A.spr_bowserjr_hammer
			sprite_wings = A.spr_wings
			wings_x = 14.0
	state = 1.0
	groundpount = 0.0
	groundpount_cont = 0.0
	groundpount_jump = 0.0
	groundpount_wings = 0.0
	fire = 0.0
	fire_anim = 0.0
	cooldown = 0.0
	swimming = 0.0
	prevhspeed = 0.0
	image_speed = 0.1
	paracaidas = 0.0
	firehitpoints = 5.0
	key = 0.0
	paracaidas = 0.0
	hitpoints = 3.0
	alarm[10] = 2.0


# from objects/obj_bowserjr/Step_0.gml
func _step() -> void:
	var ground_block = null
	if state == 1.0:
		hspeed = 0.0
	if groundpount == 1.0 and vspeed > 0.0:
		if wings == 1.0:
			groundpount_wings = 30.0
		else:
			groundpount = 2.0
			vspeed = 2.0
			image_speed = 0.0
			image_index = 1.0
	if GM.instance_exists(A.obj_mario) and (GM.instance_find(A.obj_mario, 0).x > (x + 184.0) or GM.instance_find(A.obj_mario, 0).x < (x - 184.0)) and alarm[7] == -1.0:
		vspeed = -2.0
		alarm[7] = 15.0
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > x:
		direct = 1.0
	else:
		direct = -1.0
	if groundpount_wings > 0.0:
		vspeed = 0.0
		gravity = 0.0
	else:
		_user_3()
		_user_4()
	if gravity > 0.0:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	if wings == 1.0 and (not GM.instance_exists(A.obj_deadmario)):
		if groundpount > 0.0:
			wings_anim += 0.18
		else:
			wings_anim += 0.12
	if cooldown > 0.0:
		cooldown -= 1.0
	if groundpount_wings > 0.0:
		if groundpount_wings == 1.0:
			groundpount = 2.0
			vspeed = 2.0
			image_speed = 0.0
			image_index = 1.0
		groundpount_wings -= 1.0
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


# from objects/obj_bowserjr/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 0.0:
		return
	if state == 1.0:
		if groundpount > 0.0:
			sprite_index = s_groundpount
			image_speed = 0.0
			image_index = 1.0
		elif fire_anim == 1.0:
			if wings == 1.0:
				sprite_index = s_hammer
				image_speed = 0.15
			elif sprite_index != s_fire:
				sprite_index = s_fire
				image_index = 0.0
		else:
			sprite_index = s_walk
			image_speed = 0.1
	elif state == 2.0:
		if fire_anim == 1.0:
			fire_anim = 0.0
			fire = 0.0
		if groundpount > 0.0:
			sprite_index = s_groundpount
			image_speed = 0.0
			image_index = 0.0
		else:
			sprite_index = s_jump
			image_speed = 0.0
			image_index = 0.0


# from objects/obj_bowserjr/Alarm_0.gml
func _alarm_0() -> void:
	if vspeed == 0.0 and fire == 0.0:
		state = 2.0
		groundpount = 0.0
		if collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null:
			vspeed = -0.5
		else:
			vspeed = -2.0
		if GM.instance_exists(A.obj_mario) and x > (GM.instance_find(A.obj_mario, 0).x + 120.0) and direct == -1.0:
			hspeed = -2.0
		elif GM.instance_exists(A.obj_mario) and x < (GM.instance_find(A.obj_mario, 0).x - 120.0) and direct == 1.0:
			hspeed = 2.0
		else:
			hspeed = GM.choose(-2.0, 2.0)
		alarm[0] = 120.0
	else:
		alarm[0] = 30.0


# from objects/obj_bowserjr/Alarm_1.gml
func _alarm_1() -> void:
	if vspeed == 0.0:
		if wings == 1.0:
			if G.apariencia == 0.0:
				sprite_index = s_hammer
				image_speed = 0.15
			alarm[11] = 20.0
		elif G.apariencia == 0.0:
			sprite_index = A.spr_SMB_bowserjr_fire
			image_speed = 0.0
			image_index = 0.0
			alarm[2] = 20.0
		fire_anim = 1.0
		hspeed = 0.0
	else:
		alarm[1] = 1.0


# from objects/obj_bowserjr/Alarm_2.gml
func _alarm_2() -> void:
	if fire != 3.0:
		GM.audio_play_sound(A.snd_SMB3_bowser_fire, 0.0, false)
		if direct == 1.0:
			GM.instance_create((x + 13.0), (y + 3.0), A.obj_bowserjr_fire)
		else:
			GM.instance_create((x - 13.0), (y + 3.0), A.obj_bowserjr_fire)
	match fire:
		3.0:
			fire = 0.0
			if G.apariencia == 0.0:
				sprite_index = A.spr_SMB_bowserjr_walk
				image_speed = 0.1
			alarm[1] = GM.choose(240.0, 300.0, 240.0, 300.0)
		2.0:
			fire = 3.0
			fire_anim = 0.0
			if G.apariencia == 0.0:
				sprite_index = A.spr_SMB_bowserjr_walk
				image_speed = 0.1
			alarm[1] = 20.0
		_:
			fire += 1.0
			image_index = 1.0
			alarm[1] = 60.0


# from objects/obj_bowserjr/Alarm_3.gml
func _alarm_3() -> void:
	if vspeed == 0.0:
		if G.apariencia == 0.0:
			sprite_index = s_walk
			image_speed = 0.1
		hspeed = 0.0
		alarm[0] = -1.0
		alarm[1] = -1.0
		alarm[2] = -1.0
		alarm[8] = -1.0
		alarm[9] = -1.0
		alarm[11] = -1.0
		alarm[4] = 20.0
	else:
		alarm[3] = 1.0


# from objects/obj_bowserjr/Alarm_4.gml
func _alarm_4() -> void:
	state = 2.0
	groundpount = 1.0
	vspeed = -6.0


# from objects/obj_bowserjr/Alarm_7.gml
func _alarm_7() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_bowserjr_shell)):
		inst.firehitpoints = self.firehitpoints
		inst.hitpoints = self.hitpoints
		inst.wings = self.wings
		inst.key = self.key
	instance_destroy()


# from objects/obj_bowserjr/Alarm_8.gml
func _alarm_8() -> void:
	if fire != 3.0:
		if G.apariencia == 1.0:
			GM.audio_stop_sound(A.snd_SMB3_bowser_fire)
			GM.audio_play_sound(A.snd_SMB3_bowser_fire, 0.0, false)
		else:
			GM.audio_stop_sound(A.snd_flames)
			GM.audio_play_sound(A.snd_flames, 0.0, false)
		if direct == 1.0:
			GM.instance_create((x + 13.0), (y + 3.0), A.obj_bowserjr_fire)
		else:
			GM.instance_create((x - 13.0), (y + 3.0), A.obj_bowserjr_fire)
	match fire:
		2.0:
			fire = 3.0
		_:
			fire += 1.0


# from objects/obj_bowserjr/Alarm_9.gml
func _alarm_9() -> void:
	if fire != 3.0:
		image_index = 0.0
		image_speed = 0.1
	else:
		fire = 0.0
		fire_anim = 0.0
		alarm[1] = GM.choose(240.0, 300.0, 240.0, 300.0)


# from objects/obj_bowserjr/Alarm_10.gml
func _alarm_10() -> void:
	alarm[0] = 1.0
	alarm[1] = 60.0
	groundpount = 0.0
	groundpount_jump = 0.0
	alarm[3] = GM.choose(300.0, 340.0, 420.0, 300.0)


# from objects/obj_bowserjr/Alarm_11.gml
func _alarm_11() -> void:
	var x_pos
	if fire == 3.0 and hitpoints == 1.0:
		if direct == 1.0:
			x_pos = (x + 10.0)
		else:
			x_pos = (x - 10.0)
		for inst in GM.with_list(GM.instance_create(x_pos, (y - 5.0), A.obj_shell_held)):
			match G.apariencia:
				0.0:
					inst.sprite_index = A.spr_SMB_shell
				1.0:
					inst.sprite_index = A.spr_SMB3_shell
				2.0:
					inst.sprite_index = A.spr_shell
				3.0:
					inst.sprite_index = A.spr_NSMBU_shell
			inst.prevhspeed = (2.8 * self.direct)
			inst.hspeed = (2.8 * self.direct)
			inst.vspeed = -1.5
			inst.inmune = 1.0
			inst.alarm[2] = 15.0
	elif fire != 4.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x + 5.0), (y - 5.0), A.obj_brohammer)):
				inst.hspeed = 1.5
				inst.direct = 1.0
		else:
			for inst in GM.with_list(GM.instance_create((x - 5.0), (y - 5.0), A.obj_brohammer)):
				inst.hspeed = -1.5
				inst.direct = -1.0
	match fire:
		4.0:
			fire = 0.0
			if G.apariencia == 0.0:
				sprite_index = A.spr_SMB_bowserjr_walk
				image_speed = 0.1
			alarm[1] = GM.choose(60.0, 120.0, 90.0, 180.0)
		3.0:
			fire = 4.0
			fire_anim = 0.0
			if G.apariencia == 0.0:
				sprite_index = A.spr_SMB_bowserjr_walk
				image_speed = 0.1
			alarm[11] = 15.0
		_:
			fire += 1.0
			alarm[11] = 15.0


# from objects/obj_bowserjr/Other_7.gml
func _animation_end() -> void:
	if G.apariencia == 0.0:
		return
	if sprite_index == s_fire:
		alarm[8] = 1.0
		image_speed = 0.0
		image_index = 3.0
		alarm[9] = 30.0


# from objects/obj_bowserjr/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.direct = direct
	imdead.dead_boss = 1.0
	imdead.girar = 1.0
	imdead.image_speed = 0.15
	if key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
		key = 0.0
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x - (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_bowserjr_dead
		1.0:
			imdead.sprite_index = A.spr_SMB3_bowserjr_dead
		2.0:
			imdead.sprite_index = A.spr_bowserjr_dead
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 和自身 bbox_right 混用，照搬原文。
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


# from objects/obj_bowserjr/Other_11.gml
func _user_1() -> void:
	hspeed = 0.0
	if hitpoints == 1.0:
		_user_0()
	else:
		cooldown = 6.0
		hitpoints -= 1.0
		if vspeed == 0.0:
			vspeed = -2.0
		else:
			vspeed = 1.0
		alarm[7] = 15.0
	stomp = -1.0


# from objects/obj_bowserjr/Other_14.gml
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
			state = 1.0
			if groundpount == 2.0:
				GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
				if GM.instance_exists(A.obj_levelmanager):
					for inst in GM.with_list(A.obj_levelmanager):
						inst.alarm[11] = 1.0
				if GM.instance_exists(A.obj_mario):
					if GM.instance_find(A.obj_mario, 0).state < 2.0:
						for inst in GM.with_list(A.obj_mario):
							if not GM.instance_exists(A.obj_shake_mario):
								GM.instance_create(inst.x, (inst.y + 5.0), A.obj_shake_mario)
							inst.shake = 1.0
							inst.stuntime = 90.0
							inst.hspeed = 0.0
							inst.disablecontrols = 1.0
				GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
				GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
				alarm[10] = 15.0
				groundpount_cont = 5.0
				groundpount = 3.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _other_2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_2
	else:
		state = 2.0
		if groundpount == 2.0:
			gravity = 0.3
			if vspeed > 6.0:
				vspeed = 6.0
		elif swimming <= 0.5:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
		elif swimming == 1.0:
			gravity = 0.1
			if vspeed > 0.4:
				vspeed = 0.4
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
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _other_3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_3
			vspeed = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)):
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		if G.apariencia != 0.0:
			if G.bg_level == "forest":
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 28.0), A.obj_splash_posion)
			else:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 28.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
			match G.apariencia:
				0.0:
					inst.sprite_index = A.spr_SMB_bowserjr_dead
				1.0:
					inst.sprite_index = A.spr_SMB3_bowserjr_dead
				2.0:
					inst.sprite_index = A.spr_bowserjr_dead
			inst.image_speed = 0.15
			inst.direct = self.direct
			inst.alarm[0] = -1.0
		instance_destroy()
	elif (bbox_top - 16.0) > GM.room_height and G.bg_level != "castle" and G.bg_level != "forest":
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.dead_bowser = 1.0
				if G.apariencia == 0.0:
					inst.alarm[11] = 90.0
				else:
					inst.alarm[11] = 120.0
		instance_destroy()
	_user_14()


# from objects/obj_bowserjr/Draw_0.gml
func _gm_draw() -> void:
	if cooldown > 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.make_colour_rgb(255.0, 60.0, 109.0), (cooldown / 4.0))
		if wings == 1.0:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (wings_x * direct)), (y - 22.0), direct, 1.0, 0.0, GM.make_colour_rgb(255.0, 60.0, 109.0), (cooldown / 4.0))
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
		if wings == 1.0:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (wings_x * direct)), (y - 22.0), direct, 1.0, 0.0, GM.c_white, 1.0)
