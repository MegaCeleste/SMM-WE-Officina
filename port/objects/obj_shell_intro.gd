# from objects/obj_shell_intro/（第 2 批移植，已逐事件核对）
extends GMObject


# from objects/obj_shell_intro/Create_0.gml
func _create() -> void:
	image_speed = 0.25
	alarm[0] = 120.0


# from objects/obj_shell_intro/Alarm_0.gml
func _alarm_0() -> void:
	hspeed = 4.0


# from objects/obj_shell_intro/Other_0.gml
func _outside_room() -> void:
	if (x - 32.0) > GM.room_width:
		instance_destroy()
