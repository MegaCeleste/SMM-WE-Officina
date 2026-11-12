# from objects/obj_multiveggiecoin（第 5 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var count: float = 0.0


# from objects/obj_multiveggiecoin/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	vspeed = -4.0
	count = 10.0
	alarm[0] = 100.0


# from objects/obj_multiveggiecoin/Step_0.gml
func _step() -> void:
	super._step()
	if gravity == 0.0:
		hspeed = 0.0
	else:
		gravity = 0.125


# from objects/obj_multiveggiecoin/Alarm_0.gml
func _alarm_0() -> void:
	if count == 0.0:
		GM.instance_create(x, y, A.obj_smoke)
		instance_destroy()
	else:
		count -= 1.0
		image_alpha = 0.6
		alarm[1] = 4.0


# from objects/obj_multiveggiecoin/Alarm_1.gml
func _alarm_1() -> void:
	image_alpha = 1.0
	alarm[0] = 4.0


# from objects/obj_multiveggiecoin/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if vspeed >= 0.0:
		GM.audio_play_sound(A.snd_coin, 0.0, false)
		G.coins += 1.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		GM.instance_create((x + 8.0), (y - 8.0), A.obj_sparkletrail)
		instance_destroy()
