# from objects/obj_door_exit（第 7 批移植，已核对）
extends GMObject

var returndoor = null  ## obj_door 实例，由 obj_door 的 Alarm_2 写入（Create 里原版初值是数字 0）
var back = null
var get_v: float = 0.0  # PORT: 原名 get（和 Object.get 撞名）；obj_door 的 Alarm_0 也写它
var time_blow: float = 0.0


# from objects/obj_door_exit/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_door
		1.0:
			sprite_index = A.spr_SMB3_door
		2.0:
			sprite_index = A.spr_door
		3.0:
			sprite_index = A.spr_NSMBU_door
	image_speed = 0.0
	image_index = 0.0
	returndoor = 0.0  # PORT: 原版就是数字 0（不是 noone）；创建它的 obj_door 紧接着就写成实例
	back = null  # GML: back = -4（第 15 条）
	get_v = 0.0
	time_blow = 0.0


# from objects/obj_door_exit/Step_0.gml
func _step() -> void:
	if GM.keyboard_check(G.arriba) and place_meeting(x, y, A.obj_mario) and get_v == 0.0 and GM.instance_find(A.obj_mario, 0).state < 2.0 and GM.instance_find(A.obj_mario, 0).inclown == 0.0 and visible == true and y > (GM.instance_find(A.obj_mario, 0).y + 10.0) and y < (GM.instance_find(A.obj_mario, 0).y + 17.0) and GM.instance_find(A.obj_mario, 0).x >= x and GM.instance_find(A.obj_mario, 0).x <= (x + 16.0):
		if GM.instance_exists(A.obj_levelmanager):
			time_blow = GM.instance_find(A.obj_levelmanager, 0).alarm[2]
			for inst in GM.with_list(A.obj_levelmanager):
				inst.alarm[2] = 0.0
		GM.audio_play_sound(Scr.scr_snd_door_open(self), 0.0, false)
		image_index = 0.0
		image_speed = 0.12
		for inst in GM.with_list(GM.instance_create(GM.instance_find(A.obj_mario, 0).x, (y - 16.0), A.obj_doormario)):
			inst.direct = GM.instance_find(A.obj_mario, 0).direct
			inst.snow = GM.instance_find(A.obj_mario, 0).snow
			inst.helmet = GM.instance_find(A.obj_mario, 0).helmet
			inst.holding = GM.instance_find(A.obj_mario, 0).holding
		for inst in GM.with_list(A.obj_mario):  # GML: obj_mario.visible = false
			inst.visible = false
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()
		if GM.instance_exists(A.obj_autoscroll):
			for inst in GM.with_list(A.obj_autoscroll):
				inst.hspeed = 0.0
		alarm[0] = 55.0


# from objects/obj_door_exit/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_doormario):
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.alarm[2] = self.time_blow
		for inst in GM.with_list(returndoor):
			inst.get_v = 1.0
			inst.alarm[3] = 40.0
		for inst in GM.with_list(GM.instance_create((returndoor.x + 8.0), returndoor.y, A.obj_curtainin)):
			inst.fallow = 1.0
		if GM.instance_exists(A.obj_autoscroll):
			for inst in GM.with_list(A.obj_autoscroll):
				if self.returndoor.x < 192.0:
					inst.x = 192.0
				else:
					inst.x = self.returndoor.x
				inst.hspeed = inst.velocidad
		image_index = 0.0
		image_speed = 0.0
		for inst in GM.with_list(GM.instance_create((returndoor.x + 8.0), (returndoor.y - 16.0), A.obj_doormario_exit)):
			inst.direct = 1.0
			inst.helmet = GM.instance_find(A.obj_doormario, 0).helmet
			inst.holding = GM.instance_find(A.obj_doormario, 0).holding
			inst.myitem = GM.instance_find(A.obj_doormario, 0).myitem
		for inst in GM.with_list(A.obj_levelmanager):
			inst.barrier = 1.0
			inst.alarm[6] = 2.0
		if GM.instance_exists(A.obj_doormario):
			for inst in GM.with_list(A.obj_doormario):
				inst.instance_destroy()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(0)
		GM.other = _o
		alarm[1] = 15.0


# from objects/obj_door_exit/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(returndoor):
		for inst in GM.with_list(returndoor):
			inst.image_index = 0.0
			match G.apariencia:
				0.0:
					inst.sprite_index = A.spr_SMB_door_close
				1.0:
					inst.sprite_index = A.spr_SMB3_door_close
				2.0:
					inst.sprite_index = A.spr_door_close
				3.0:
					inst.sprite_index = A.spr_NSMBU_door_close
			inst.image_speed = 0.12


# from objects/obj_door_exit/Alarm_3.gml
func _alarm_3() -> void:
	get_v = 0.0


# from objects/obj_door_exit/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_door or sprite_index == A.spr_SMB3_door or sprite_index == A.spr_SMB_door or sprite_index == A.spr_NSMBU_door:
		image_speed = 0.0
		image_index = 2.0
	elif sprite_index == A.spr_door_close or sprite_index == A.spr_SMB3_door_close or sprite_index == A.spr_SMB_door_close or sprite_index == A.spr_NSMBU_door_close:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_door
			1.0:
				sprite_index = A.spr_SMB3_door
			2.0:
				sprite_index = A.spr_door
			3.0:
				sprite_index = A.spr_NSMBU_door
		image_speed = 0.0
		image_index = 0.0
		GM.audio_play_sound(Scr.scr_snd_door_close(self), 0.0, false)


# from objects/obj_door_exit/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, image_index, x, y)
