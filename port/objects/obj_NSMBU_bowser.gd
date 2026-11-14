extends "res://objects/obj_bossparent.gd"

var state: float = 0.0
var big_jump: float = 0.0
var fire_jump: float = 0.0
var fire: float = 0.0
var fire_anim: float = 0.0
var turning: float = 0.0
var jump: float = 0.0
var multi_fire: float = 0.0
var multi_cont: float = 0.0
var imdead = null


# from objects/obj_NSMBU_bowser/Create_0.gml
func _create() -> void:
	super._create()
	cooldown = 0.0
	state = 1.0
	big_jump = 0.0
	fire_jump = 0.0
	fire = 0.0
	fire_anim = 0.0
	turning = 0.0
	jump = 0.0
	multi_fire = 0.0
	multi_cont = 0.0
	swimming = 0.0
	prevhspeed = 0.0
	image_speed = 0.5
	paracaidas = 0.0
	firehitpoints = 50.0
	key = 0.0
	alarm[10] = 2.0


# from objects/obj_NSMBU_bowser/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario) and big_jump == 0.0:
		if GM.instance_find(A.obj_mario, 0).x > x:
			if fire_anim == 0.0 and turning == 0.0 and multi_fire == 0.0 and (jump == 0.0 or big_jump == 1.0):
				hspeed = 0.6
			else:
				if prevhspeed == 0.0:
					prevhspeed = hspeed
				hspeed = 0.0
		elif fire_anim == 0.0 and turning == 0.0 and multi_fire == 0.0 and (jump == 0.0 or big_jump == 1.0):
			if prevhspeed != 0.0:
				hspeed = prevhspeed
				prevhspeed = 0.0
			elif hspeed > 0.0:
				hspeed = 0.3
				if x > (xstart + 64.0):
					hspeed = (-hspeed)
			elif hspeed < 0.0:
				hspeed = -0.3
				if x < (xstart - 64.0):
					hspeed = (-hspeed)
		else:
			if prevhspeed == 0.0:
				prevhspeed = hspeed
			hspeed = 0.0
	_user_3()
	_user_4()
	if gravity > 0.0:
		gravity = 0.1
		if vspeed > 3.2:
			vspeed = 3.2
	if cooldown > 0.0:
		cooldown -= 1.0


# from objects/obj_NSMBU_bowser/Step_2.gml
func _step_end() -> void:
	if state == 1.0:
		if multi_fire == 1.0:
			if sprite_index != A.spr_NSMBU_bowser_fire_up:
				sprite_index = A.spr_NSMBU_bowser_fire_up
				image_index = 0.0
			if image_index >= 26.0 and image_index < 26.5:
				alarm[4] = 1.0
			if image_index >= 33.0 and image_index < 33.5:
				alarm[4] = 1.0
			if image_index >= 41.0 and image_index < 41.5:
				alarm[4] = 1.0
			if image_index >= 48.0 and image_index < 48.5:
				alarm[4] = 1.0
			if image_index >= 52.0 and image_index < 52.5:
				alarm[4] = 1.0
			image_speed = 0.5
		elif jump == 1.0:
			if fire_jump == 1.0:
				if sprite_index != A.spr_NSMBU_bowser_fire_jump:
					sprite_index = A.spr_NSMBU_bowser_fire_jump
					image_index = 0.0
				if image_index >= 12.0 and image_index < 12.5:
					image_index = 13.0
					alarm[0] = 1.0
				else:
					image_speed = 0.5
			else:
				if sprite_index != A.spr_NSMBU_bowser_jump:
					sprite_index = A.spr_NSMBU_bowser_jump
					image_index = 0.0
				if image_index >= 20.0 and image_index < 20.5:
					image_index = 21.0
					alarm[0] = 1.0
				else:
					image_speed = 0.5
		elif turning == 1.0:
			if sprite_index != A.spr_NSMBU_bowser_turning:
				sprite_index = A.spr_NSMBU_bowser_turning
				image_index = 0.0
			if image_index >= 26.4:
				turning = 0.0
				sprite_index = A.spr_NSMBU_bowser_walk
				image_index = 1.0
				direct = (-direct)
				alarm[10] = 1.0
			else:
				image_speed = 0.6
		elif fire_anim == 1.0:
			if sprite_index != A.spr_NSMBU_bowser_fire:
				sprite_index = A.spr_NSMBU_bowser_fire
				image_index = 0.0
			if image_index >= 25.0 and image_index < 25.5:
				alarm[2] = 1.0
			image_speed = 0.5
		elif jump == 2.0:
			if sprite_index != A.spr_NSMBU_bowser_fall:
				sprite_index = A.spr_NSMBU_bowser_fall
				if fire_jump == 1.0:
					image_index = 14.0
					fire_jump = 0.0
				else:
					image_index = 0.0
			if image_index >= 30.5:
				image_index = 30.0
				jump = 0.0
			else:
				image_speed = 0.5
		else:
			if sprite_index != A.spr_NSMBU_bowser_walk:
				sprite_index = A.spr_NSMBU_bowser_walk
				image_index = 0.0
			if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > x:
				image_speed = 0.7
			elif direct == -1.0 and hspeed > 0.0:
				image_speed = -0.5
			else:
				image_speed = 0.5
			if not (Scr.outside_view(self) > 0.5):
				if (image_index >= 17.0 and image_index < 18.0) or (image_index >= -18.0 and image_index < -17.0):
					GM.audio_stop_sound(A.snd_NSMBU_bowser_paso1)
					GM.audio_play_sound(A.snd_NSMBU_bowser_paso1, 0.0, false)
				elif (image_index >= 0.0 and image_index < 1.0) or (image_index <= 0.0 and image_index > -1.0):
					GM.audio_stop_sound(A.snd_NSMBU_bowser_paso2)
					GM.audio_play_sound(A.snd_NSMBU_bowser_paso2, 0.0, false)
	elif state == 2.0:
		if turning == 1.0:
			turning = 0.0
		if fire_anim == 1.0:
			if sprite_index != A.spr_NSMBU_bowser_fire_jump:
				sprite_index = A.spr_NSMBU_bowser_fire_jump
				image_index = 0.0
			if image_index >= 15.0 and image_index < 15.5:
				alarm[2] = 1.0
			image_speed = 0.5
		elif fire_jump == 1.0:
			if image_index >= 34.0 and image_index < 34.5:
				alarm[2] = 1.0
			if image_index >= 43.0:
				image_speed = 0.0
				image_index = 43.0
			else:
				image_speed = 0.5
		elif vspeed > 0.0:
			sprite_index = A.spr_NSMBU_bowser_fall
			if image_index >= 12.5:
				image_speed = 0.0
				image_index = 12.0
			else:
				image_speed = 0.5
		else:
			sprite_index = A.spr_NSMBU_bowser_jump
			if image_index >= 51.5:
				image_speed = 0.0
				image_index = 51.0
			else:
				image_speed = 0.5


# from objects/obj_NSMBU_bowser/Alarm_0.gml
func _alarm_0() -> void:
	var mini
	var sonido_jump
	if vspeed == 0.0 and state == 1.0 and jump < 2.0 and fire_anim == 0.0 and multi_fire == 0.0:
		if sprite_index == A.spr_NSMBU_bowser_walk and image_index > 3.0:
			alarm[0] = 5.0
			return
		# ORIG-BUG: 原版顶部检测重复检查 obj_bullebill_base，照搬。
		if collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null:
			mini = 1.0
		else:
			mini = 0.0
		if jump == 0.0:
			jump = 1.0
			fire_jump = GM.choose(0.0, 0.0, 1.0, 0.0, 1.0)
		else:
			state = 2.0
			jump = 2.0
			sonido_jump = GM.choose(A.snd_NSMBU_bowser_jump1, A.snd_NSMBU_bowser_jump2)
			GM.audio_stop_sound(sonido_jump)
			GM.audio_play_sound(sonido_jump, 0.0, false)
			if fire_jump == 1.0:
				vspeed = (-(3.0 - (2.5 * mini)))
			else:
				if mini == 1.0:
					vspeed = -0.5
				else:
					vspeed = GM.choose(-3.5, -4.0, -3.5, -4.5)
				if big_jump == 0.0:
					big_jump = GM.choose(0.0, 1.0, 1.0, 0.0, 1.0)
				if GM.instance_exists(A.obj_mario) and (big_jump == 1.0 or (direct == 1.0 and place_meeting((x + 32.0), y, A.obj_solid)) or (direct == -1.0 and place_meeting((x - 32.0), y, A.obj_solid)) or (direct == 1.0 and GM.instance_find(A.obj_mario, 0).x > (x + 64.0)) or (direct == -1.0 and GM.instance_find(A.obj_mario, 0).x < (x - 64.0))):
					if GM.instance_find(A.obj_mario, 0).x < x:
						hspeed = ((absf((x / GM.instance_find(A.obj_mario, 0).x)) + 0.5) * direct)
					else:
						hspeed = ((absf((GM.instance_find(A.obj_mario, 0).x / x)) + 0.5) * direct)
			alarm[0] = GM.choose(120.0, 180.0, 90.0)
	else:
		alarm[0] = GM.choose(120.0, 60.0, 180.0)


# from objects/obj_NSMBU_bowser/Alarm_1.gml
func _alarm_1() -> void:
	if vspeed == 0.0 and jump == 0.0 and state == 1.0 and multi_fire == 0.0:
		if sprite_index == A.spr_NSMBU_bowser_walk and image_index > 3.0:
			alarm[1] = 2.0
			return
		fire_anim = 1.0
	else:
		alarm[1] = 1.0


# from objects/obj_NSMBU_bowser/Alarm_2.gml
func _alarm_2() -> void:
	GM.audio_stop_sound(A.snd_NSMBU_bowser_fire)
	GM.audio_play_sound(A.snd_NSMBU_bowser_fire, 0.0, false)
	if direct == 1.0:
		GM.instance_create((x + 24.0), (y - 10.0), A.obj_NSMBU_bowser_fire)
	else:
		GM.instance_create((x - 24.0), (y - 10.0), A.obj_NSMBU_bowser_fire)


# from objects/obj_NSMBU_bowser/Alarm_3.gml
func _alarm_3() -> void:
	var val
	if vspeed == 0.0 and state == 1.0 and jump == 0.0 and fire_anim == 0.0 and multi_fire == 0.0 and turning == 0.0:
		val = GM.choose(0.0, 1.0)
		if (sprite_index == A.spr_NSMBU_bowser_walk and image_index > 3.0) or val == 0.0:
			alarm[3] = 5.0
			return
		GM.audio_stop_sound(A.snd_NSMBU_bowser_multifire)
		GM.audio_play_sound(A.snd_NSMBU_bowser_multifire, 0.0, false)
		multi_fire = 1.0
	else:
		alarm[3] = 60.0


# from objects/obj_NSMBU_bowser/Alarm_4.gml
func _alarm_4() -> void:
	var fireball
	GM.audio_stop_sound(A.snd_NSMBU_bowser_fire)
	GM.audio_play_sound(A.snd_NSMBU_bowser_fire, 0.0, false)
	match multi_cont:
		0.0:
			if direct == 1.0:
				fireball = GM.instance_create((x + 19.0), (y - 7.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 350.0
					inst.motion_set(350.0, 0.6)
			else:
				fireball = GM.instance_create((x - 19.0), (y - 7.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 190.0
					inst.motion_set(190.0, 0.6)
		1.0:
			if direct == 1.0:
				fireball = GM.instance_create((x + 19.0), (y - 14.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 0.0
					inst.motion_set(0.0, 0.6)
			else:
				fireball = GM.instance_create((x - 19.0), (y - 14.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 180.0
					inst.motion_set(180.0, 0.6)
		2.0:
			if direct == 1.0:
				fireball = GM.instance_create((x + 17.0), (y - 20.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 20.0
					inst.motion_set(20.0, 0.6)
			else:
				fireball = GM.instance_create((x - 17.0), (y - 20.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 160.0
					inst.motion_set(160.0, 0.6)
		3.0:
			if direct == 1.0:
				fireball = GM.instance_create((x + 14.0), (y - 25.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 38.0
					inst.motion_set(38.0, 0.6)
			else:
				fireball = GM.instance_create((x - 14.0), (y - 25.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 142.0
					inst.motion_set(142.0, 0.6)
		4.0:
			if direct == 1.0:
				fireball = GM.instance_create((x + 17.0), (y - 27.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 43.0
					inst.motion_set(43.0, 0.6)
			else:
				fireball = GM.instance_create((x - 17.0), (y - 27.0), A.obj_NSMBU_bowser_fire_up)
				for inst in GM.with_list(fireball):
					inst.direction = 128.0
					inst.motion_set(128.0, 0.6)
	if multi_cont == 4.0:
		multi_cont = 0.0
	else:
		multi_cont += 1.0


# from objects/obj_NSMBU_bowser/Alarm_10.gml
func _alarm_10() -> void:
	hspeed = (0.3 * direct)
	alarm[0] = GM.choose(320.0, 280.0, 220.0)
	alarm[1] = GM.choose(180.0, 90.0, 120.0)
	alarm[3] = GM.choose(720.0, 660.0, 600.0, 540.0)
	alarm[11] = 20.0


# from objects/obj_NSMBU_bowser/Alarm_11.gml
func _alarm_11() -> void:
	if state == 1.0 and jump == 0.0:
		alarm[11] = 60.0
		if GM.instance_exists(A.obj_mario):
			if (GM.instance_find(A.obj_mario, 0).x < x and direct == 1.0) or (GM.instance_find(A.obj_mario, 0).x > x and direct == -1.0):
				turning = 1.0
				fire_anim = 0.0
				alarm[0] = -1.0
				alarm[1] = -1.0
				alarm[2] = -1.0
				alarm[3] = -1.0
				alarm[4] = -1.0
	else:
		alarm[11] = 10.0


# from objects/obj_NSMBU_bowser/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0):
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			vspeed = -0.5
		else:
			vspeed = -1.0


# from objects/obj_NSMBU_bowser/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_invincibility):
		return
	if G.yoshi > 0.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		if GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_find(A.obj_kuribo_drybones, 0).get("gran_golpe") == 1.0:
			GM.audio_play_sound(A.snd_NSMBU_kick, 0.0, false)
			var _other_1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _other_1
			for inst in GM.with_list(A.obj_kuribo_drybones):
				inst.gran_golpe = 0.0
			_user_0()
		else:
			_user_15()
			firehitpoints -= 1.0
			cooldown = 6.0
			if firehitpoints <= 0.0:
				_user_0()
			other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, (other.y + 16.0)))
			var _other_2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _other_2
	else:
		other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, (other.y + 16.0)))
		if (other.y + 16.0) < (y - 12.0):
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
				other.vspeed = -2.125
			else:
				other.vspeed = -5.0
		var _other_3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)


		GM.other = _other_3
# from objects/obj_NSMBU_bowser/Other_7.gml
func _animation_end() -> void:
	match sprite_index:
		A.spr_NSMBU_bowser_fire:
			fire_anim = 0.0
			alarm[1] = GM.choose(180.0, 90.0, 120.0)
		A.spr_NSMBU_bowser_fire_up:
			multi_fire = 0.0
			alarm[3] = GM.choose(600.0, 720.0, 600.0, 480.0)


# from objects/obj_NSMBU_bowser/Other_10.gml
func _user_0() -> void:
	if key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	GM.audio_stop_sound(A.snd_NSMBU_bowser_dead)
	GM.audio_play_sound(A.snd_NSMBU_bowser_dead, 0.0, false)
	imdead = GM.instance_create(x, y, A.obj_bowser_dead)
	imdead.direct = direct
	imdead.vspeed = -3.5
	if direct == 1.0:
		imdead.hspeed = -1.0
	else:
		imdead.hspeed = 1.0
	instance_destroy()


# from objects/obj_NSMBU_bowser/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _other_4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_4
		if hspeed < 0.0 and col_one_right != null:
			var _other_5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_5
		if (direct == 1.0 and hspeed > 0.0) or (direct == -1.0 and hspeed < 0.0) or state == 3.0 or state == 4.0:
			hspeed = 0.0
		else:
			hspeed = (-hspeed)
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
		if (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
				x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0


# from objects/obj_NSMBU_bowser/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				if not GM.audio_is_playing(A.snd_oneway):
					GM.audio_play_sound(A.snd_oneway, 0.0, false)
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
			state = 1.0
			if jump == 2.0:
				GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
				GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
			if big_jump == 1.0:
				big_jump = 0.0
	else:
		state = 2.0
		if paracaidas == 1.0:
			gravity = 0.1
			if vspeed > 0.4:
				vspeed = 0.4
		elif not (swimming > 0.5):
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
		elif swimming == 1.0:
			gravity = 0.1
			if vspeed > 0.4:
				vspeed = 0.4
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _other_6: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_6
			vspeed = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)):
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		GM.audio_stop_sound(A.snd_NSMBU_bowser_dead)
		GM.audio_play_sound(A.snd_NSMBU_bowser_dead, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_bowser_dead)):
			inst.direct = self.direct
		instance_destroy()
	elif (bbox_top - 16.0) > GM.room_height and G.bg_level != "castle" and G.bg_level != "forest" and G.bg_level != "beach":
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		GM.audio_stop_sound(A.snd_NSMBU_bowser_dead)
		GM.audio_play_sound(A.snd_NSMBU_bowser_dead, 0.0, false)
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.dead_bowser = 1.0
				inst.alarm[11] = 90.0
		instance_destroy()
	_user_14()


# from objects/obj_NSMBU_bowser/Draw_0.gml
func _gm_draw() -> void:
	if cooldown > 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.make_colour_rgb(255.0, 60.0, 109.0), (cooldown / 4.0))
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
