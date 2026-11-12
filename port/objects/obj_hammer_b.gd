# from objects/obj_hammer_b（第 5 批移植，已核对）
extends "res://objects/obj_hammer.gd"


# from objects/obj_hammer_b/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.visible == true and other.object_index != A.obj_grinder and other.object_index != A.obj_boo and other.hardness != 101.0:
		GM.audio_stop_sound(A.snd_SMB3_kick)
		GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_hammer_b/Collision_obj_rockparent.gml
func _collision_obj_rockparent(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.alarm[0] = 1.0
