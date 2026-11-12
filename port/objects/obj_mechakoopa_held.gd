# from objects/obj_mechakoopa_held（第 5 批移植，已核对）
extends "res://objects/obj_galoomba_hold.gd"

var s_dry: float = 0.0


# from objects/obj_mechakoopa_held/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_mechakoopa_green_squashed
			s_dry = A.spr_SMB_mechakoopa_green_deads
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_mechakoopa_green_squashed
			s_dry = A.spr_SMB3_mechakoopa_green_deads
			image_speed = 0.0
		2.0:
			s_dry = A.spr_mechakoopa_green_deads
			image_speed = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_mechakoopa_green_squashed
			s_dry = A.spr_NSMBU_mechakoopa_green_deads
			image_speed = 0.0
	key = 0.0
	hitpoint = 0.0
	dead_h = 0.0
	apilar = 0.0
	direct = 1.0
	shake = 0.0
	if G.apariencia == 3.0:
		alarm[1] = 240.0
	else:
		alarm[5] = 8.0


# from objects/obj_mechakoopa_held/Alarm_0.gml
func _alarm_0() -> void:
	image_index = 1.0
	alarm[1] = 240.0


# from objects/obj_mechakoopa_held/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_mechakoopa_green_shake
		image_index = 0.0
		image_speed = 0.3
		alarm[2] = 200.0
		return
	if shake < 10.0:
		x += 1.0
		shake += 1.0
		alarm[2] = 5.0
	else:
		alarm[4] = 8.0
		image_index = 0.0


# from objects/obj_mechakoopa_held/Alarm_2.gml
func _alarm_2() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_mechakoopa_green_awake
		image_index = 0.0
		image_speed = 0.5
		return
	x -= 1.0
	alarm[1] = 5.0


# from objects/obj_mechakoopa_held/Alarm_3.gml
func _alarm_3() -> void:
	inmune = 0.0


# from objects/obj_mechakoopa_held/Alarm_4.gml
func _alarm_4() -> void:
	if GM.instance_exists(A.obj_player_warp):
		alarm[4] = 240.0
	else:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_mechakoopa)):
			inst.direct = self.image_xscale
		instance_destroy()


# from objects/obj_mechakoopa_held/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_mechakoopa_green_awake:
		alarm[4] = 1.0


# from objects/obj_mechakoopa_held/Other_10.gml
func _user_0() -> void:
	var i: float
	i = 0.0
	while i < 4.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
			inst.girar = 1.0
			inst.direct = self.direct
			inst.sprite_index = int(self.s_dry)
			inst.hspeed = GM.random_range(-1.0, 1.0)
			inst.image_speed = 0.0
			inst.image_index = i
		i += 1.0
	instance_destroy()


# from objects/obj_mechakoopa_held/Other_11.gml
func _user_1() -> void:
	var o = GM.other  # PORT: 事件方法外的 other（第 17 条），取一次放局部，with 块内改 GM.other 不影响后面读 other
	if hitpoint == 1.0 and GM.instance_exists(A.obj_mario):
		if (GM.instance_find(A.obj_mario, 0).bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			hspeed = -4.2
			direct = -1.0
		else:
			hspeed = 4.2
			direct = 1.0
		hitpoint = 0.0
		return
	if o.stompstyle == 1.0 or G.yoshi > 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(o):
			inst.event_user(1)
		GM.other = _o
		if G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_NSMBU_stomp, 0.0, false)
		else:
			GM.audio_play_sound(A.snd_stomp, 0.0, false)
		for inst in GM.with_list(GM.instance_create(o.x, (o.y + 22.0), A.obj_spinthump)):
			inst.image_xscale = 0.8
			inst.image_yscale = 0.8
		if (o.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			hspeed = -4.2
			direct = -1.0
		else:
			hspeed = 4.2
			direct = 1.0


# from objects/obj_mechakoopa_held/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, 1.0, 0.0, GM.c_white, 1.0)
