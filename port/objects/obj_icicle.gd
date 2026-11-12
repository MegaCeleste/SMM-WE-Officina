extends "res://objects/obj_platform_parent.gd"

var crecer: float = 0.0
var rotacion: float = 0.0
var rot: float = 0.0
var up: float = 0.0
var v_speed: float = 0.0
var caer: float = 0.0
var delito: float = 0.0


# from objects/obj_icicle/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	crecer = 0.0
	rotacion = 0.0
	rot = 0.0
	up = 0.0
	v_speed = 2.0
	caer = 0.0
	delito = 0.0
	alarm[2] = 120.0


# from objects/obj_icicle/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 原版写 obj_mario.xxx（第一个实例）
		if collision_rectangle(bbox_left, (bbox_top - 5.0), bbox_right, (bbox_top + 4.0), A.obj_mario, false, false) != null and mario.bbox_bottom < (yprevious + 5.0) and mario.state < 2.0 and caer == 0.0:
			rot = 1.0
			alarm[0] = 60.0
			caer = 1.0
		if GM.instance_exists(A.obj_mario) and mario.x > (x - 48.0) and mario.x < (x + 48.0) and y < mario.y and y > (mario.y - 176.0) and caer == 0.0:
			rot = 1.0
		if GM.instance_exists(A.obj_mario) and (mario.x < (x - 48.0) or mario.x > (x + 48.0) or y > mario.y or y < (mario.y - 176.0)) and caer == 0.0:
			rot = 0.0
			rotacion = 0.0
			up = 0.0
		if GM.instance_exists(A.obj_mario) and mario.x > (x - 32.0) and mario.x < (x + 32.0) and y < mario.y and y > (mario.y - 176.0) and caer == 0.0:
			rot = 1.0
			alarm[0] = 60.0
			caer = 1.0
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		v_speed = 1.0
	else:
		v_speed = 2.0
	if vspeed > v_speed:
		vspeed = v_speed
	if rot == 1.0:
		if up == 0.0:
			if rotacion > -5.0:
				rotacion -= 1.0
			else:
				up = 1.0
		elif up == 1.0:
			if rotacion < 5.0:
				rotacion += 1.0
			else:
				up = 0.0
	if crecer == 1.0:
		if image_xscale < 1.0:
			image_xscale += 0.05
			image_yscale += 0.05
		else:
			image_xscale = 1.0
			image_yscale = 1.0
			crecer = 0.0
	if bbox_top > (GM.room_height + 64.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and delito == 0.0:
		delito = 1.0
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
		alarm[1] = 180.0


# from objects/obj_icicle/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_fall)
			GM.audio_play_sound(A.snd_SMB3_estalactita_fall, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_fall)
			GM.audio_play_sound(A.snd_SMB3_estalactita_fall, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_estalactita_fall)
			GM.audio_play_sound(A.snd_estalactita_fall, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_estalactita_fall)
			GM.audio_play_sound(A.snd_NSMBU_estalactita_fall, 0.0, false)
	gravity = 0.15
	rot = 0.0
	rotacion = 0.0


# from objects/obj_icicle/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create(xstart, ystart, A.obj_icicle)):
		inst.image_xscale = 0.2
		inst.image_yscale = 0.2
		inst.crecer = 1.0
	instance_destroy()


# from objects/obj_icicle/Alarm_2.gml
func _alarm_2() -> void:
	GM.instance_create((x - 2.0), bbox_bottom, A.obj_gotas)
	alarm[2] = 120.0


# from objects/obj_icicle/Collision_obj_helmet.gml
func _collision_obj_helmet(other: GMObject) -> void:
	if vspeed > 0.0 and gravity != 0.0:
		_user_0()


# from objects/obj_icicle/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed >= 0.0:
		var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 原版写 obj_mario.xxx（第一个实例）
		if collision_rectangle(bbox_left, (bbox_top - 5.0), bbox_right, (bbox_top + 4.0), A.obj_mario, false, false) != null and mario.y < (y - 26.0) and mario.state < 2.0:
			for inst in GM.with_list(A.obj_mario):
				inst.y = ceilf((bbox_top - 32.0))
	elif other.invincible == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
		if object_index != A.obj_icicle2 and object_index != A.obj_mini_icicle2:
			_user_0()


# from objects/obj_icicle/Collision_obj_pinchos.gml
func _collision_obj_pinchos(other: GMObject) -> void:
	if vspeed > 0.0 and gravity != 0.0:
		_user_0()


# from objects/obj_icicle/Collision_obj_solidtop.gml
func _collision_obj_solidtop(other: GMObject) -> void:
	if vspeed > 0.0 and gravity != 0.0:
		_user_0()


# from objects/obj_icicle/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_estalactita_break)
			GM.audio_play_sound(A.snd_estalactita_break, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_estalactita_break)
			GM.audio_play_sound(A.snd_NSMBU_estalactita_break, 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 4.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(30.0, 5.0)
		inst.sprite_index = A.spr_icicle_break
		inst.image_index = G.apariencia
		inst.dir = 1.0
		inst.direct = -1.0
	for inst in GM.with_list(GM.instance_create((x - 4.0), (y + 12.0), A.obj_shard)):
		inst.motion_set(45.0, 5.0)
		inst.sprite_index = A.spr_icicle_break
		inst.image_index = G.apariencia
		inst.dir = 1.0
		inst.direct = -1.0
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 12.0), A.obj_shard)):
		inst.motion_set(135.0, 5.0)
		inst.sprite_index = A.spr_icicle_break
		inst.image_index = G.apariencia
		inst.dir = 0.0
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(150.0, 5.0)
		inst.sprite_index = A.spr_icicle_break
		inst.image_index = G.apariencia
		inst.dir = 0.0
	y = (GM.room_height + 64.0)


# from objects/obj_icicle/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, image_xscale, image_yscale, rotacion, GM.c_white, 1.0)
