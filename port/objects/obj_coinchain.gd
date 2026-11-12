# from objects/obj_coinchain（第 5 批移植，已核对）
extends GMObject

var nextdir: float = 0.0


# from objects/obj_coinchain/Create_0.gml
func _create() -> void:
	vspeed = -1.0
	image_speed = 0.15
	nextdir = 90.0
	GM.audio_play_sound(A.snd_sprout, 0.0, false)
	alarm[0] = 16.0
	alarm[1] = 16.0
	alarm[2] = 513.0


# from objects/obj_coinchain/Step_2.gml
func _step_end() -> void:
	sprite_index = A.spr_coin
	if GM.keyboard_check_pressed(GM.vk_up):
		nextdir = 90.0
	elif GM.keyboard_check_pressed(GM.vk_down):
		nextdir = 270.0
	elif GM.keyboard_check_pressed(GM.vk_left):
		nextdir = 180.0
	elif GM.keyboard_check_pressed(GM.vk_right):
		nextdir = 0.0


# from objects/obj_coinchain/Alarm_0.gml
func _alarm_0() -> void:
	move_snap(16.0, 16.0)
	direction = nextdir
	if not position_meeting((x + 8.0), (y + 8.0), A.obj_coin):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin)):
			inst.image_index = self.image_index
	if direction == 0.0:
		if position_meeting((x + 24.0), (y + 8.0), A.obj_solid):
			instance_destroy()
	elif direction == 90.0:
		if position_meeting((x + 8.0), (y - 8.0), A.obj_solid):
			instance_destroy()
	elif direction == 180.0:
		if position_meeting((x - 8.0), (y + 8.0), A.obj_solid):
			instance_destroy()
	elif direction == 270.0:
		if position_meeting((x + 8.0), (y + 24.0), A.obj_solidtop):
			instance_destroy()
	alarm[0] = 16.0


# from objects/obj_coinchain/Alarm_1.gml
func _alarm_1() -> void:
	depth = -2.0


# from objects/obj_coinchain/Alarm_2.gml
func _alarm_2() -> void:
	instance_destroy()


# from objects/obj_coinchain/Collision_obj_slopeparent.gml
func _collision_obj_slopeparent(other: GMObject) -> void:
	instance_destroy()


# from objects/obj_coinchain/Other_0.gml
func _outside_room() -> void:
	instance_destroy()
