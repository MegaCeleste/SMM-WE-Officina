extends GMObject

var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名


# from objects/obj_angrysun_movement/Create_0.gml
func _create() -> void:
	x = 64.0
	y = 48.0
	ready_v = 0.0
	alarm[3] = 10.0


# from objects/obj_angrysun_movement/Step_0.gml
func _step() -> void:
	match ready_v:
		1.0:
			direction -= 11.25
		2.0:
			direction += 11.25


# from objects/obj_angrysun_movement/Alarm_0.gml
func _alarm_0() -> void:
	x = 304.0
	y = 48.0
	ready_v = 1.0
	alarm[1] = 200.0
	motion_set(270.0, 3.0)


# from objects/obj_angrysun_movement/Alarm_1.gml
func _alarm_1() -> void:
	if x < 304.0:
		alarm[1] = 1.0
		return
	x = 304.0
	y = 48.0
	ready_v = 0.0
	speed = 0.0
	alarm[2] = 22.0


# from objects/obj_angrysun_movement/Alarm_2.gml
func _alarm_2() -> void:
	ready_v = 3.0
	path_start(A.pth_angrysun_swoop_l, 3.5, GM.path_action_stop, false)


# from objects/obj_angrysun_movement/Alarm_3.gml
func _alarm_3() -> void:
	x = 64.0
	y = 48.0
	ready_v = 2.0
	alarm[4] = 200.0
	motion_set(270.0, 3.0)
	if G.apariencia == 3.0:
		if G.modo_noche == 0.0:
			GM.audio_play_sound(A.snd_NSMBU_angrysun, 0.0, false)
		else:
			GM.audio_play_sound(A.snd_NSMBU_happymoon, 0.0, false)


# from objects/obj_angrysun_movement/Alarm_4.gml
func _alarm_4() -> void:
	x = 64.0
	y = 48.0
	ready_v = 0.0
	speed = 0.0
	alarm[5] = 22.0


# from objects/obj_angrysun_movement/Alarm_5.gml
func _alarm_5() -> void:
	ready_v = 4.0
	path_start(A.pth_angrysun_swoop_r, 3.5, GM.path_action_stop, false)


# from objects/obj_angrysun_movement/Other_8.gml
func _path_end() -> void:
	if ready_v == 4.0:
		alarm[0] = 1.0
	elif ready_v == 3.0:
		alarm[3] = 1.0
