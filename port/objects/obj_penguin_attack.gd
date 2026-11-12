# 第 4 批移植，已核对。
extends GMObject


# from objects/obj_penguin_attack/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var i_mario = GM.instance_find(A.obj_mario, 0)
		if i_mario.direct == 1.0:
			x = (i_mario.x + 5.0)
		else:
			x = (i_mario.x - 21.0)
		y = (i_mario.y + 12.0)
		if i_mario.slide != 1.0:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_penguin_attack/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		if inst.ready_v == 0.0:
			if inst.object_index == A.obj_flipblock and G.apariencia != 2.0:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.alarm[2] = 1.0
			elif inst.object_index == A.obj_noteblock:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.ready_v = 1.0
				inst.vspeed = -1.5
				inst.event_user(0)
			else:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 4.0
				inst.event_user(0)
	GM.other = _o


# from objects/obj_penguin_attack/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.stomp != 1.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
				inst2.sprite_index = A.spr_NSMBU_spinthump
				inst2.depth = -9.0
			inst.event_user(0)
		GM.other = _o


# from objects/obj_penguin_attack/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if other.held == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
				inst2.sprite_index = A.spr_NSMBU_spinthump
				inst2.depth = -9.0
			inst.event_user(0)
		GM.other = _o
