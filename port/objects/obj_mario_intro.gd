# from objects/obj_mario_intro/（第 2 批移植，已逐事件核对）
extends GMObject

var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）


# from objects/obj_mario_intro/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0


# from objects/obj_mario_intro/Step_2.gml
func _step_end() -> void:
	if ready_v == 1.0:
		gravity = 0.3
		if vspeed > 6.0:
			vspeed = 6.0
		image_angle -= 10.0
		if (bbox_top - 16.0) > GM.room_height:
			for inst in GM.with_list(A.obj_intro_controller):
				inst.ready_v = 1.0
			instance_destroy()


# from objects/obj_mario_intro/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 1.0


# from objects/obj_mario_intro/Collision_obj_shell_intro.gml
func _collision_obj_shell_intro(other: GMObject) -> void:
	if ready_v == 0.0:
		ready_v = 1.0
		vspeed = -6.0
		GM.audio_play_sound(A.snd_SMB_kick, 0.0, false)


# from objects/obj_mario_intro/Collision_obj_thwomp_intro.gml
func _collision_obj_thwomp_intro(other: GMObject) -> void:
	if ready_v == 0.0:
		alarm[0] = 190.0
		gravity = 1.0


# from objects/obj_mario_intro/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, image_angle, image_blend, image_alpha)
