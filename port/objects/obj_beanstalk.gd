# from objects/obj_beanstalk（第 7 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var s_vine: int = 0  ## sprite 编号
var first_bean: float = 0.0
var downwards: float = 0.0  # 别处写入（obj_powerupsprout / obj_noteblock 等）
var bean_last = null  # 实例；原版初值 0，按第 15 条用 null 表示“没有”
var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）；obj_noteblock 写入 ready_v


# from objects/obj_beanstalk/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_beanstalk
			s_vine = A.spr_SMB_vine_green
		1.0:
			sprite_index = A.spr_SMB3_beanstalk
			s_vine = A.spr_SMB3_vine_green
		2.0:
			s_vine = A.spr_vine_green
		3.0:
			sprite_index = A.spr_NSMBU_beanstalk
			s_vine = A.spr_NSMBU_vine_green
	first_bean = 0.0
	downwards = 0.0
	bean_last = null  # PORT: 原版 bean_last = 0
	ready_v = 0.0
	alarm[2] = 60.0
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.12
	alarm[1] = 2.0
	alarm[0] = 16.0


# from objects/obj_beanstalk/Step_0.gml
func _step() -> void:
	if y < 0.0 or y > GM.room_height:
		instance_destroy()


# from objects/obj_beanstalk/Alarm_0.gml
func _alarm_0() -> void:
	move_snap(1.0, 16.0)
	bean_last = GM.instance_create(x, y, A.obj_vine)
	alarm[0] = 16.0


# from objects/obj_beanstalk/Alarm_1.gml
func _alarm_1() -> void:
	if downwards == 0.0:
		vspeed = -1.0
	else:
		vspeed = 1.0


# from objects/obj_beanstalk/Alarm_2.gml
func _alarm_2() -> void:
	ready_v = 1.0


# from objects/obj_beanstalk/Collision_obj_solid.gml
func _collision_obj_solid(other: GMObject) -> void:
	if other.y != ystart and ready_v == 1.0:
		if GM.instance_exists(A.obj_vine):
			for inst in GM.with_list(A.obj_vine):
				inst.image_speed = 0.0
		if not GM.veq(bean_last, A.obj_lighting) and GM.instance_exists(bean_last):
			if downwards == 0.0:
				for inst in GM.with_list(bean_last):
					inst.sprite_index = self.s_vine
					inst.image_index = 1.0
			else:
				for inst in GM.with_list(bean_last):
					inst.sprite_index = self.s_vine
					inst.image_index = 1.0
		instance_destroy()


# from objects/obj_beanstalk/Collision_obj_solidtop.gml
func _collision_obj_solidtop(other: GMObject) -> void:
	if other.y != ystart and ready_v == 1.0 and downwards == 1.0:
		if GM.instance_exists(A.obj_vine):
			for inst in GM.with_list(A.obj_vine):
				inst.image_speed = 0.0
		if not GM.veq(bean_last, A.obj_lighting) and GM.instance_exists(bean_last):
			if downwards == 0.0:
				for inst in GM.with_list(bean_last):
					inst.sprite_index = self.s_vine
					inst.image_index = 1.0
			else:
				for inst in GM.with_list(bean_last):
					inst.sprite_index = self.s_vine
					inst.image_index = 3.0
		instance_destroy()


# from objects/obj_beanstalk/Draw_0.gml
func _gm_draw() -> void:
	if downwards == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, (x + 16.0), (y + 16.0), 1.0, 1.0, 180.0, GM.c_white, 1.0)
