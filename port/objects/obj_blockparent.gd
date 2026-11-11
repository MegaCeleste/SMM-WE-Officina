extends "res://objects/obj_solid.gd"

var ready_v: float = 0.0  # 改名(ready)，同 Node.ready
var tipo: float = 0.0
var subimagen: float = 0.0
var wings: float = 0.0
var wings_anim: float = 0.0
var downwards: float = 0.0
var s_scalex: float = 0.0
var s_scaley: float = 0.0
var expand: float = 0.0
var expand2: float = 0.0
var expand3: float = 0.0
var sprite_wings: float = 0.0


# from objects/obj_blockparent/Create_0.gml
func _create() -> void:
	ready_v = 0.0
	tipo = A.spr_shard
	subimagen = 0.0
	wings = 0.0
	wings_anim = 0.0
	downwards = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	expand = 0.0
	expand2 = 0.0
	expand3 = 0.0
	match G.apariencia:
		0.0:
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_wings = A.spr_wings_items


# from objects/obj_blockparent/Step_1.gml
func _step_begin() -> void:
	var _max_scale = 1.3
	var _min_scale = 1.0
	var _scale_increment = 0.06
	var _scale_decrement = 0.07
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


# from objects/obj_blockparent/Step_0.gml
func _step() -> void:
	var col_mario
	var col_estalactita
	var shell_left
	var shell_right
	var held
	var cap
	var cap2
	col_mario = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_mario, true, false)
	if GM.instance_exists(A.obj_mario):
		var _mario = GM.instance_find(A.obj_mario, 0)
		if col_mario != null and G.powerup == -77.0 and G.yoshi == 0.0 and _mario.can_break_block == 1.0 and object_index != A.obj_onoffblock and object_index != A.obj_noteblock:
			alarm[2] = 1.0
			for inst in GM.with_list(A.obj_mario):
				inst.jumpnow = 2.0
				inst.state = 2.0
				inst.alarm[4] = 15.0
				if inst.isswim == 1.0:
					inst.vspeed = -2.0
				else:
					inst.vspeed = -4.0
				inst.y -= 1.0
	col_estalactita = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_icicle, true, false)
	if col_estalactita != null and ready_v == 0.0 and col_estalactita.vspeed > 0.0:
		ready_v = 1.0
		vspeed = -2.0
		if object_index == A.obj_noteblock or object_index == A.obj_musicblock or object_index == A.obj_noteblock_s:
			alarm[0] = 7.0
		else:
			alarm[0] = 4.0
		event_user(0)
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_estalactita):
			inst.event_user(0)
		GM.other = _o1
	if object_index == A.obj_block or object_index == A.obj_block_multicoin or object_index == A.obj_flipblock:
		shell_left = collision_rectangle(((bbox_left - 9.0) - hspeed), (bbox_top + 4.0), bbox_left, bbox_bottom, A.obj_shell_held, false, false)
		shell_right = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 9.0) + hspeed), bbox_bottom, A.obj_shell_held, false, false)
		var spike_left = collision_rectangle(((bbox_left - 9.0) - hspeed), bbox_top, bbox_left, bbox_bottom, A.obj_spike_ball_b, false, false)
		var spike_right = collision_rectangle(bbox_right, bbox_top, ((bbox_right + 9.0) + hspeed), bbox_bottom, A.obj_spike_ball_b, false, false)
		if (shell_left != null and shell_left.sprite_height > 19.0 and shell_left.hspeed > 0.0) or (shell_right != null and shell_right.sprite_height > 19.0 and shell_right.hspeed < 0.0) or (spike_left != null and spike_left.hspeed > 0.0) or (spike_right != null and spike_right.hspeed < 0.0):
			alarm[2] = 1.0
	held = collision_rectangle((bbox_left + 1.0), bbox_bottom, (bbox_right - 1.0), (bbox_bottom + 4.0), A.obj_holdparent, false, false)
	if held != null and ready_v == 0.0 and held.vspeed < 0.0 and held.bbox_top > (bbox_bottom + held.vspeed):
		ready_v = 1.0
		vspeed = -2.0
		alarm[0] = 4.0
		event_user(0)
	cap = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_cap_mario, false, false)
	cap2 = collision_rectangle(bbox_left, (bbox_top + 1.0), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_cap_mario, false, false)
	var _mario2 = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario) and ready_v == 0.0 and (_mario2.caped == 1.0 or _mario2.stompstyle == 1.0) and ((cap2 != null and cap2.x < bbox_left) or (cap != null and cap.x > bbox_right)):
		ready_v = 1.0
		vspeed = -2.0
		alarm[0] = 4.0
		event_user(0)
	if speed == 0.0:
		depth = 9.0
	else:
		depth = -2.0


# from objects/obj_blockparent/Alarm_0.gml
func _alarm_0() -> void:
	alarm[1] = 4.0
	vspeed = 2.0


# from objects/obj_blockparent/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	ready_v = 0.0


# from objects/obj_blockparent/Alarm_2.gml
func _alarm_2() -> void:
	var col_enemy
	col_enemy = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_enemyparent, true, false)
	if col_enemy != null and col_enemy.hardness < 99.0 and col_enemy.object_index != A.obj_grinder and col_enemy.object_index != A.obj_piranhaplant and col_enemy.object_index != A.obj_rocky and col_enemy.object_index != A.obj_boo and col_enemy.object_index != A.obj_charginchuck and col_enemy.object_index != A.obj_NSMBU_charginchuck:
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_enemy):
			GM.audio_play_sound(Scr.scr_snd_kick(inst), 0.0, false)
			var _o3: GMObject = GM.other
			GM.other = inst
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_score)):
				inst2.event_user(0)
			GM.other = _o3
			if inst.object_index == A.obj_koopa or inst.object_index == A.obj_koopa_red or inst.object_index == A.obj_buzzybeetle or inst.object_index == A.obj_spiny or inst.object_index == A.obj_galoomba or inst.object_index == A.obj_snow_ball_held or inst.object_index == A.obj_shell_held:
				inst.event_user(5)
			elif inst.object_index == A.obj_galoomba and G.apariencia == 2.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), inst.y, A.obj_galoomba_hold)):
					inst2.set("direct", inst.get("direct"))
					inst2.vspeed = -2.2
			elif inst.object_index == A.obj_galoomba2 and G.apariencia == 2.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), inst.y, A.obj_galoomba_hold2)):
					inst2.set("direct", inst.get("direct"))
					inst2.vspeed = -2.2
			elif inst.object_index == A.obj_bobomb or inst.object_index == A.obj_bobomb_ready:
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), inst.y, A.obj_bobomb_hold)):
					inst2.set("direct", inst.get("direct"))
					inst2.vspeed = -2.2
			else:
				inst.event_user(0)
		GM.other = _o2
	match G.apariencia:
		0.0:
			match sprite_index:
				A.spr_SMB_empty_block:
					tipo = A.spr_SMB_shard_empty
					subimagen = image_index
				A.spr_SMB_qblock:
					tipo = A.spr_SMB_shard
					subimagen = image_index
				A.spr_SMB_block:
					tipo = A.spr_SMB_shard_item
					subimagen = 0.0
				A.spr_SMB_block_night:
					tipo = A.spr_SMB_shard_item
					subimagen = 1.0
				A.spr_SMB_block_dark:
					tipo = A.spr_SMB_shard_item
					subimagen = 2.0
				A.spr_SMB_block_snow:
					tipo = A.spr_SMB_shard_item
					subimagen = 3.0
				A.spr_SMB_block_ice:
					tipo = A.spr_SMB_shard_item
					subimagen = 4.0
		1.0:
			match sprite_index:
				A.spr_SMB3_empty_block:
					tipo = A.spr_SMB3_shard
					subimagen = image_index
				A.spr_SMB3_qblock:
					tipo = A.spr_SMB3_shard
					subimagen = 0.0
				A.spr_SMB3_block:
					tipo = A.spr_SMB3_shard
					subimagen = 0.0
				A.spr_SMB3_qblock_night:
					tipo = A.spr_SMB3_shard
					subimagen = 1.0
				A.spr_SMB3_block_night:
					tipo = A.spr_SMB3_shard
					subimagen = 1.0
				A.spr_SMB3_qblock_dark:
					tipo = A.spr_SMB3_shard
					subimagen = 2.0
				A.spr_SMB3_block_dark:
					tipo = A.spr_SMB3_shard
					subimagen = 2.0
				_:
					tipo = A.spr_SMB3_shard
					subimagen = 3.0
		2.0:
			subimagen = 0.0
			if sprite_index == A.spr_qblock_empty:
				tipo = A.spr_shard_th
			else:
				tipo = A.spr_shard
		3.0:
			match sprite_index:
				A.spr_NSMBU_qblock_empty:
					tipo = A.spr_NSMBU_shard
					subimagen = 0.0
				A.spr_NSMBU_block:
					tipo = A.spr_NSMBU_shard
					subimagen = 0.0
				A.spr_NSMBU_block_night:
					tipo = A.spr_NSMBU_shard
					subimagen = 1.0
				A.spr_NSMBU_block_dark:
					tipo = A.spr_NSMBU_shard
					subimagen = 2.0
				_:
					tipo = A.spr_NSMBU_shard
					subimagen = 0.0
	GM.audio_stop_sound(Scr.scr_snd_break(self))
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(45.0, 5.0)
		inst.sprite_index = int(tipo)
		inst.image_index = subimagen
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 12.0), A.obj_shard)):
		inst.motion_set(60.0, 5.0)
		inst.sprite_index = int(tipo)
		inst.image_index = subimagen
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 12.0), A.obj_shard)):
		inst.motion_set(120.0, 5.0)
		inst.sprite_index = int(tipo)
		inst.image_index = subimagen
		inst.dir = 0.0
	for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(135.0, 5.0)
		inst.sprite_index = int(tipo)
		inst.image_index = subimagen
		inst.dir = 0.0
	instance_destroy()


# from objects/obj_blockparent/Alarm_3.gml
func _alarm_3() -> void:
	alarm[1] = 4.0
	vspeed = -2.0


# from objects/obj_blockparent/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if vspeed < 0.0 and o.bbox_bottom < (yprevious + 5.0) and o.groundpount == 0.0:
		o.vspeed = (-(3.0 - (2.0 * o.isswim)))
		o.y -= 1.0


# from objects/obj_blockparent/Collision_obj_meteorites.gml
func _collision_obj_meteorites(other: GMObject) -> void:
	if G.apariencia == 0.0 or G.apariencia == 1.0:
		GM.audio_play_sound(A.snd_SMB3_break, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_break, 0.0, false)
	instance_destroy()
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(45.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(60.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(120.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(135.0, 6.0)
	GM.instance_destroy(other)


# from objects/obj_blockparent/Collision_obj_meteorites_big.gml
func _collision_obj_meteorites_big(other: GMObject) -> void:
	if G.apariencia == 0.0 or G.apariencia == 1.0:
		GM.audio_play_sound(A.snd_SMB3_break, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_break, 0.0, false)
	instance_destroy()
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		if G.apariencia == 0.0:
			inst.sprite_index = A.spr_SMB_shard
		elif G.apariencia == 1.0:
			inst.sprite_index = A.spr_SMB3_shard
		elif G.apariencia == 2.0:
			inst.sprite_index = A.spr_shard
		elif G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(45.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		if G.apariencia == 0.0:
			inst.sprite_index = A.spr_SMB_shard
		elif G.apariencia == 1.0:
			inst.sprite_index = A.spr_SMB3_shard
		elif G.apariencia == 2.0:
			inst.sprite_index = A.spr_shard
		elif G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(60.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		if G.apariencia == 0.0:
			inst.sprite_index = A.spr_SMB_shard
		elif G.apariencia == 1.0:
			inst.sprite_index = A.spr_SMB3_shard
		elif G.apariencia == 2.0:
			inst.sprite_index = A.spr_shard
		elif G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(120.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
		if G.apariencia == 0.0:
			inst.sprite_index = A.spr_SMB_shard
		elif G.apariencia == 1.0:
			inst.sprite_index = A.spr_SMB3_shard
		elif G.apariencia == 2.0:
			inst.sprite_index = A.spr_shard
		elif G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(135.0, 6.0)


# from objects/obj_blockparent/Other_11.gml
func _user_1() -> void:
	ready_v = 1.0
	vspeed = -2.0
	alarm[0] = 4.0
	event_user(0)


# from objects/obj_blockparent/Other_12.gml
func _user_2() -> void:
	ready_v = 1.0
	vspeed = -2.0
	alarm[0] = 5.0
	event_user(0)


# from objects/obj_blockparent/Other_13.gml
func _user_3() -> void:
	ready_v = 1.0
	downwards = 1.0
	vspeed = 2.0
	alarm[3] = 5.0
	event_user(0)


# from objects/obj_blockparent/Other_25.gml
func _user_15() -> void:
	GM.audio_stop_sound(Scr.scr_snd_break(self))
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 4.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(45.0, 6.0)
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 12.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(60.0, 6.0)
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 12.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(120.0, 6.0)
		inst.dir = 0.0
	for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 4.0), A.obj_shard)):
		match G.apariencia:
			0.0:
				inst.sprite_index = A.spr_SMB_shard
			1.0:
				inst.sprite_index = A.spr_SMB3_shard
			2.0:
				inst.sprite_index = A.spr_shard
			3.0:
				inst.sprite_index = A.spr_NSMBU_shard
		inst.motion_set(135.0, 6.0)
		inst.dir = 0.0
	instance_destroy()


# from objects/obj_blockparent/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, x, y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	# draw_sprite_stretched(sprite_index,anim,x-(ystart-y)/4,y-(ystart-y)/4,16+(ystart-y)/2,16+(ystart-y)/2)
