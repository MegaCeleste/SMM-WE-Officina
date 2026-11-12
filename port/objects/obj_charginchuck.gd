extends "res://objects/obj_deactenemyparent.gd"

var s_charginchuck: int = -1
var s_charginchuck_walk: int = -1
var s_charginchuck_jump: int = -1
var s_charginchuck_damage: int = -1
var s_charginchuck_damage_recover: int = -1
var sprite_wings: int = -1
var edible: float = 0.0
var hp: float = 0.0
var firehp: float = 0.0
var lookout: float = 0.0
var wings_anim: float = 0.0
var xx: float = 0.0


# from objects/obj_charginchuck/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_charginchuck = A.spr_SMB_charginchuck
			s_charginchuck_walk = A.spr_SMB_charginchuck_walk
			s_charginchuck_jump = A.spr_SMB_charginchuck_jump
			s_charginchuck_damage = A.spr_SMB_charginchuck_damage
			s_charginchuck_damage_recover = A.spr_NSMBU_charginchuck_wakeup
			sprite_index = A.spr_SMB_charginchuck
			sprite_wings = A.spr_SMB_wings
		1.0:
			s_charginchuck = A.spr_SMB3_charginchuck
			s_charginchuck_walk = A.spr_SMB3_charginchuck_walk
			s_charginchuck_jump = A.spr_SMB3_charginchuck_jump
			s_charginchuck_damage = A.spr_SMB3_charginchuck_damage
			s_charginchuck_damage_recover = A.spr_NSMBU_charginchuck_wakeup
			sprite_index = A.spr_SMB3_charginchuck
			sprite_wings = A.spr_SMB3_wings
		2.0:
			s_charginchuck = A.spr_charginchuck
			s_charginchuck_walk = A.spr_charginchuck_walk
			s_charginchuck_jump = A.spr_charginchuck_jump
			s_charginchuck_damage = A.spr_charginchuck_damage
			s_charginchuck_damage_recover = A.spr_NSMBU_charginchuck_wakeup
			sprite_index = A.spr_charginchuck
			sprite_wings = A.spr_wings
		3.0:
			s_charginchuck = A.spr_NSMBU_charginchuck
			s_charginchuck_walk = A.spr_NSMBU_charginchuck_walk
			s_charginchuck_jump = A.spr_NSMBU_charginchuck_jump
			s_charginchuck_damage = A.spr_NSMBU_charginchuck_damage
			s_charginchuck_damage_recover = A.spr_NSMBU_charginchuck_wakeup
			sprite_index = A.spr_NSMBU_charginchuck
			sprite_wings = A.spr_NSMBU_wings
	hardness = 0.0
	stomp = 0.0
	edible = 2.0
	direct = 1.0
	hp = 3.0
	firehp = 5.0
	lookout = -1.0
	swimming = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	dead_h = 0.0
	innave = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.15
	alarm[0] = 6.0
	alarm[10] = 60.0


# from objects/obj_charginchuck/Step_0.gml
func _step() -> void:
	xx = absf(hspeed)
	if sprite_index == s_charginchuck_walk or sprite_index == s_charginchuck_jump:
		if (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null):
			var block_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_flipblock, true, false)
			var block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_flipblock, true, false)
			if hspeed < 0.0 and block_right != null and block_right.ready_v == 0.0:
				for inst in GM.with_list(block_right):
					inst.alarm[2] = 1.0
			elif hspeed > 0.0 and block_left != null and block_left.ready_v == 0.0:
				for inst in GM.with_list(block_left):
					inst.alarm[2] = 1.0
			elif gravity == 0.0:
				sprite_index = s_charginchuck_jump
				image_speed = 0.0
				image_index = 0.0
				vspeed = (-((4.5 - (2.5 * swimming))))
				y -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null:
			x -= xx
	else:
		if gravity == 0.0:
			hspeed = 0.0
			if image_speed == 0.0:
				image_speed = 0.15
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null:
			x -= xx
	_user_4()
	_user_8()
	if wings == 1.0 and GM.instance_exists(A.obj_mario):
		if gravity == 0.0:
			wings_anim += 0.12
		else:
			wings_anim += 0.18
	if gravity == 0.0:
		if sprite_index == s_charginchuck_jump:
			sprite_index = s_charginchuck_walk
			if lookout == 0.0:
				image_speed = 0.15
			else:
				image_speed = 0.3
		if GM.instance_exists(A.obj_mario):
			if lookout == 1.0:
				if (hspeed < 0.0 and GM.instance_find(A.obj_mario, 0).x > (x + 32.0)) or (hspeed > 0.0 and GM.instance_find(A.obj_mario, 0).x < (x - 32.0)):
					sprite_index = s_charginchuck
					image_speed = 0.1
					hspeed = 0.0
					lookout = -1.0
					alarm[10] = 32.0
			elif lookout == 0.0:
				if GM.instance_find(A.obj_mario, 0).bbox_bottom > (y - 16.0):
					if (hspeed > 0.0 and GM.instance_find(A.obj_mario, 0).x > x) or (hspeed < 0.0 and GM.instance_find(A.obj_mario, 0).x < x):
						if wings == 1.0:
							hspeed *= 2.5
						else:
							hspeed *= 1.5
						lookout = 1.0
						alarm[1] = -1.0
						image_speed = 0.3
						if gravity == 0.0:
							sprite_index = s_charginchuck_walk
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_charginchuck/Alarm_0.gml
func _alarm_0() -> void:
	alarm[0] = 7.0
	if lookout == 1.0 and gravity == 0.0 and G.apariencia > 1.0:
		if sprite_index == s_charginchuck_walk:
			GM.audio_stop_sound(Scr.scr_snd_bump(self))
			GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)


# from objects/obj_charginchuck/Alarm_1.gml
func _alarm_1() -> void:
	if gravity == 0.0:
		sprite_index = s_charginchuck
		image_speed = 0.1
		hspeed = 0.0
		lookout = -1.0
		alarm[10] = 32.0
	else:
		alarm[1] = 1.0


# from objects/obj_charginchuck/Alarm_10.gml
func _alarm_10() -> void:
	if gravity > 0.0 or (not GM.instance_exists(A.obj_mario)):
		alarm[10] = 1.0
		return
	sprite_index = s_charginchuck_walk
	friction = 0.0
	alarm[0] = 6.0
	if GM.instance_find(A.obj_mario, 0).bbox_bottom < (y - 16.0):
		image_speed = 0.15
		lookout = 0.0
		alarm[1] = 120.0
		if GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -1.0
		else:
			hspeed = 1.0
	else:
		image_speed = 0.3
		lookout = 1.0
		if GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -1.75
		else:
			hspeed = 1.75


# from objects/obj_charginchuck/Other_7.gml
func _animation_end() -> void:
	if (sprite_index == s_charginchuck_damage) and (G.apariencia != 3.0):
		sprite_index = s_charginchuck
		image_speed = 0.0
		alarm[10] = 60.0


# from objects/obj_charginchuck/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = direct
	imdead.sprite_index = s_charginchuck_walk
	imdead.image_speed = 0.3
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


# from objects/obj_charginchuck/Other_11.gml
func _user_1() -> void:
	GM.audio_stop_sound(Scr.scr_snd_stomp(self))
	GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
	if G.apariencia == 2.0:
		GM.audio_stop_sound(A.snd_tread_boss)
		GM.audio_play_sound(A.snd_tread_boss, 0.0, false)
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0
		return
	if sprite_index != A.spr_SMB_charginchuck_damage and sprite_index != A.spr_SMB3_charginchuck_damage and sprite_index != A.spr_charginchuck_damage:
		if hp > 1.0:
			if firehp <= 1.0:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_score)):
					inst.event_user(4)
				GM.other = _o
				_user_0()
			else:
				sprite_index = s_charginchuck_damage
				image_speed = 0.0
				image_index = 0.0
				hp -= 1.0
				firehp -= 2.0
				alarm[10] = -1.0
		else:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_score)):
				inst.event_user(4)
			GM.other = _o
			_user_0()


# from objects/obj_charginchuck/Other_18.gml
func _user_8() -> void:
	if hspeed == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
	else:
		direct = (1.0 * GM.gm_sign(hspeed))


# from objects/obj_charginchuck/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (12.0 * direct)), (y - 26.0), direct, 1.0, 0.0, GM.c_white, 1.0)
