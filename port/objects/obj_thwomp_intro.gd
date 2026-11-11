# from objects/obj_thwomp_intro/（第 2 批移植，已逐事件核对）
extends GMObject

var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）


# from objects/obj_thwomp_intro/Create_0.gml
func _create() -> void:
	alarm[0] = 120.0
	ready_v = 0.0


# from objects/obj_thwomp_intro/Alarm_0.gml
func _alarm_0() -> void:
	vspeed = 7.5
	alarm[1] = 22.0


# from objects/obj_thwomp_intro/Alarm_1.gml
func _alarm_1() -> void:
	alarm[0] = -1.0
	vspeed = 0.0
	GM.audio_play_sound(A.snd_SMB3_thwomp_original, 0.0, false)
	alarm[2] = 100.0


# from objects/obj_thwomp_intro/Alarm_2.gml
func _alarm_2() -> void:
	vspeed = -1.5
	alarm[3] = 75.0


# from objects/obj_thwomp_intro/Other_0.gml
func _outside_room() -> void:
	if (x - 16.0) > GM.room_width:
		instance_destroy()


# from objects/obj_thwomp_intro/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_thwomp_intro, 0.0, x, y, 0.5, 0.5, image_angle, image_blend, image_alpha)
