# from objects/obj_pokey（第 6e 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var wings_anim: float = 0.0
var mebelow = null
var a: float = 0.0
var offset: float = 0.0
var offsetnext: float = 0.0
var offsetxscale: float = 1.0
var rotacion: float = 0.0
var up: float = 0.0
var col_pokey = null


# from objects/obj_pokey/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			if G.bg_level == "snow":
				sprite_index = A.spr_SMB_pokey_snow
			else:
				sprite_index = A.spr_SMB_pokey
		1.0:
			if G.bg_level == "snow":
				sprite_index = A.spr_SMB3_pokey_snow
			else:
				sprite_index = A.spr_SMB3_pokey
		2.0:
			if G.bg_level == "snow":
				sprite_index = A.spr_pokey_snow
			else:
				sprite_index = A.spr_pokey
		3.0:
			if G.bg_level == "snow":
				sprite_index = A.spr_NSMBU_pokey_snow
			else:
				sprite_index = A.spr_NSMBU_pokey
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	innave = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	apilar = 0.0
	swimming = 0.0
	image_speed = 0.0
	alarm[10] = 2.0
	if position_meeting(x, (bbox_bottom + 8.0), A.obj_pokey):
		mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_pokey, false, false)
		alarm[0] = 10.0
	else:
		mebelow = null
		alarm[10] = 2.0
	a = -16.0
	alarm[9] = 2.0
	offset = 0.0
	offsetnext = 0.0
	offsetxscale = 1.0
	rotacion = 0.0
	up = 0.0


# from objects/obj_pokey/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0 and image_index == 0.0:
		if G.bg_level == "snow":
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_snow_ball)):
				inst.vspeed = -2.0
		if GM.instance_exists(mebelow):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(mebelow):
				inst.event_user(7)
			GM.other = _o


# from objects/obj_pokey/Step_1.gml
func _step_begin() -> void:
	var next
	if not GM.instance_exists(mebelow):
		next = mebelow
		while next != null:
			GM.instance_activate_object(next)
			if GM.instance_exists(next):
				next = next.mebelow
			else:
				next = null


# from objects/obj_pokey/Step_0.gml
func _step() -> void:
	if mebelow == null:
		col_pokey = collision_point(x, (bbox_bottom + 8.0), A.obj_pokey, false, false)
		if position_meeting(x, (bbox_bottom + 8.0), A.obj_pokey) and col_pokey != null and col_pokey.image_index == 1.0:
			mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_pokey, false, false)
			vspeed = 0.0
			gravity = 0.0
			alarm[0] = 10.0
		else:
			super._step()
			_user_6()
			if hspeed > 0.0:
				direct = 1.0
			else:
				direct = -1.0
			offset = 0.0
			offsetnext = 0.0
			alarm[0] = -1.0
	else:
		GM.instance_activate_object(mebelow)
		if GM.instance_exists(mebelow):
			x = mebelow.x
			y = (mebelow.y - 16.0)
			direct = mebelow.direct
		else:
			mebelow = null
	if GM.instance_exists(A.obj_mario):
		if up == 0.0:
			if rotacion > -6.0:
				rotacion -= 0.6
			else:
				up = 1.0
		if up == 1.0:
			if rotacion < 6.0:
				rotacion += 0.6
			else:
				up = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
		y = (GM.instance_find(A.obj_lava_water, 0).y - 20.0)
	if modo_lava == 1.0:
		hspeed = 0.0
		gravity = 0.02
		if vspeed > 0.03:
			vspeed = 0.03


# from objects/obj_pokey/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(mebelow) and GM.instance_exists(A.obj_mario):
		offsetxscale = (-mebelow.offsetxscale)
	match offsetnext:
		0.0:
			offset = offsetxscale
		1.0:
			offset = 0.0
		2.0:
			offset = (-offsetxscale)
		3.0:
			offset = 0.0
	offsetnext += 1.0
	if offsetnext == 4.0:
		offsetnext = 0.0
	alarm[0] = 12.0


# from objects/obj_pokey/Alarm_9.gml
func _alarm_9() -> void:
	if mebelow == null:
		for _rep in range(99):
			if position_meeting(x, (bbox_top + a), A.obj_pokey):
				a -= 16.0
			else:
				a += 16.0
				if a < -16.0:
					a = -16.0
	alarm[9] = 2.0


# from objects/obj_pokey/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		hspeed = -0.2


# from objects/obj_pokey/Alarm_11.gml
func _alarm_11() -> void:
	if hspeed != 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -0.2
		else:
			hspeed = 0.2
	alarm[11] = 60.0


# from objects/obj_pokey/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	if dead_h == 0.0:
		imdead.hspeed = GM.random_range(-1.0, 1.0)
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_pokey/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_pokey/Other_13.gml
func _user_3() -> void:
	var pow_left
	var pow_right
	var pswitch_left
	var pswitch_right
	var col_one_left
	var col_one_right
	if mebelow == null:
		pow_left = collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_block_pow_hold, false, false)
		pow_right = collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_block_pow_hold, false, false)
		pswitch_left = collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_pswitch, false, false)
		pswitch_right = collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_pswitch, false, false)
		if (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_solid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_solid, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_muncher, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_muncher, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_pinchos, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_pinchos, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_cannon, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_cannon, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_bullebill_base, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_bullebill_base, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_onewaygate_right, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_onewaygate_left, true, false) != null) or (hspeed < 0.0 and pow_left != null and pow_left.held == 0.0) or (hspeed > 0.0 and pow_right != null and pow_right.held == 0.0) or (hspeed < 0.0 and pswitch_left != null and pswitch_left.held == 0.0) or (hspeed > 0.0 and pswitch_right != null and pswitch_right.held == 0.0):
			col_one_left = collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_onewaygate_left, false, false)
			col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_onewaygate_right, false, false)
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
			hspeed = (-hspeed)
			direct = (-direct)
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 8.0), A.obj_solid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 8.0), A.obj_solid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 8.0), A.obj_muncher, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 8.0), A.obj_muncher, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 8.0), A.obj_pinchos, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 8.0), A.obj_pinchos, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 8.0), A.obj_cannon, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 8.0), A.obj_cannon, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 8.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 8.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0


# from objects/obj_pokey/Other_17.gml
func _user_7() -> void:
	if image_index == 1.0:
		if GM.instance_exists(mebelow):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(mebelow):
				inst.event_user(7)
			GM.other = _o
		_user_0()


# from objects/obj_pokey/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, (GM.gm_round(x) + offset), GM.gm_round(y), direct, 1.0, rotacion, GM.c_white, 1.0)
