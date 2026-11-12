# from objects/obj_castle_floor（第 7 批移植，已核对）
extends "res://objects/obj_solidtop.gd"

var value: float = 0.0


# from objects/obj_castle_floor/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	value = 0.0


# from objects/obj_castle_floor/Step_0.gml
func _step() -> void:
	if vspeed > 1.5:
		vspeed = 1.5
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		instance_destroy()


# from objects/obj_castle_floor/Alarm_0.gml
func _alarm_0() -> void:
	GM.audio_stop_sound(A.snd_castle_destroyed)
	GM.audio_play_sound(A.snd_castle_destroyed, 0.0, false)
	gravity = 0.12
