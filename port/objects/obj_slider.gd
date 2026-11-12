# 第 4 批移植，已核对。
extends GMObject

var type: float = 0.0
var direct = null
var hitpoint: float = 0.0
var disablecontrols = null
var add: float = 0.0


# from objects/obj_slider/Create_0.gml
func _create() -> void:
	type = 0.0
	for inst in GM.with_list(A.obj_mario):
		inst.invincible = 1.0
		inst.disablecontrols = 1.0
		inst.skidnow = 2.0
	var i_mario = GM.instance_find(A.obj_mario, 0)
	hspeed = i_mario.hspeed
	direct = i_mario.direct
	GM.audio_stop_sound(A.snd_skid)
	hitpoint = 0.0
	sprite_index = Scr.scr_marioslide(self)
	alarm[0] = 8.0
	disablecontrols = i_mario.disablecontrols
	add = 1.0


# from objects/obj_slider/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_mario):
		inst.invincible = 0.0
		inst.disablecontrols = 0.0
		inst.skidnow = 0.0


# from objects/obj_slider/Step_0.gml
func _step() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario) and GM.keyboard_check(G.abajo):
		for inst in GM.with_list(A.obj_mario):
			inst.hspeed = hspeed
		for inst in GM.with_list(A.obj_mario):
			inst.direct = direct
		for inst in GM.with_list(A.obj_mario):
			inst.x = x
		y = i_mario.y
		for inst in GM.with_list(A.obj_mario):
			inst.invincible = 1.0
	else:
		instance_destroy()
		return
	if type == 0.0:
		sprite_index = Scr.scr_marioslide(self)
		if G.powerup == 0.0:
			mask_index = A.spr_smallmask
		elif G.powerup == -85.0:
			mask_index = A.spr_smallmask
		else:
			mask_index = A.spr_bigmask
	else:
		if GM.keyboard_check_pressed(G.saltar) and i_mario.state < 2.0:
			GM.audio_play_sound(A.snd_jump, 0.0, false)
			for inst in GM.with_list(A.obj_mario):
				inst.vspeed = -3.0
				inst.state = 2.0
		if type == 2.0:
			if hspeed > 0.0:
				direct = 1.0
			else:
				direct = -1.0
	if collision_rectangle(bbox_right, bbox_bottom - 2.0, bbox_right, (bbox_bottom + 2.0), A.obj_slopeparent, true, false) != null:
		hspeed -= 0.1
	if collision_rectangle(bbox_left, bbox_bottom - 2.0, bbox_left, (bbox_bottom + 2.0), A.obj_slopeparent, true, false) != null:
		hspeed += 0.1
	if hspeed > 3.0:
		hspeed = 3.0
	if hspeed < -3.0:
		hspeed = -3.0
	if i_mario.state < 2.0 and (collision_rectangle(bbox_right, bbox_bottom, bbox_right, (bbox_bottom + 2.0), A.obj_slopeparent, true, false) == null) and (collision_rectangle(bbox_left, bbox_bottom, bbox_left, (bbox_bottom + 2.0), A.obj_slopeparent, true, false) == null):
		if type == 0.0:
			friction = 0.1
		else:
			friction = 0.02
		if absf(hspeed) < 0.05:
			instance_destroy()
	else:
		friction = 0.0
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null):
		if type == 1.0:
			GM.audio_play_sound(A.snd_bump, 0.0, false)
			GM.instance_create((x - 8.0), (y + 16.0), A.obj_blockbumper)
			for inst in GM.with_list(GM.instance_create((x + (8.0 * GM.gm_sign(hspeed))), (y + 24.0), A.obj_smoke)):
				inst.sprite_index = A.spr_shellbump
			hspeed = (-hspeed)
		else:
			instance_destroy()
	if GM.keyboard_check_pressed(G.saltar) and (i_mario.jumpnow == 0.0):
		GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
		for inst in GM.with_list(A.obj_mario):
			inst.state = 2.0
			inst.jumpnow = 1.0
			if inst.isswim == 1.0:
				inst.vspeed = -1.8
			else:
				inst.vspeed = -3.75
	if collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1.0, A.obj_solidtop, false, false) != null:
		# If the player is not on contact with a slippery surface.
		if i_mario.isslip == 0.0:
			# Slowdown
			hspeed = maxf(0.0, absf(hspeed) - 0.05) * GM.gm_sign(hspeed)
			if (hspeed > -0.05) and (hspeed < 0.05):
				# Stop horizontal speed.
				hspeed = 0.0
				# End combo
				for inst in GM.with_list(A.obj_mario):
					inst.hitpoint = 0.0
		elif i_mario.isslip == 1.0:
			# Slowdown
			hspeed = maxf(0.0, absf(hspeed) - 0.0125) * GM.gm_sign(hspeed)
			if (hspeed > -0.0125) and (hspeed < 0.0125):
				# Stop horizontal speed.
				hspeed = 0.0
				# End combo
				for inst in GM.with_list(A.obj_mario):
					inst.hitpoint = 0.0


# from objects/obj_slider/Alarm_0.gml
func _alarm_0() -> void:
	if collision_rectangle((bbox_left - 3.0), bbox_bottom, bbox_left, (bbox_bottom + 2.0), A.obj_slopeparent, true, false) != null:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y + 24.0), A.obj_smoke)):
			inst.sprite_index = A.spr_skidsmoke
			inst.depth = -6.0
	if collision_rectangle(bbox_right, bbox_bottom, (bbox_right + 3.0), (bbox_bottom + 2.0), A.obj_slopeparent, true, false) != null:
		for inst in GM.with_list(GM.instance_create((x + 1.0), (y + 24.0), A.obj_smoke)):
			inst.sprite_index = A.spr_skidsmoke
			inst.depth = -6.0
	alarm[0] = 8.0


# from objects/obj_slider/Alarm_1.gml
func _alarm_1() -> void:
	image_speed = 0.0
	image_index = 2.0


# from objects/obj_slider/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0:
		Scr.scr_musicalscale(self, self, other, 1.0)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_slider/Other_10.gml
func _user_0() -> void:
	image_speed = 0.3
	for inst in GM.with_list(A.obj_mario):
		inst.isduck = 1.0
	alarm[1] = 6.0


# from objects/obj_slider/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.sprite_index = sprite_index
		for inst in GM.with_list(A.obj_mario):
			inst.image_index = image_index
