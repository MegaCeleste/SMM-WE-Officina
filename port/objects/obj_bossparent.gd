extends "res://objects/obj_physicsparent.gd"

var hardness: float = 0.0
var stomp: float = 0.0
var modo_lava: float = 0.0
var wings: float = 0.0
var wings_anim: float = 0.0
var sprite_wings: int = 0
var inv: float = 0.0
var dead_h: float = 0.0
var cooldown: float = 0.0
var apilar: float = 0.0
var prevhspeed: float = 0.0
var ready_v: float = 0.0  # GML ready conflicts with Node.ready.
var hitpoints: float = 0.0
var firehitpoints: float = 0.0
var key = null  # Assigned by obj_angrysun or a boss child; absent until assigned.


# from objects/obj_bossparent/Create_0.gml
func _create() -> void:
	hardness = 0.0
	stomp = 0.0
	modo_lava = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	sprite_wings = A.spr_SMB_wings
	paracaidas = 0.0
	swimming = 0.0
	inv = 0.0
	dead_h = 0.0
	cooldown = 0.0
	apilar = 0.0
	prevhspeed = 0.0
	ready_v = 0.0
	hitpoints = 0.0
	firehitpoints = 10.0


# from objects/obj_bossparent/Step_0.gml
func _step() -> void:
	preload("res://objects/obj_enemyparent.gd")._step_for(self)
	if hitpoints > 1.0:
		inv -= 1.0
		if inv < 0.0:
			inv = 0.0
			hardness = 0.0
	else:
		inv = 0.0
	if cooldown > 0.0:
		cooldown -= 1.0


# from objects/obj_bossparent/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if other.hspeed != 0.0 or (other.hspeed == 0.0 and vspeed != 0.0):
		if hardness < 2.0:
			_user_15()
			firehitpoints -= 5.0
			cooldown = 6.0
			if firehitpoints <= 0.0:
				if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
					firehitpoints = 5.0
					_user_1()
				elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
					firehitpoints = 10.0
					_user_1()
				else:
					event_user(0)
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_bossparent/Collision_obj_fireball.gml
func _collision_obj_fireball(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0 and ready_v == 0.0:
		_user_15()
		firehitpoints -= 1.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_hammer.gml
func _collision_obj_hammer(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0 and ready_v == 0.0:
		_user_15()
		firehitpoints -= 2.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_icicle.gml
func _collision_obj_icicle(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0 and other.object_index != A.obj_icicle2 and other.object_index != A.obj_mini_icicle2 and other.vspeed > 0.0:
		_user_15()
		firehitpoints -= 5.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_link_arrow.gml
func _collision_obj_link_arrow(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0 and ready_v == 0.0 and stomp != -1.0:
		_user_15()
		if object_index == A.obj_bowserjr:
			firehitpoints -= 2.0
		else:
			firehitpoints -= 5.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_link_atack.gml
func _collision_obj_link_atack(other: GMObject) -> void:
	var o = other
	if hardness < 2.0 and o.ready_boss == 0.0 and stomp != -1.0:
		_user_15()
		cooldown = 6.0
		if object_index == A.obj_bowserjr:
			firehitpoints -= 2.0
		else:
			firehitpoints -= 5.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		for inst in GM.with_list(other):
			inst.ready_boss = 1.0


# from objects/obj_bossparent/Collision_obj_link_dash_atack.gml
func _collision_obj_link_dash_atack(other: GMObject) -> void:
	if hardness < 2.0 and stomp != -1.0:
		_user_15()
		cooldown = 6.0
		firehitpoints -= 5.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		for inst in GM.with_list(A.obj_mario):
			inst.hspeed = (-((2.0 * inst.direct)))
			inst.dash_atack = 0.0
			inst.dash_cont = 0.0


# from objects/obj_bossparent/Collision_obj_link_down_atack.gml
func _collision_obj_link_down_atack(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0 and stomp != -1.0:
		_user_15()
		cooldown = 6.0
		firehitpoints -= 5.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = (-((4.0 - (2.5 * inst.isswim))))
			inst.event_user(1)
			inst.down_atack = 0.0
			inst.down_cont = 0.0
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	var o = other
	if GM.instance_exists(A.obj_invincibility):
		return
	if stomp != -1.0 or o.invincible == -1.0:
		if other.bbox_bottom < ((bbox_top - vspeed) + 5.0):
			if stomp != 3.0 and stomp != 5.0 and (o.stompstyle == 1.0 or G.yoshi > 0.0):
				if G.apariencia < 2.0:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				else:
					GM.audio_play_sound(A.snd_stomp, 0.0, false)
					GM.audio_play_sound(A.snd_tread_boss, 0.0, false)
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(1)
				GM.other = _o
				if hitpoints != 1.0:
					for inst in GM.with_list(GM.instance_create(other.x, (other.bbox_bottom - 8.0), A.obj_smoke)):
						if G.apariencia == 3.0:
							inst.sprite_index = A.spr_NSMBU_effect_stomp
						else:
							inst.sprite_index = A.spr_spinthump
						inst.depth = -3.0
				_user_1()
			elif stomp == 0.0 or stomp == 4.0 or stomp == 5.0:
				if G.apariencia < 2.0:
					GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
				else:
					GM.audio_play_sound(A.snd_stomp, 0.0, false)
					GM.audio_play_sound(A.snd_tread_boss, 0.0, false)
				if vspeed < 0.0:
					y = yprevious
					if other.vspeed > 0.0:
						other.y = other.yprevious
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(1)
				GM.other = _o
				if hitpoints != 1.0:
					for inst in GM.with_list(GM.instance_create(other.x, (other.bbox_bottom - 8.0), A.obj_smoke)):
						if G.apariencia == 3.0:
							inst.sprite_index = A.spr_NSMBU_effect_stomp
						else:
							inst.sprite_index = A.spr_spinthump
						inst.depth = -3.0
				_user_1()
		else:
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_bossparent/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	var _o: GMObject = GM.other
	var o = other
	if hardness < 2.0 and o.inmune == 0.0:
		_user_15()
		cooldown = 6.0
		firehitpoints -= 5.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0:
		_user_15()
		firehitpoints -= 5.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0:
		_user_15()
		firehitpoints -= 5.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_superball.gml
func _collision_obj_superball(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0:
		_user_15()
		firehitpoints -= 1.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Collision_obj_yoshifire.gml
func _collision_obj_yoshifire(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if hardness < 2.0 and ready_v == 0.0:
		_user_15()
		firehitpoints -= 1.0
		cooldown = 6.0
		if firehitpoints <= 0.0:
			if object_index == A.obj_bowserjr or object_index == A.obj_NSMBU_bowserjr:
				firehitpoints = 5.0
				_user_1()
			elif object_index == A.obj_boomboom or object_index == A.obj_NSMBU_boomboom or object_index == A.obj_boomboom_b or object_index == A.obj_NSMBU_boomboom_b:
				firehitpoints = 10.0
				_user_1()
			else:
				event_user(0)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bossparent/Other_11.gml
func _user_1() -> void:
	return


# from objects/obj_bossparent/Other_12.gml
func _user_2() -> void:
	var overlap
	overlap = collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 4.0), A.obj_bossparent, false, true)
	if overlap != null and overlap.hardness < 99.0:
		if ((bbox_left + bbox_right) * 0.5) > ((overlap.bbox_left + overlap.bbox_right) * 0.5) or (((bbox_left + bbox_right) * 0.5) == ((overlap.bbox_left + overlap.bbox_right) * 0.5) and _uid > overlap._uid):
			hspeed = absf(hspeed)
		else:
			hspeed = (-absf(hspeed))


# from objects/obj_bossparent/Other_16.gml
func _user_6() -> void:
	if gravity == 0.0:
		if hspeed < 0.0:
			if collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_muncher, false, false) == null):
				if (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_muncher, false, false) == null):
					prevhspeed = (-hspeed)
					hspeed = (-hspeed)
			elif collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_pinchos, false, false) == null):
				if (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_pinchos, false, false) == null):
					prevhspeed = (-hspeed)
					hspeed = (-hspeed)
			elif collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null:
				prevhspeed = (-hspeed)
				hspeed = (-hspeed)
		elif hspeed > 0.0:
			if collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_muncher, false, false) == null):
				if (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 5.0), A.obj_muncher, true, false) == null):
					prevhspeed = (-hspeed)
					hspeed = (-hspeed)
			elif collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_pinchos, false, false) == null):
				if (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 5.0), A.obj_pinchos, true, false) == null):
					hspeed = (-hspeed)
			elif collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null:
				hspeed = (-hspeed)


# from objects/obj_bossparent/Other_25.gml
func _user_15() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB3_thwomp_original)
			GM.audio_play_sound(A.snd_SMB3_thwomp_original, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_thwomp_original)
			GM.audio_play_sound(A.snd_SMB3_thwomp_original, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_tread_boss)
			GM.audio_play_sound(A.snd_tread_boss, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_bowser_impact)
			GM.audio_play_sound(A.snd_NSMBU_bowser_impact, 0.0, false)
