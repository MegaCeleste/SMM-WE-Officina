extends "res://objects/obj_enemyparent.gd"

var s_magikoopa: float = 0.0
var s_magikoopa_appear: float = 0.0
var s_magikoopa_disappear: float = 0.0
var xmin: float = 0.0
var xmax: float = 0.0
var edible: float = 0.0
var w_wings: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）


# from objects/obj_magikoopa/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_magikoopa
			s_magikoopa = A.spr_SMB_magikoopa
			s_magikoopa_appear = A.spr_SMB_magikoopa_appear
			s_magikoopa_disappear = A.spr_SMB_magikoopa_disappear
		1.0:
			sprite_index = A.spr_SMB3_magikoopa
			s_magikoopa = A.spr_SMB3_magikoopa
			s_magikoopa_appear = A.spr_SMB3_magikoopa_appear
			s_magikoopa_disappear = A.spr_SMB3_magikoopa_disappear
		2.0:
			s_magikoopa = A.spr_magikoopa
			s_magikoopa_appear = A.spr_magikoopa_appear
			s_magikoopa_disappear = A.spr_magikoopa_disappear
		3.0:
			sprite_index = A.spr_NSMBU_magikoopa
			s_magikoopa = A.spr_NSMBU_magikoopa
			s_magikoopa_appear = A.spr_NSMBU_magikoopa_appear
			s_magikoopa_disappear = A.spr_NSMBU_magikoopa_disappear
	xmin = 0.0
	xmax = GM.room_width
	hardness = 1.0
	stomp = 0.0
	edible = 2.0
	direct = -1.0
	swimming = 0.0
	wings = 0.0
	w_wings = 0.0
	apilar = 0.0
	dead_h = 0.0
	innave = 0.0
	ready_v = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.0


# from objects/obj_magikoopa/Step_0.gml
func _step() -> void:
	if ready_v == 0.0:
		if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > xmin and GM.instance_find(A.obj_mario, 0).x < xmax:
			if G.apariencia == 3.0 and (Scr.outside_view(self) <= 0.5):
				GM.audio_stop_sound(A.snd_NSMBU_kamek_disappear)
				GM.audio_play_sound(A.snd_NSMBU_kamek_disappear, 0.0, false)
			sprite_index = s_magikoopa_disappear
			image_index = 0.0
			image_speed = 0.4
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_magikoopa_effect
				inst.image_speed = 0.4
				inst.depth = (self.depth + 1.0)
			hardness = 100.0
			stomp = -1.0
			ready_v = 1.0
	elif ready_v == 2.0:
		if G.apariencia == 3.0 and (Scr.outside_view(self) <= 0.5):
			GM.audio_stop_sound(A.snd_NSMBU_kamek_appear)
			GM.audio_play_sound(A.snd_NSMBU_kamek_appear, 0.0, false)
		visible = true
		sprite_index = s_magikoopa_appear
		image_index = 0.0
		image_speed = 0.4
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_magikoopa_effect
			inst.image_speed = 0.4
			inst.depth = (self.depth + 1.0)
		ready_v = 1.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if ready_v == 1.0:
		_user_4()
	if G.apariencia == 3.0 and sprite_index == A.spr_NSMBU_magikoopa_atack:
		if image_index >= 9.0 and image_index < 9.5:
			alarm[0] = 1.0


# from objects/obj_magikoopa/Alarm_0.gml
func _alarm_0() -> void:
	if Scr.outside_view(self) <= 0.5:
		match G.apariencia:
			0.0:
				GM.audio_stop_sound(A.snd_SMB3_magicbean)
				GM.audio_play_sound(A.snd_SMB3_magicbean, 0.0, false)
			1.0:
				GM.audio_stop_sound(A.snd_SMB3_magicbean)
				GM.audio_play_sound(A.snd_SMB3_magicbean, 0.0, false)
			2.0:
				GM.audio_stop_sound(A.snd_magicbean)
				GM.audio_play_sound(A.snd_magicbean, 0.0, false)
			3.0:
				GM.audio_stop_sound(A.snd_NSMBU_magic)
				GM.audio_play_sound(A.snd_NSMBU_magic, 0.0, false)
		if direct == 1.0:
			GM.instance_create((x + 14.0), (y + 5.0), A.obj_magic)
		else:
			GM.instance_create((x - 14.0), (y + 5.0), A.obj_magic)
	if G.apariencia != 3.0:
		image_speed = 0.09
	alarm[1] = 70.0


# from objects/obj_magikoopa/Alarm_1.gml
func _alarm_1() -> void:
	ready_v = 0.0


# from objects/obj_magikoopa/Alarm_2.gml
func _alarm_2() -> void:
	var semisolid: GMObject
	if not GM.instance_exists(A.obj_mario):
		alarm[2] = 1.0
		return
	elif GM.instance_find(A.obj_mario, 0).x > xmin and GM.instance_find(A.obj_mario, 0).x < xmax:
		x = ((floorf((GM.random_range((GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0), ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 16.0)) / 16.0)) * 16.0) + 8.0)
		y = (floorf((GM.random_range((GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) - 16.0)) / 16.0)) * 16.0)
		semisolid = collision_rectangle(x, bbox_bottom, x, (bbox_bottom + 2.0), A.obj_solidtop, false, true)
		if semisolid != null and ready_v == 1.0 and (Scr.tile_layer_find(self, 9.0, (x - 8.0), y) <= 0.5) and (Scr.tile_layer_find(self, 9.0, (x + 7.0), y) <= 0.5) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, true) == null) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_modelbgo, false, true) == null):
			y = (semisolid.bbox_top - 16.0)
			ready_v = 2.0
		else:
			alarm[2] = 1.0
	else:
		alarm[2] = 1.0


# from objects/obj_magikoopa/Alarm_3.gml
func _alarm_3() -> void:
	sprite_index = A.spr_NSMBU_magikoopa_atack
	image_speed = 0.5


# from objects/obj_magikoopa/Other_7.gml
func _animation_end() -> void:
	if sprite_index == s_magikoopa_disappear:
		visible = false
		sprite_index = s_magikoopa
		if G.apariencia == 3.0:
			image_speed = 0.5
		else:
			image_speed = 0.0
		image_index = 0.0
		ready_v = 1.0
		alarm[2] = 160.0
	elif sprite_index == s_magikoopa_appear:
		if place_meeting(x, y, A.obj_mario):
			sprite_index = s_magikoopa_disappear
			image_index = 0.0
			image_speed = 0.4
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_magikoopa_effect
				inst.image_speed = 0.4
				inst.depth = (self.depth + 1.0)
			hardness = 100.0
			stomp = -1.0
			ready_v = 1.0
			return
		sprite_index = s_magikoopa
		if G.apariencia == 3.0:
			image_speed = 0.5
		else:
			image_speed = 0.09
		hardness = 0.0
		stomp = 0.0
		if G.apariencia == 3.0:
			alarm[3] = 50.0
		else:
			alarm[0] = 75.0
	elif sprite_index == A.spr_NSMBU_magikoopa_atack:
		sprite_index = s_magikoopa
		image_speed = 0.5


# from objects/obj_magikoopa/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 3.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_magikoopa_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_magikoopa_deads
		2.0:
			imdead.sprite_index = A.spr_magikoopa_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_magikoopa_deads
	if dead_h == 0.0:
		# ORIG-BUG: other.bbox_left + (bbox_right / 2) 把 other 与 self 的包围盒混用，照搬
		if GM.other.hspeed == 0.0:
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_magikoopa/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_magikoopa/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
