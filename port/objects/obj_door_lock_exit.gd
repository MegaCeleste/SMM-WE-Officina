# from objects/obj_door_lock_exit（第 7 批移植，已核对）
extends GMObject

var s_doorlock_anim: float = 0.0
var s_doorlock_unlock: float = 0.0
var s_doorlock_unlock_close: float = 0.0
var returndoor = null  ## obj_door_lock 实例，由 obj_door_lock 的 Alarm_2 写入（Create 里原版初值是数字 0）
var rotacion: float = 0.0
var rot: float = 0.0
var up: float = 0.0
var rot_angle: float = 0.0
var lock: float = 0.0
var get_v: float = 0.0  # PORT: 原名 get（和 Object.get 撞名）；obj_door_lock 的 Alarm_0 也写它
var back = null
var time_blow: float = 0.0  # PORT: 原版 Create 里没赋值，只在 Step 里赋值后由 Alarm_0 读；没有 variable_instance_exists 查询，按数值声明


# from objects/obj_door_lock_exit/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_doorlock_anim = A.spr_SMB_doorlock_anim
			s_doorlock_unlock = A.spr_SMB_doorlock_unlock
			s_doorlock_unlock_close = A.spr_SMB_doorlock_unlock_close
		1.0:
			s_doorlock_anim = A.spr_SMB3_doorlock_anim
			s_doorlock_unlock = A.spr_SMB3_doorlock_unlock
			s_doorlock_unlock_close = A.spr_SMB3_doorlock_unlock_close
		2.0:
			s_doorlock_anim = A.spr_doorlock_anim
			s_doorlock_unlock = A.spr_doorlock_unlock
			s_doorlock_unlock_close = A.spr_doorlock_unlock_close
		3.0:
			s_doorlock_anim = A.spr_NSMBU_doorlock_anim
			s_doorlock_unlock = A.spr_NSMBU_doorlock_unlock
			s_doorlock_unlock_close = A.spr_NSMBU_doorlock_unlock_close
	image_speed = 0.0
	image_index = 0.0
	returndoor = 0.0  # PORT: 原版就是数字 0（不是 noone）；创建它的 obj_door_lock 紧接着就写成实例
	rotacion = 0.0
	rot = 0.0
	up = 0.0
	rot_angle = 0.0
	lock = 1.0
	get_v = 0.0
	back = null  # GML: back = -4（第 15 条）


# from objects/obj_door_lock_exit/Step_0.gml
func _step() -> void:
	if lock == 1.0:
		sprite_index = s_doorlock_anim
		image_index = 0.0
	elif sprite_index != s_doorlock_unlock_close and sprite_index != s_doorlock_anim:
		sprite_index = s_doorlock_unlock
	if rot == 1.0:
		if up == 0.0:
			if rotacion > (rot_angle - 5.0):
				rotacion -= 1.0
			else:
				up = 1.0
		if up == 1.0:
			if rotacion < (rot_angle + 5.0):
				rotacion += 1.0
			else:
				up = 2.0
		elif up == 2.0:
			if rotacion > rot_angle:
				rotacion -= 1.0
			else:
				up = 0.0
				rot = 0.0
	else:
		rotacion = rot_angle
	if GM.keyboard_check_pressed(G.arriba) and G.keys == 0.0 and lock == 1.0 and get_v == 0.0 and place_meeting(x, y, A.obj_mario) and GM.instance_find(A.obj_mario, 0).state < 2.0 and GM.instance_find(A.obj_mario, 0).inclown == 0.0 and visible == true and y > (GM.instance_find(A.obj_mario, 0).y + 10.0) and y < (GM.instance_find(A.obj_mario, 0).y + 17.0) and GM.instance_find(A.obj_mario, 0).x >= x and GM.instance_find(A.obj_mario, 0).x <= (x + 16.0):
		rot = 1.0
		if G.apariencia == 3.0:
			if not GM.audio_is_playing(A.snd_NSMBU_doorlock):
				GM.audio_play_sound(A.snd_NSMBU_doorlock, 0.0, false)
		elif not GM.audio_is_playing(A.snd_oneway):
			GM.audio_play_sound(A.snd_oneway, 0.0, false)
	elif GM.keyboard_check(G.arriba) and G.keys > 0.0 and lock == 1.0 and get_v == 0.0 and place_meeting(x, y, A.obj_mario) and GM.instance_find(A.obj_mario, 0).state != 2.0 and visible == true and y > (GM.instance_find(A.obj_mario, 0).y + 10.0) and y < (GM.instance_find(A.obj_mario, 0).y + 17.0) and GM.instance_find(A.obj_mario, 0).x >= x and GM.instance_find(A.obj_mario, 0).x <= (x + 16.0):
		if GM.instance_exists(A.obj_levelmanager):
			time_blow = GM.instance_find(A.obj_levelmanager, 0).alarm[2]
			for inst in GM.with_list(A.obj_levelmanager):
				inst.alarm[2] = 0.0
		lock = 0.0
		if G.keys == 1.0:
			G.keys = 0.0
			if GM.instance_exists(A.obj_key_fallow):
				for inst in GM.with_list(A.obj_key_fallow):
					inst.instance_destroy()
		elif G.keys > 1.0:
			G.keys -= 1.0
			if GM.instance_exists(A.obj_key_fallow):
				for inst in GM.with_list(A.obj_key_fallow):
					inst.followers -= 1.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			if G.apariencia != 2.0:
				inst.sprite_index = A.spr_SMB3_sparkles_door
			else:
				inst.sprite_index = A.spr_sparkles_door
			inst.image_speed = 0.3
			inst.depth = (self.depth - 1.0)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			match G.apariencia:
				0.0:
					inst.sprite_index = A.spr_SMB_doorlock_anim_key
				1.0:
					inst.sprite_index = A.spr_SMB3_doorlock_anim_key
				2.0:
					inst.sprite_index = A.spr_doorlock_anim_key
				3.0:
					inst.sprite_index = A.spr_NSMBU_doorlock_anim_key
			inst.image_speed = 0.3
			inst.depth = -10.0
		match G.apariencia:
			0.0:
				GM.audio_play_sound(A.snd_SMB3_doorlock_open, 0.0, false)
			1.0:
				GM.audio_play_sound(A.snd_SMB3_doorlock_open, 0.0, false)
			2.0:
				GM.audio_play_sound(A.snd_doorlock_open, 0.0, false)
			3.0:
				GM.audio_play_sound(A.snd_NSMBU_doorlock_open, 0.0, false)
		image_index = 0.0
		image_speed = 0.3
		for inst in GM.with_list(returndoor):
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_smoke)):
				if G.apariencia != 2.0:
					inst2.sprite_index = A.spr_SMB3_sparkles_door
				else:
					inst2.sprite_index = A.spr_sparkles_door
				inst2.image_speed = 0.3
			inst.lock = 0.0
			inst.sprite_index = inst.s_doorlock_unlock
			inst.image_speed = 0.0
			inst.image_index = 0.0
		for inst in GM.with_list(GM.instance_create(GM.instance_find(A.obj_mario, 0).x, (y - 16.0), A.obj_doormario)):
			inst.direct = GM.instance_find(A.obj_mario, 0).direct
			inst.snow = GM.instance_find(A.obj_mario, 0).snow
			inst.helmet = GM.instance_find(A.obj_mario, 0).helmet
			inst.holding = GM.instance_find(A.obj_mario, 0).holding
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()
		if GM.instance_exists(A.obj_autoscroll):
			for inst in GM.with_list(A.obj_autoscroll):
				inst.hspeed = 0.0
	elif GM.keyboard_check(G.arriba) and lock == 0.0 and get_v == 0.0 and GM.instance_exists(A.obj_mario) and place_meeting(x, y, A.obj_mario) and GM.instance_find(A.obj_mario, 0).state != 2.0 and visible == true and y > (GM.instance_find(A.obj_mario, 0).y + 10.0) and y < (GM.instance_find(A.obj_mario, 0).y + 17.0) and GM.instance_find(A.obj_mario, 0).x >= x and GM.instance_find(A.obj_mario, 0).x <= (x + 16.0) and sprite_index == s_doorlock_unlock:
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
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()
		if GM.instance_exists(A.obj_autoscroll):
			for inst in GM.with_list(A.obj_autoscroll):
				inst.hspeed = 0.0
		alarm[0] = 55.0


# from objects/obj_door_lock_exit/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_doormario):
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.alarm[2] = self.time_blow
		for inst in GM.with_list(returndoor):
			inst.get_v = 1.0
			inst.alarm[4] = 40.0
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
		for inst in GM.with_list(A.obj_doormario):
			inst.instance_destroy()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(0)
		GM.other = _o
		alarm[1] = 15.0


# from objects/obj_door_lock_exit/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(returndoor):
		for inst in GM.with_list(returndoor):
			inst.image_index = 0.0
			inst.sprite_index = inst.s_doorlock_unlock_close
			inst.image_speed = 0.12


# from objects/obj_door_lock_exit/Alarm_3.gml
func _alarm_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_door_open(self), 0.0, false)
	image_speed = 0.12
	alarm[0] = 55.0


# from objects/obj_door_lock_exit/Alarm_4.gml
func _alarm_4() -> void:
	get_v = 0.0


# from objects/obj_door_lock_exit/Other_7.gml
func _animation_end() -> void:
	if sprite_index == s_doorlock_anim:
		sprite_index = s_doorlock_unlock
		image_index = 0.0
		image_speed = 0.0
		alarm[3] = 20.0
	elif sprite_index == s_doorlock_unlock:
		image_speed = 0.0
		image_index = 2.0
	elif sprite_index == s_doorlock_unlock_close:
		sprite_index = s_doorlock_unlock
		image_speed = 0.0
		image_index = 0.0
		GM.audio_play_sound(Scr.scr_snd_door_close(self), 0.0, false)


# from objects/obj_door_lock_exit/Draw_0.gml
func _gm_draw() -> void:
	if sprite_index == s_doorlock_anim:
		GM.draw_sprite_ext(sprite_index, image_index, (x + 8.0), y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
	else:
		GM.draw_sprite(sprite_index, image_index, x, y)
