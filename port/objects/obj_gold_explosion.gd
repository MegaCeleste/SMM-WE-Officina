# from objects/obj_gold_explosion（第 5 批移植，已核对）
extends "res://objects/obj_smoke.gd"

var active: float = 0.0


# from objects/obj_gold_explosion/Create_0.gml
func _create() -> void:
	var a: float
	var b: float
	image_speed = 0.4
	active = 0.0
	direct = 1.0
	a = 0.0
	for _rep in range(8):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_boltspark
			inst.image_speed = 0.1
			inst.motion_set(a, 0.5)
		a += 45.0
	b = 22.5
	for _rep in range(8):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_boltspark
			inst.image_speed = 0.1
			inst.motion_set(b, 1.0)
		b += 45.0


# from objects/obj_gold_explosion/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	var o = other
	var _o: GMObject = GM.other
	if o.object_index == A.obj_flipblock:
		GM.instance_create(o.x, o.y, A.obj_coin)
		for inst in GM.with_list(o):
			inst.instance_destroy()
	elif o.object_index == A.obj_onoffblock and o.ready_v == 0.0 and active == 0.0:
		GM.other = self
		for inst in GM.with_list(o):
			inst.ready_v = 1.0
			inst.vspeed = -2.0
			inst.alarm[0] = 4.0
			inst.event_user(0)
		GM.other = _o
		active = 1.0
	elif o.object_index != A.obj_noteblock and o.object_index != A.obj_musicblock and o.object_index != A.obj_noteblock_s and o.object_index != A.obj_onoffblock:
		GM.other = self
		for inst in GM.with_list(o):
			if inst.ready_v == 0.0:
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 4.0
				inst.event_user(0)
		GM.other = _o
	event_user(0)


# from objects/obj_gold_explosion/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_gold_explosion/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	if o.hardness == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_gold_explosion/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var o = other
	if o.held == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_gold_explosion/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_gold_explosion/Collision_obj_rockparent.gml
func _collision_obj_rockparent(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.alarm[0] = 1.0
	event_user(0)


# from objects/obj_gold_explosion/Collision_obj_snow_ball.gml
func _collision_obj_snow_ball(other: GMObject) -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_gold_explosion/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
