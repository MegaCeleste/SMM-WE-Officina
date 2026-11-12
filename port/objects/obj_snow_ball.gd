# from objects/obj_snow_ball（第 5 批移植，已核对）
extends "res://objects/obj_enemyparent_held.gd"

var imagen: int = 0
var can_dead: float = 0.0
var direct_spike: float = 0.0
var angle: float = 0.0
var hitpoint: float = 0.0
var dead_h: float = 0.0
var apilar: float = 0.0


# from objects/obj_snow_ball/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			imagen = A.spr_SMB_spike_ball
			sprite_index = A.spr_SMB_snow_ball
		1.0:
			imagen = A.spr_SMB3_spike_ball
			sprite_index = A.spr_SMB3_snow_ball
		2.0:
			imagen = A.spr_spike_ball
			sprite_index = A.spr_snow_ball
		3.0:
			imagen = A.spr_NSMBU_spike_ball
			sprite_index = A.spr_NSMBU_snow_ball
	image_speed = 0.0
	image_index = 2.0
	fisica = 0.0
	can_dead = 1.0
	direct_spike = -1.0
	angle = 0.0
	hitpoint = 0.0
	dead_h = 0.0
	swimming = 0.0
	dead_h = 0.0
	apilar = 0.0
	inmune = 0.0
	paracaidas = 0.0
	kickme = 0.0
	alarm[2] = 2.0
	alarm[10] = 2.0


# from objects/obj_snow_ball/Step_2.gml
func _step_end() -> void:
	super._step_end()
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
			GM.instance_create(x, y, A.obj_paracaidas_go)
			paracaidas = 0.0
			hspeed = 0.0


# from objects/obj_snow_ball/Alarm_1.gml
func _alarm_1() -> void:
	can_dead = 1.0


# from objects/obj_snow_ball/Alarm_2.gml
func _alarm_2() -> void:
	kickme = 1.0


# from objects/obj_snow_ball/Alarm_6.gml
func _alarm_6() -> void:
	inmune = 0.0


# from objects/obj_snow_ball/Alarm_10.gml
func _alarm_10() -> void:
	if paracaidas == 1.0:
		hspeed = -0.5


# from objects/obj_snow_ball/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if can_dead == 1.0:
		if hspeed != 0.0 and held == 0.0 and vspeed <= 0.0 and other.hardness < 99.0 and other.sprite_index != A.spr_beachkoopa and other.sprite_index != A.spr_beachkoopa_red:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o
		elif vspeed < 0.0 and held == 0.0 and other.hardness < 99.0 and other.sprite_index != A.spr_beachkoopa and other.sprite_index != A.spr_beachkoopa_red:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o2
		elif held == 1.0 and other.hardness < 99.0:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o3
			_user_0()


# from objects/obj_snow_ball/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if kickme == 1.0:
		if held == 0.0:
			if Scr.scr_canhold(self) > 0.5 and (not GM.instance_exists(A.obj_invincibility)) and inwall <= 0.5:
				other.holding = 2.0
				held = 1.0
				depth = -7.0
				gravity = 0.0
				speed = 0.0
			elif inmune == 0.0:
				if (other.stompstyle == 1.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0)) or (G.yoshi == 2.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0):
					if G.apariencia < 2.0:
						if GM.instance_exists(A.obj_kuribo_drybones):
							GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
						else:
							GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
					else:
						GM.audio_play_sound(A.snd_kick, 0.0, false)
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(1)
					GM.other = _o
					GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					_user_0()
				elif vspeed >= 0.0 or (vspeed >= 0.0 and G.yoshi > 0.0):
					GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
						inst.sprite_index = A.spr_spinthump
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_mario):
						if inst.holding == 0.0 and G.apariencia != 0.0 and G.apariencia != 3.0:
							inst.event_user(7)
					GM.other = _o2
					for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_snow_ball_held)):
						inst.alarm[0] = 5.0
						inst.fisica = 1.0
						inst.vspeed = -0.5
						if GM.instance_exists(A.obj_mario):
							if (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship"):
								if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < inst.x:
									inst.hspeed = 2.5
								else:
									inst.hspeed = -2.5
							elif (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < inst.x:
								inst.hspeed = 3.5
							else:
								inst.hspeed = -3.5
						inst.inmune = 1.0
						inst.alarm[2] = 12.0
					instance_destroy()


# from objects/obj_snow_ball/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_snow_ball_effect
			2.0:
				inst.sprite_index = A.spr_snow_ball_effect
			_:
				inst.sprite_index = A.spr_SMB3_snow_ball_effect
		inst.image_speed = 0.25
	instance_destroy()


# from objects/obj_snow_ball/Other_12.gml
func _user_2() -> void:
	var lugar: float = 0.0
	if GM.keyboard_check(G.abajo):
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null:
			inwall = 1.0
			hspeed = 0.0
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_slopeparent, true, false) == null:
			hspeed = (0.4 * GM.instance_find(A.obj_mario, 0).direct)
		else:
			vspeed = 0.1
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
		inmune = 1.0
		alarm[6] = 15.0
	elif GM.keyboard_check(G.arriba) and G.apariencia == 2.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		if GM.instance_find(A.obj_mario, 0).hspeed == 0.0:
			hspeed = 0.0
		else:
			hspeed = (GM.instance_find(A.obj_mario, 0).direct / 2.0)
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky"):
			vspeed = -3.5
			swimming = 1.0
		else:
			vspeed = -7.0
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null:
			inwall = 1.0
	elif vspeed >= 0.0:
		if G.apariencia == 3.0:
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_throw1, A.snd_NSMBU_throw2, A.snd_NSMBU_throw1), 0.0, false)
		else:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o2
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		if place_meeting(x, y, A.obj_solid):
			if GM.instance_find(A.obj_mario, 0).direct == 1.0:
				lugar = (x - 16.0)
			else:
				lugar = (x + 16.0)
		else:
			lugar = x
		for inst in GM.with_list(GM.instance_create(lugar, y, A.obj_snow_ball_held)):
			inst.alarm[0] = 5.0
			inst.fisica = 1.0
			inst.vspeed = -0.5
			inst.hspeed = (4.5 * GM.gm_sign(GM.instance_find(A.obj_mario, 0).direct))
		instance_destroy()


# from objects/obj_snow_ball/Other_14.gml
func _user_4() -> void:
	var semisolid: GMObject
	var physolid: GMObject
	var col_one_top: GMObject
	var col_one_bottom: GMObject
	var block: GMObject
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
			if vspeed > 0.5:
				vspeed = ((-vspeed) / 2.0)
			elif vspeed > 0.0 and vspeed <= 0.5:
				vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif modo_lava == 1.0:
		_user_0()
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 3.5:
			vspeed = 3.5
	else:
		gravity = 0.03
		if vspeed > 0.5:
			vspeed = 0.3
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
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_snow_ball/Other_17.gml
func _user_7() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky"):
		vspeed = -2.0
	else:
		vspeed = -5.0
	if GM.other.hspeed == 0.0:
		if ((GM.other.bbox_left + GM.other.bbox_right) / 2.0) < ((bbox_left + bbox_right) / 2.0):
			hspeed = 0.6
		elif ((GM.other.bbox_left + GM.other.bbox_right) / 2.0) > ((bbox_left + bbox_right) / 2.0):
			hspeed = -0.6
	elif GM.other.hspeed > 0.0:
		hspeed = 0.6
	elif GM.other.hspeed < 0.0:
		hspeed = -0.6


# from objects/obj_snow_ball/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(imagen, 2.0, GM.gm_round(x), (y + 8.0), 1.0, 1.0, angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
