# from objects/obj_SMB_flag（第 7 批移植，已核对）
extends GMObject

var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名），obj_player_goal_smb1/nsmbu 里读的是 ready_v
var angle: float = 0.0
var part: float = 0.0
var wavespeed: float = 0.0


# from objects/obj_SMB_flag/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_flag_bowser
		image_speed = 0.5
	else:
		image_speed = 0.0
	ready_v = 0.0
	angle = 0.0
	part = 2.5
	wavespeed = 0.2


# from objects/obj_SMB_flag/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_flagpole):
		if G.apariencia == 3.0:
			if y > (GM.instance_find(A.obj_flagpole, 0).y + 126.0):
				vspeed = 0.0
				y = (GM.instance_find(A.obj_flagpole, 0).y + 126.0)
				if ready_v == 0.0:
					ready_v = 1.0
					alarm[1] = 10.0
		elif y > (GM.instance_find(A.obj_flagpole, 0).y + 144.0):
			vspeed = 0.0
			y = (GM.instance_find(A.obj_flagpole, 0).y + 144.0)
			ready_v = 1.0
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		visible = true
	else:
		visible = false


# from objects/obj_SMB_flag/Alarm_0.gml
func _alarm_0() -> void:
	vspeed = 1.5
	if G.apariencia == 3.0 and GM.instance_exists(A.obj_flagpole) and GM.instance_exists(A.obj_player_goal_nsmbu):
		for inst in GM.with_list(GM.instance_create(x, (GM.instance_find(A.obj_flagpole, 0).y + 135.0), A.obj_NSMBU_flag_mario)):
			inst.limite = (GM.instance_find(A.obj_player_goal_nsmbu, 0).y + 16.0)


# from objects/obj_SMB_flag/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_flag
		inst.image_speed = 0.5
	if G.apariencia == 3.0 and GM.instance_exists(A.obj_player_goal_nsmbu):
		for inst in GM.with_list(A.obj_player_goal_nsmbu):
			inst.alarm[5] = 20.0
	instance_destroy()


# from objects/obj_SMB_flag/Collision_obj_flagpole.gml
func _collision_obj_flagpole(other: GMObject) -> void:
	if G.apariencia == 3.0:
		if y > (other.y + 126.0):
			vspeed = 0.0
			y = (other.y + 126.0)
			if ready_v == 0.0:
				ready_v = 1.0
				alarm[1] = 10.0
	elif y > (other.y + 144.0):
		vspeed = 0.0
		y = (other.y + 144.0)
		ready_v = 1.0


# from objects/obj_SMB_flag/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 3.0:
		alarm[0] = 1.0
	else:
		alarm[0] = 30.0
