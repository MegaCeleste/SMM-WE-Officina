# from objects/obj_rockparent（第 5 批移植，已核对）
extends "res://objects/obj_solid.gd"

# PORT: 原版 shard 只在子类（obj_block_ice / obj_block_rock / obj_icecoin）的 Create 里赋值，
# 父类 Alarm_0 读它；GDScript 的 shard 需要父类声明，所以声明在这里，子类不再重复声明。
var shard: int = 0  ## sprite 编号


# from objects/obj_rockparent/Step_0.gml
func _step() -> void:
	var col_mario = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_mario, true, false)
	if GM.instance_exists(A.obj_mario):
		# obj_mario.can_break_block 读：第 16 条（取第一个实例，UNVERIFIED U15）
		var _mario: GMObject = GM.instance_find(A.obj_mario, 0)
		if col_mario != null and G.powerup == -77.0 and G.yoshi == 0.0 and _mario.can_break_block == 1.0:
			alarm[0] = 1.0
			for inst in GM.with_list(A.obj_mario):
				inst.jumpnow = 2.0
				inst.state = 2.0
				inst.alarm[4] = 15.0
				if inst.isswim == 1.0:
					inst.vspeed = -2.0
				else:
					inst.vspeed = -4.0
				inst.y -= 1.0
	var shell_left = collision_rectangle(((bbox_left - 9.0) - hspeed), (bbox_top + 4.0), bbox_left, bbox_bottom, A.obj_shell_held, false, false)
	var shell_right = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 9.0) + hspeed), bbox_bottom, A.obj_shell_held, false, false)
	var spike_left = collision_rectangle(((bbox_left - 9.0) - hspeed), bbox_top, bbox_left, bbox_bottom, A.obj_spike_ball_b, false, false)
	var spike_right = collision_rectangle(bbox_right, bbox_top, ((bbox_right + 9.0) + hspeed), bbox_bottom, A.obj_spike_ball_b, false, false)
	if (shell_left != null and shell_left.sprite_height > 19.0 and shell_left.hspeed > 0.0) or (shell_right != null and shell_right.sprite_height > 19.0 and shell_right.hspeed < 0.0) or (spike_left != null and spike_left.hspeed > 0.0) or (spike_right != null and spike_right.hspeed < 0.0):
		alarm[0] = 1.0


# from objects/obj_rockparent/Alarm_0.gml
func _alarm_0() -> void:
	_user_0()
	GM.audio_stop_sound(Scr.scr_snd_break(self))
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(45.0, 6.0)
		inst.sprite_index = shard
		inst.image_index = image_index
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 12.0), A.obj_shard)):
		inst.motion_set(60.0, 6.0)
		inst.sprite_index = shard
		inst.image_index = image_index
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 12.0), A.obj_shard)):
		inst.motion_set(120.0, 6.0)
		inst.sprite_index = shard
		inst.image_index = image_index
		inst.dir = 0.0
	for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(135.0, 6.0)
		inst.sprite_index = shard
		inst.image_index = image_index
		inst.dir = 0.0
	instance_destroy()


# from objects/obj_rockparent/Collision_obj_meteorites.gml
func _collision_obj_meteorites(other: GMObject) -> void:
	if G.apariencia == 0.0 or G.apariencia == 1.0:
		GM.audio_play_sound(A.snd_SMB3_break, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_break, 0.0, false)
	instance_destroy()
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(45.0, 6.0)
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(60.0, 6.0)
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(120.0, 6.0)
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(135.0, 6.0)
	GM.instance_destroy(other)


# from objects/obj_rockparent/Collision_obj_meteorites_big.gml
func _collision_obj_meteorites_big(other: GMObject) -> void:
	if G.apariencia == 0.0 or G.apariencia == 1.0:
		GM.audio_play_sound(A.snd_SMB3_break, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_break, 0.0, false)
	instance_destroy()
	# 原版此事件末尾没有 instance_destroy(other)（Collision_obj_meteorites 有），照搬
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_big
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(45.0, 6.0)
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_big
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(60.0, 6.0)
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_big
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(120.0, 6.0)
	for inst in GM.with_list(GM.instance_create((other.x + 8.0), (other.y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_big
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(135.0, 6.0)


# from objects/obj_rockparent/Other_10.gml
func _user_0() -> void:
	var col_enemy = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_enemyparent, true, false)
	if col_enemy != null and col_enemy.hardness < 99.0:
		# with 块内调用了 event_user：GM.other 设为外层 self（§3.3 第 17 条）
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_enemy):
			GM.audio_play_sound(Scr.scr_snd_kick(inst), 0.0, false)
			# 内层 with 的 other 是 inst
			GM.other = inst
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_score)):
				inst2.event_user(0)
			GM.other = self
			if inst.object_index == A.obj_koopa or inst.object_index == A.obj_koopa_red or inst.object_index == A.obj_buzzybeetle or inst.object_index == A.obj_spiny or inst.object_index == A.obj_galoomba or inst.object_index == A.obj_snow_ball_held or inst.object_index == A.obj_shell_held:
				inst.event_user(5)
			elif inst.object_index == A.obj_galoomba and G.apariencia == 2.0:  # ORIG-BUG: 上一个分支已含 obj_galoomba，此分支永远走不到
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), inst.y, A.obj_galoomba_hold)):
					inst2.direct = inst.direct
					inst2.vspeed = -2.2
				inst.instance_destroy()
			elif inst.object_index == A.obj_galoomba2 and G.apariencia == 2.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), inst.y, A.obj_galoomba_hold2)):
					inst2.direct = inst.direct
					inst2.vspeed = -2.2
				inst.instance_destroy()
			elif inst.object_index == A.obj_bobomb or inst.object_index == A.obj_bobomb_ready:
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), inst.y, A.obj_bobomb_hold)):
					inst2.direct = inst.direct
					inst2.vspeed = -2.2
				inst.instance_destroy()
			else:
				inst.event_user(0)
		GM.other = _o
