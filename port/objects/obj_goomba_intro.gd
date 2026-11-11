# from objects/obj_goomba_intro/（第 2 批移植，已逐事件核对）
extends GMObject

var goomba: float = 0.0


# from objects/obj_goomba_intro/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	goomba = 0.0
	alarm[0] = 145.0


# from objects/obj_goomba_intro/Alarm_0.gml
func _alarm_0() -> void:
	hspeed = -1.15
	alarm[1] = 208.0


# from objects/obj_goomba_intro/Alarm_1.gml
func _alarm_1() -> void:
	hspeed = 0.0
	sprite_index = A.spr_goomba_idle
	alarm[2] = 25.0


# from objects/obj_goomba_intro/Alarm_2.gml
func _alarm_2() -> void:
	for inst in GM.with_list(A.obj_mario_intro):
		inst.hspeed = -2.3
		inst.image_angle -= 3.0
	hspeed = -2.3
	sprite_index = A.spr_goomba_intro
