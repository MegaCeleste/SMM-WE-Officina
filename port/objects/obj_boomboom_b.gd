# 第 8 批移植；逐事件对照原版。
extends "res://objects/obj_boomboom.gd"


# from objects/obj_boomboom_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_boomboom = A.spr_SMB_boomboom_b
			s_boomboom2 = A.spr_SMB_boomboom2_b
			s_boomboom3 = A.spr_SMB_boomboom3_b
			s_boomboom_dead = A.spr_SMB_boomboom_dead_b
		1.0:
			s_boomboom = A.spr_SMB3_boomboom_b
			s_boomboom2 = A.spr_SMB3_boomboom2_b
			s_boomboom3 = A.spr_SMB3_boomboom3_b
			s_boomboom_dead = A.spr_SMB3_boomboom_dead_b
		2.0:
			s_boomboom = A.spr_boomboom_b
			s_boomboom2 = A.spr_boomboom2_b
			s_boomboom3 = A.spr_boomboom3_b
			s_boomboom_dead = A.spr_boomboom_dead_b
	sprite_index = s_boomboom3
	steps_count = 0.0
	step_inter = 0.0
	hardness = 0.0
	stomp = 1.0
	edible = 2.0
	direct = -1.0
	ready_v = 1.0
	inv = 0.0
	hitpoints = 3.0
	firehitpoints = 14.0
	increment = 1.0
	wings = 0.0
	w_wings = 0.0
	apilar = 0.0
	innave = 0.0
	dead_h = 0.0
	key = 0.0
	cooldown = 0.0
	swimming = 0.0
	image_speed = 0.15
	alarm[10] = 80.0
	alarm[3] = 240.0


# from objects/obj_boomboom_b/Step_2.gml
func _step_end() -> void:
	var steps_sound: float = 0.0
	match increment:
		1.0:
			if gravity == 0.0 and ready_v == 1.0:
				hspeed = (maxf(0.0, (absf(hspeed) - 0.30)) * GM.gm_sign(hspeed))
				if absf(hspeed) < 0.30:
					hspeed = 0.0
	if G.apariencia == 2.0 and hspeed != 0.0 and vspeed == 0.0:
		match increment:
			1.0:
				steps_sound = 14.0
			1.5:
				steps_sound = 10.0
			2.0:
				steps_sound = 9.0
		if steps_count == 0.0:
			if step_inter == 0.0:
				GM.audio_play_sound(A.snd_boomboom_step1, 0.0, false)
			else:
				GM.audio_play_sound(A.snd_boomboom_step2, 0.0, false)
			if step_inter == 0.0:
				step_inter = 1.0
			else:
				step_inter = 0.0
			steps_count = steps_sound
		else:
			steps_count -= 1.0
	else:
		steps_count = 0.0
		step_inter = 0.0


# from objects/obj_boomboom_b/Alarm_3.gml
func _alarm_3() -> void:
	if increment == 1.0:
		ready_v = 1.0
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -6.0
		else:
			hspeed = 6.0
		alarm[1] = -1.0
		alarm[9] = -1.0
		alarm[10] = -1.0
		alarm[11] = -1.0
		alarm[4] = -1.0
		alarm[2] = 1.0
	elif GM.eq(increment, 1.5):
		if vspeed == 0.0:
			alarm[1] = -1.0
			alarm[9] = -1.0
			alarm[10] = -1.0
			alarm[11] = -1.0
			sprite_index = s_boomboom3
			image_speed = 0.0
			image_index = 0.0
			hspeed = 0.0
			alarm[4] = 20.0
		else:
			alarm[3] = 60.0


# from objects/obj_boomboom_b/Alarm_4.gml
func _alarm_4() -> void:
	sprite_index = s_boomboom
	image_speed = (0.2 * increment)
	stomp = 4.0
	ready_v = 0.0
	vspeed = (-(6.0 - (4.0 * swimming)))
	alarm[11] = 60.0
	alarm[3] = 120.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = (-3.0 * increment)
	else:
		hspeed = (3.0 * increment)


# from objects/obj_boomboom_b/Alarm_9.gml
func _alarm_9() -> void:
	image_speed = (0.2 * increment)
	vspeed = (-(6.0 - (4.0 * swimming)))
	y -= 1.0
	alarm[1] = 120.0
	alarm[11] = 60.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = -2.0
	else:
		hspeed = 2.0


# from objects/obj_boomboom_b/Alarm_10.gml
func _alarm_10() -> void:
	image_speed = (0.2 * increment)
	stomp = 4.0
	ready_v = 0.0
	vspeed = (-(3.0 - (2.0 * swimming)))
	y -= 1.0
	alarm[11] = 60.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = (-1.2 * increment)
	else:
		hspeed = (1.2 * increment)


# from objects/obj_boomboom_b/Alarm_11.gml
func _alarm_11() -> void:
	if hspeed != 0.0:
		image_speed = (0.2 * increment)
		alarm[11] = 30.0
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = (-1.2 * increment)
		else:
			hspeed = (1.2 * increment)
	else:
		alarm[11] = 5.0


# from objects/obj_boomboom_b/Other_11.gml
func _user_1() -> void:
	# /Default hurt script
	# If not ready
	if ready_v == 0.0:
		# Stop horizontal speed
		hspeed = 0.0
		# If boom-boom has only one hp left
		if hitpoints == 1.0:
			# Set defeat sprite
			sprite_index = s_boomboom_dead
			# Get 4000 points
			var _other_0: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create(((GM.gm_round((bbox_left + bbox_right)) / 2.0) - 8.0), bbox_top, A.obj_score)):
				inst.event_user(5)
			GM.other = _other_0
			if key == 1.0:
				for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
					inst.vspeed = -4.0
				key = 0.0
			# Explode
			alarm[0] = 120.0
		# Otherwise, decrement hitpoints
		else:
			# Set hurt sprite
			match G.apariencia:
				0.0:
					sprite_index = s_boomboom_dead
				1.0:
					sprite_index = s_boomboom_dead
				2.0:
					sprite_index = A.spr_boomboom_hurt_b
			# Get 1000 / 2000 points
			if hitpoints == 3.0:
				hitpoints = 2.0
				increment = 1.5
				var _other_1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(GM.instance_create(((GM.gm_round((bbox_left + bbox_right)) / 2.0) - 8.0), bbox_top, A.obj_score)):
					inst.event_user(5)
				GM.other = _other_1
			else:
				hitpoints = 1.0
				increment = 2.0
				var _other_2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(GM.instance_create(((GM.gm_round((bbox_left + bbox_right)) / 2.0) - 8.0), bbox_top, A.obj_score)):
					inst.event_user(6)
				GM.other = _other_2
			# Return to normal
			alarm[2] = 60.0
		# Prevent getting stomped
		ready_v = 1.0
		# Animate
		image_speed = 0.15
		# Reset alarms
		alarm[1] = -1.0
		alarm[9] = -1.0
		alarm[10] = -1.0
		alarm[11] = -1.0
		alarm[3] = -1.0
		alarm[4] = -1.0
		# Set vulnerability
		stomp = -1.0
