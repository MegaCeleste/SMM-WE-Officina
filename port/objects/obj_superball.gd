# from objects/obj_superball（第 5 批移植，已核对）
extends GMObject


# from objects/obj_superball/Create_0.gml
func _create() -> void:
	GM.audio_play_sound(A.snd_fireball, 0.0, false)
	image_speed = 0.0
	image_index = 0.0
	vspeed = 2.0
	alarm[1] = 2.0
	alarm[0] = 200.0
	if place_meeting(x, y, A.obj_solid):
		_user_0()


# from objects/obj_superball/Step_0.gml
func _step() -> void:
	var col_one_left
	var col_one_right
	var col_b_switch
	var col_b_switch2
	var col_a_switch
	var col_a_switch2
	var col_pow
	var col_one_down
	var col_one_up
	if (hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_muncher, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_muncher, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_pinchos, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_pinchos, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_cannon, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_cannon, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			if not GM.audio_is_playing(A.snd_oneway):
				GM.audio_play_sound(A.snd_oneway, 0.0, false)
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
		if hspeed < 0.0 and col_one_right != null:
			if not GM.audio_is_playing(A.snd_oneway):
				GM.audio_play_sound(A.snd_oneway, 0.0, false)
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
		col_b_switch = collision_rectangle((bbox_right + hspeed), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_onoffblock, false, false)
		col_b_switch2 = collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left + hspeed), bbox_bottom, A.obj_onoffblock, false, false)
		if hspeed > 0.0 and col_b_switch != null and col_b_switch.ready_v == 0.0:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_b_switch):
				inst.event_user(1)
			GM.other = _o
			_user_0()
		elif hspeed < 0.0 and col_b_switch2 != null and col_b_switch2.ready_v == 0.0:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_b_switch2):
				inst.event_user(1)
			GM.other = _o2
			_user_0()
		else:
			hspeed = (-hspeed)
	if (vspeed > 0.0 and collision_rectangle(bbox_left, (bbox_bottom + vspeed), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false) != null) or (vspeed < 0.0 and collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_solid, false, false) != null) or (vspeed > 0.0 and collision_rectangle(bbox_left, (bbox_bottom + vspeed), bbox_right, (bbox_bottom + vspeed), A.obj_pinchos, false, false) != null) or (vspeed < 0.0 and collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_pinchos, false, false) != null) or (vspeed > 0.0 and collision_rectangle(bbox_left, (bbox_bottom + vspeed), bbox_right, (bbox_bottom + vspeed), A.obj_muncher, false, false) != null) or (vspeed < 0.0 and collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_muncher, false, false) != null) or (vspeed > 0.0 and collision_rectangle(bbox_left, (bbox_bottom + vspeed), bbox_right, (bbox_bottom + vspeed), A.obj_cannon, false, false) != null) or (vspeed < 0.0 and collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_cannon, false, false) != null) or (vspeed < 0.0 and collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_onewaygate_bottom, false, false) != null):
		col_a_switch = collision_rectangle(bbox_left, (bbox_bottom + vspeed), bbox_right, (bbox_bottom + vspeed), A.obj_onoffblock, false, false)
		col_a_switch2 = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_onoffblock, false, false)
		col_pow = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top + vspeed), A.obj_block_pow_hold, false, false)
		col_one_down = collision_rectangle(bbox_left, (bbox_bottom + vspeed), bbox_right, (bbox_bottom + vspeed), A.obj_onewaygate_bottom, false, false)
		col_one_up = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_top, false, false)
		if vspeed > 0.0 and col_one_up != null:
			if not GM.audio_is_playing(A.snd_oneway):
				GM.audio_play_sound(A.snd_oneway, 0.0, false)
			for inst in GM.with_list(col_one_up):
				inst.rot = 1.0
		if hspeed < 0.0 and col_one_down != null:
			if not GM.audio_is_playing(A.snd_oneway):
				GM.audio_play_sound(A.snd_oneway, 0.0, false)
			for inst in GM.with_list(col_one_down):
				inst.rot = 1.0
		if vspeed > 0.0 and col_pow != null and col_pow.held == 0.0:
			col_pow.explode = 1.0
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_pow):
				inst.event_user(6)
			GM.other = _o3
			_user_0()
		elif vspeed > 0.0 and col_a_switch != null and col_a_switch.ready_v == 0.0:
			var _o4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_a_switch):
				inst.event_user(1)
			GM.other = _o4
			_user_0()
		elif vspeed < 0.0 and col_a_switch2 != null and col_a_switch2.ready_v == 0.0:
			var _o5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_a_switch2):
				inst.event_user(1)
			GM.other = _o5
			_user_0()
		else:
			vspeed = (-vspeed)
	if vspeed > 0.0 and place_meeting((x + hspeed), (y + vspeed), A.obj_slopeparent):
		hspeed = (-hspeed)
		vspeed = (-vspeed)
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
		if hspeed > 1.0:
			hspeed -= 0.08
			if hspeed <= 1.0:
				hspeed = 1.0
		elif hspeed < -1.0:
			hspeed += 0.08
			if hspeed >= -1.0:
				hspeed = -1.0
	elif hspeed > 2.0:
		hspeed -= 0.05
		if hspeed <= 2.0:
			hspeed = 2.0
	elif hspeed < -2.0:
		hspeed += 0.05
		if hspeed >= -2.0:
			hspeed = -2.0
	if vspeed > 0.0 and place_meeting(x + hspeed, y + vspeed, A.obj_slopeparent):
		hspeed = -hspeed
		vspeed = -vspeed
	if Scr.outside_view(self) > 0.5:
		instance_destroy()


# from objects/obj_superball/Alarm_0.gml
func _alarm_0() -> void:
	GM.instance_create((x + 2.0), (y - 6.0), A.obj_smoke)
	instance_destroy()


# from objects/obj_superball/Alarm_1.gml
func _alarm_1() -> void:
	GM.instance_create(x, y, A.obj_superball_trail)
	alarm[1] = 2.0


# from objects/obj_superball/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	var _o6: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.explode = 1.0
		inst.event_user(6)
	GM.other = _o6
	_user_0()


# from objects/obj_superball/Collision_obj_bobomb.gml
func _collision_obj_bobomb(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o7: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(1)
	GM.other = _o7
	_user_0()


# from objects/obj_superball/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.object_index != A.obj_grinder and other.visible == true:
		if other.hardness == 0.0 and other.object_index != A.obj_buzzybeetle and other.object_index != A.obj_bobomb and other.object_index != A.obj_chain_chomp_free:
			GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
			var _o8: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
				inst.event_user(0)
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o8
		if (other.hardness < 100.0 and other.object_index != A.obj_bobomb) or other.object_index == A.obj_buzzybeetle or other.object_index == A.obj_chain_chomp_free:
			_user_0()


# from objects/obj_superball/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if other.object_index == A.obj_bobomb_hold:
		GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
		if (bbox_left + (other.bbox_right / 2.0)) < (other.bbox_left + (other.bbox_right / 2.0)):
			other.hspeed = 1.2
			other.direct = 1.0
		elif (bbox_left + (other.bbox_right / 2.0)) > (other.bbox_left + (other.bbox_right / 2.0)):
			other.hspeed = -1.2
			other.direct = -1.0
		else:
			hspeed = 1.2
			other.direct = 1.0
		other.vspeed = -2.0
		_user_0()
	elif other.hardness < 99.0:
		GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
		var _o9: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o9
		_user_0()
	else:
		_user_0()


# from objects/obj_superball/Other_10.gml
func _user_0() -> void:
	GM.audio_play_sound(A.snd_bump, 0.0, false)
	GM.instance_create((x - 12.0), (y - 12.0), A.obj_smoke)
	instance_destroy()
