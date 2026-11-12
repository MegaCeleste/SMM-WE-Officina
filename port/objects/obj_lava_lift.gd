extends "res://objects/obj_platform_parent.gd"

var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var primero = null
var segundo = null
var tercero = null


# from objects/obj_lava_lift/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_lava_lift
			image_speed = 0.0
			image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_lava_lift
			image_speed = 0.15
		2.0:
			sprite_index = A.spr_lava_lift
			image_speed = 0.15
		3.0:
			sprite_index = A.spr_NSMBU_lava_lift_overworld
			image_speed = 0.0
	ready_v = 0.0
	primero = GM.instance_create((x - 16.0), y, A.obj_lava_lift_part)
	segundo = GM.instance_create((x - 32.0), y, A.obj_lava_lift_part)
	tercero = GM.instance_create((x - 48.0), y, A.obj_lava_lift_part)
	primero.parent = self
	segundo.parent = self
	tercero.parent = self


# from objects/obj_lava_lift/Step_0.gml
func _step() -> void:
	var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 原版写 obj_mario.xxx；没有 Mario 时原版会报错，这里 collision 先判断为 null 就不会读它
	if collision_rectangle(bbox_left, (bbox_top - 5.0), bbox_right, (bbox_top + 4.0), A.obj_mario, false, false) != null and mario.bbox_bottom < (yprevious + 5.0) and mario.state < 2.0 and ready_v == 0.0:
		_user_1()
	if vspeed > 2.5:
		vspeed = 2.5
	# event_inherited(): 父类无此事件


# from objects/obj_lava_lift/Alarm_0.gml
func _alarm_0() -> void:
	gravity = 0.1
	alarm[2] = -1.0
	alarm[3] = -3.0
	GM.gm_round(x)  # ORIG-BUG: 原版这一行 round(x) 的结果没有使用，是空操作


# from objects/obj_lava_lift/Alarm_2.gml
func _alarm_2() -> void:
	x -= 2.0
	alarm[3] = 4.0


# from objects/obj_lava_lift/Alarm_3.gml
func _alarm_3() -> void:
	x += 2.0
	alarm[2] = 4.0


# from objects/obj_lava_lift/Other_0.gml
func _outside_room() -> void:
	instance_destroy()


# from objects/obj_lava_lift/Other_11.gml
func _user_1() -> void:
	hspeed = 1.0
	if G.apariencia == 3.0:
		image_speed = 0.2
	alarm[0] = 285.0
	alarm[2] = 225.0
	if GM.instance_exists(primero):
		for inst in GM.with_list(primero):
			if G.apariencia == 3.0:
				inst.image_speed = 0.2
			inst.hspeed = 1.0
			inst.ready_v = 1.0
			inst.alarm[0] = 297.0
			inst.alarm[2] = 237.0
	if GM.instance_exists(segundo):
		for inst in GM.with_list(segundo):
			if G.apariencia == 3.0:
				inst.image_speed = 0.2
			inst.hspeed = 1.0
			inst.ready_v = 1.0
			inst.alarm[0] = 309.0
			inst.alarm[2] = 249.0
	if GM.instance_exists(tercero):
		for inst in GM.with_list(tercero):
			if G.apariencia == 3.0:
				inst.image_speed = 0.2
			inst.hspeed = 1.0
			inst.ready_v = 1.0
			inst.alarm[0] = 321.0
			inst.alarm[2] = 261.0
	ready_v = 1.0
