# from objects/obj_onoffblock（第 5 批移植，已核对）
extends "res://objects/obj_blockparent.gd"

var enable: float = 0.0
var w_wings: float = 0.0


# from objects/obj_onoffblock/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_onoffblock_on
		1.0:
			sprite_index = A.spr_SMB3_onoffblock_on
		2.0:
			sprite_index = A.spr_onoffblock_on
		3.0:
			sprite_index = A.spr_NSMBU_onoffblock_on
	image_speed = 0.09
	ready_v = 0.0
	downwards = 0.0
	wings = 0.0
	w_wings = 0.0
	enable = 0.0
	expand = 0.0
	s_scalex = 1.0
	s_scaley = 1.0


# from objects/obj_onoffblock/Destroy_0.gml
func _destroy() -> void:
	G.onoffblock = 0.0


# from objects/obj_onoffblock/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	ready_v = 0.0


# from objects/obj_onoffblock/Alarm_4.gml
func _alarm_4() -> void:
	enable = 0.0


# from objects/obj_onoffblock/Step_1.gml
func _step_begin() -> void:
	var _max_scale: float = 1.3
	var _min_scale: float = 1.0
	var _scale_increment: float = 0.06
	var _scale_decrement: float = 0.2
	if expand == 1.0:
		s_scalex += _scale_increment
		s_scaley += _scale_increment
		if s_scalex > _max_scale:
			expand = 2.0
	elif expand == 2.0:
		s_scalex -= _scale_decrement
		s_scaley -= _scale_decrement
		if s_scalex < _min_scale:
			expand = 0.0
			s_scalex = _min_scale
			s_scaley = _min_scale


# from objects/obj_onoffblock/Draw_0.gml
func _gm_draw() -> void:
	var anim
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	anim = lm.banim3
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, GM.gm_round(x), y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)


# from objects/obj_onoffblock/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			GM.audio_play_sound(A.snd_SMB_switch, 0.0, false)
		1.0:
			GM.audio_play_sound(A.snd_SMB3_switch, 0.0, false)
		2.0:
			GM.audio_play_sound(A.snd_warning, 0.0, false)
		3.0:
			GM.audio_play_sound(A.snd_NSMBU_switch, 0.0, false)
	if enable == 0.0:
		if G.onoffblock == 0.0:
			G.onoffblock = 1.0
			match G.apariencia:
				0.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_SMB_onoffblock_off
				1.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_SMB3_onoffblock_off
				2.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_onoffblock_off
				3.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_NSMBU_onoffblock_off
		else:
			G.onoffblock = 0.0
			match G.apariencia:
				0.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_SMB_onoffblock_on
				1.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_SMB3_onoffblock_on
				2.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_onoffblock_on
				3.0:
					for inst in GM.with_list(A.obj_onoffblock):
						inst.sprite_index = A.spr_NSMBU_onoffblock_on
		for inst in GM.with_list(A.obj_onoffblock):
			inst.enable = 1.0
			inst.alarm[4] = 5.0


# from objects/obj_onoffblock/Other_11.gml
func _user_1() -> void:
	ready_v = 1.0
	vspeed = -2.0
	alarm[0] = 4.0
	expand = 1.0
	_user_0()


# from objects/obj_onoffblock/Step_0.gml
func _step() -> void:
	var col_estalactita
	var held
	var cap
	var cap2
	if G.onoffblock == 0.0:
		match G.apariencia:
			0.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_SMB_onoffblock_on
			1.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_SMB3_onoffblock_on
			2.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_onoffblock_on
			3.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_NSMBU_onoffblock_on
	else:
		match G.apariencia:
			0.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_SMB_onoffblock_off
			1.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_SMB3_onoffblock_off
			2.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_onoffblock_off
			3.0:
				for inst in GM.with_list(A.obj_onoffblock):
					inst.sprite_index = A.spr_NSMBU_onoffblock_off
	col_estalactita = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_icicle, true, false)
	if col_estalactita != null and col_estalactita.vspeed > 0.0:
		ready_v = 1.0
		vspeed = -2.0
		if object_index == A.obj_noteblock:
			alarm[0] = 7.0
		else:
			alarm[0] = 4.0
		_user_0()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_estalactita):
			inst.event_user(0)
		GM.other = _o
	held = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 4.0), A.obj_holdparent, false, false)
	if held != null and held.object_index != A.obj_helmet and held.object_index != A.obj_helmet_spiny and held.vspeed < 0.0 and held.bbox_top > (bbox_bottom + held.vspeed) and ready_v == 0.0:
		ready_v = 1.0
		vspeed = -2.0
		alarm[0] = 4.0
		_user_0()
	cap = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_cap_mario, false, false)
	cap2 = collision_rectangle(bbox_left, (bbox_top + 1.0), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_cap_mario, false, false)
	if (cap2 != null and cap2.x < bbox_left and GM.instance_find(A.obj_mario, 0).caped == 1.0 and ready_v == 0.0) or (cap != null and cap.x > bbox_right and GM.instance_find(A.obj_mario, 0).caped == 1.0 and ready_v == 0.0):
		ready_v = 1.0
		vspeed = -2.0
		alarm[0] = 4.0
		_user_0()
	elif (cap2 != null and cap2.x < bbox_left and GM.instance_find(A.obj_mario, 0).stompstyle == 1.0 and ready_v == 0.0) or (cap != null and cap.x > bbox_right and GM.instance_find(A.obj_mario, 0).stompstyle == 1.0 and ready_v == 0.0):
		ready_v = 1.0
		vspeed = -2.0
		alarm[0] = 4.0
		_user_0()
	if speed == 0.0:
		depth = 9.0
	else:
		depth = -2.0
