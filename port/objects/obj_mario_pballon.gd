# 第 4 批移植，已核对。
extends GMObject

var angle: float = 0.0
var inf: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var time: float = 0.0
var moving: float = 0.0
var mov: float = 0.0
var max_speed: float = 0.0
var xx: float = 0.0
var xDiff_h: float = 0.0
var yDiff_h: float = 0.0
var fallow = null


# from objects/obj_mario_pballon/Create_0.gml
func _create() -> void:
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
	match G.jugador:
		0.0:
			sprite_index = A.spr_mario_pballon
		1.0:
			sprite_index = A.spr_luigi_pballon
		2.0:
			sprite_index = A.spr_toad_pballon
		3.0:
			sprite_index = A.spr_toadette_pballon
	image_speed = 0.0
	image_index = 0.0
	friction = 0.01
	direction = 90.0
	image_angle = 90.0
	angle = 90.0
	inf = 0.0
	ready_v = 0.0
	time = 10.0
	moving = 0.0
	mov = 0.0
	max_speed = 1.0
	xx = 0.0
	xDiff_h = 0.0
	yDiff_h = 0.0
	fallow = null  # 原版 -4（noone）


# from objects/obj_mario_pballon/Destroy_0.gml
func _destroy() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	GM.audio_stop_sound(A.snd_pballon_c)
	ready_v = 0.0
	if GM.instance_exists(A.obj_mario):
		if G.powerup != 0.0 and (collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top - 16.0), i_mario.bbox_right, i_mario.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top - 16.0), i_mario.bbox_right, i_mario.bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top - 16.0), i_mario.bbox_right, i_mario.bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top - 16.0), i_mario.bbox_right, i_mario.bbox_top, A.obj_bullebill_base, true, false) != null):
			for inst in GM.with_list(A.obj_mario):
				if inst.holding == 2.0 and G.apariencia == 2.0:
					inst.isduck = 1.0
					inst.isduckhold = 1.0
				else:
					inst.isduck = 1.0


# from objects/obj_mario_pballon/Step_0.gml
func _step() -> void:
	# GML 里 left/right/up/down 取 keyboard_check 的 0/1 或字面量 1/-1；条件只看 > 0.5，故 1 → true，-1/0 → false
	var left: bool = false
	var right: bool = false
	var up: bool = false
	var down: bool = false
	var diff: float
	var i_goalgate = GM.instance_find(A.obj_goalgate_front, 0)
	if GM.instance_exists(A.obj_mario) and (collision_rectangle((bbox_left - 2.0), (bbox_top - 1.0), (bbox_right + 1.0), (bbox_bottom + 1.0), A.obj_muncher, false, false) != null or collision_rectangle((bbox_left - 2.0), (bbox_top - 1.0), (bbox_right + 1.0), (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(0)
		GM.other = _o
	if GM.instance_exists(A.obj_mario) and G.powerup == -82.0:
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
		for inst in GM.with_list(A.obj_mario):
			inst.x = x
		for inst in GM.with_list(A.obj_mario):
			inst.y = (y - 24.0)
		for inst in GM.with_list(A.obj_mario):
			inst.speed = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.state = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.disablecontrols = 1.0
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
	elif GM.instance_exists(A.obj_player_goal_parent):
		for inst in GM.with_list(A.obj_player_goal_parent):
			inst.visible = false
		for inst in GM.with_list(A.obj_player_goal_parent):
			inst.x = (x + 3.0)
		for inst in GM.with_list(A.obj_player_goal_parent):
			inst.y = (y - 16.0)
		for inst in GM.with_list(A.obj_player_goal_parent):
			inst.speed = 0.0
		ready_v = 0.0
	elif not GM.instance_exists(A.obj_mario_transform2):
		instance_destroy()
	if GM.instance_exists(A.obj_helmet):
		xDiff_h = GM.lengthdir_x(8.0, direction)
		yDiff_h = GM.lengthdir_y(8.0, direction)
		for inst in GM.with_list(A.obj_helmet):
			inst.x = (x + xDiff_h)
		for inst in GM.with_list(A.obj_helmet):
			inst.y = (y + yDiff_h)
	_user_0()
	_user_1()
	_user_3()
	_user_4()
	if ready_v == 2.0 and speed != 0.0:
		if not GM.audio_is_playing(A.snd_pballon_c):
			GM.audio_play_sound(A.snd_pballon_c, 1.0, true)
	else:
		GM.audio_stop_sound(A.snd_pballon_c)
	if GM.instance_exists(A.obj_mario):
		if GM.keyboard_check(G.saltar) or GM.keyboard_check(G.lanzar_agarrar):
			ready_v = 2.0
		else:
			ready_v = 0.0
		left = GM.keyboard_check(G.izquierda)
		right = GM.keyboard_check(G.derecha)
		up = GM.keyboard_check(G.arriba)
		down = GM.keyboard_check(G.abajo)
	elif GM.instance_exists(A.obj_player_goal_parent):
		left = false
		down = false
		if mov == 1.0:
			if G.bg_level == "castle":
				right = true
				up = false
			elif x >= ((i_goalgate.x - 8.0) + 71.0):
				right = false
				up = false
				mov = 2.0
			else:
				right = true
				up = false
		elif mov == 2.0:
			right = false
			if direction == 90.0:
				up = false
			else:
				up = true
		else:
			right = false
			left = false
			down = false
			up = false
	else:
		right = false
		left = false
		down = false
		up = false
	if left:
		moving = 1.0
		if up:
			angle = 135.0
		elif down:
			angle = 225.0
		else:
			angle = 180.0
	elif right:
		moving = 1.0
		if up:
			angle = 45.0
		elif down:
			angle = 315.0
		else:
			angle = 0.0
	elif down:
		moving = 1.0
		if left:
			angle = 225.0
		elif right:
			angle = 315.0
		else:
			angle = 270.0
	elif up:
		moving = 1.0
		if left:
			angle = 135.0
		elif right:
			angle = 45.0
		else:
			angle = 90.0
	else:
		moving = 0.0
	if moving == 1.0:
		speed += 0.03
		diff = GM.angle_difference(direction, angle)
		direction -= (minf((1.0 * GM.gm_sign(diff)), absf(diff)) * 5.0)
		image_angle = direction
	if ready_v == 2.0:
		max_speed = 2.0
	else:
		max_speed = 0.6
	if speed > max_speed:
		speed = max_speed
	if absf(speed) < 1.0:
		xx = 1.0
	else:
		xx = absf(speed)
	# Slope Collision


# from objects/obj_mario_pballon/Step_2.gml
func _step_end() -> void:
	match G.jugador:
		0.0:
			sprite_index = A.spr_mario_pballon
		1.0:
			sprite_index = A.spr_luigi_pballon
		2.0:
			sprite_index = A.spr_toad_pballon
		3.0:
			sprite_index = A.spr_toadette_pballon
	if GM.instance_exists(A.obj_mario):
		if speed == 0.0:
			if GM.keyboard_check(G.derecha) or GM.keyboard_check(G.izquierda):
				image_speed = 0.1
			else:
				image_speed = 0.0
				image_index = 0.0
		elif ready_v == 2.0:
			image_speed = 0.0
			image_index = 2.0
		else:
			image_speed = 0.15
	elif GM.instance_exists(A.obj_player_goal_parent):
		if speed == 0.0:
			image_speed = 0.0
			image_index = 0.0
		else:
			image_speed = 0.15
	if hspeed < 0.0 and (collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		x += xx
	# ORIG-BUG?: 向右运动的判定里第四项是 obj_onewaygate_right（Other_13 里向右用 obj_onewaygate_left），照搬
	if hspeed > 0.0 and (collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		x -= xx
	if vspeed < 0.0 and (collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null):
		y += xx
	if vspeed > 0.0 and (collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, true, false) != null):
		y -= xx


# from objects/obj_mario_pballon/Other_10.gml
func _user_0() -> void:
	if ready_v == 2.0 and speed != 0.0:
		if inf == 0.0:
			image_yscale -= 0.05
			if image_yscale < 0.9:
				inf = 1.0
		else:
			image_yscale += 0.05
			if image_yscale > 1.0:
				inf = 0.0
		image_xscale = 1.0
	else:
		if inf == 0.0:
			image_xscale -= 0.01
			if image_xscale < 0.9:
				inf = 1.0
		else:
			image_xscale += 0.01
			if image_xscale > 1.0:
				inf = 0.0
		image_yscale = 1.0


# from objects/obj_mario_pballon/Other_11.gml
func _user_1() -> void:
	var xDiff: float
	var yDiff: float
	if ready_v == 2.0 and speed != 0.0:
		time -= 1.0
		if time <= 0.0:
			xDiff = GM.lengthdir_x(12.0, (direction - 180.0))
			yDiff = GM.lengthdir_y(12.0, (direction - 180.0))
			for inst in GM.with_list(GM.instance_create((x + xDiff), (y + yDiff), A.obj_smoke)):
				inst.sprite_index = A.spr_smoke_pballoon
				inst.image_angle = self.direction
				inst.image_speed = 0.1
			time = 10.0


# from objects/obj_mario_pballon/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	var block_right
	var block_left
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if speed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if speed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
		block_right = collision_rectangle((bbox_left - 2.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		if hspeed < -1.0 and block_right != null and block_right.ready_v == 0.0:
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(block_right):
				inst.event_user(2)
			GM.other = _o3
		elif speed > 1.0 and block_left != null and block_left.ready_v == 0.0:
			var _o4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(block_left):
				inst.event_user(2)
			GM.other = _o4
		speed = (-speed)
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_mario_pballon/Other_14.gml
func _user_4() -> void:
	var col_one_top
	var block
	var col_one_bottom
	if collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and ((collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null) or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null) and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null):
		if vspeed > 0.0:
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			block = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_blockparent, false, false)
			if speed > 1.0 and block != null and block.ready_v == 0.0:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block):
					inst.event_user(3)
				GM.other = _o2
			if vspeed > 0.1:
				speed = (-speed)
			else:
				speed = 0.0
		while collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidtop, false, false) != null and (not place_meeting(x, y, A.obj_solidtop)):
			y -= 1.0
		while collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
			y -= 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_hurtsolid2, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_bullebill_base, true, false) != null and (not place_meeting(x, y, A.obj_bullebill_base)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o3
			block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 2.0), A.obj_blockparent, false, false)
			if vspeed < -1.0 and block != null and block.ready_v == 0.0:
				var _o4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block):
					inst.event_user(2)
				GM.other = _o4
			if vspeed < -0.1:
				speed = (-speed)
			else:
				speed = 0.0


# from objects/obj_mario_pballon/Other_16.gml
func _user_6() -> void:
	if GM.instance_exists(A.obj_player_goal_smw_castle):
		fallow = 210.0
	elif GM.instance_exists(A.obj_player_goal_smw):
		fallow = 209.0


# from objects/obj_mario_pballon/Draw_0.gml
func _gm_draw() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_invinc = GM.instance_find(A.obj_invincibility, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_parent, 0)
	if GM.instance_exists(A.obj_mario):
		GM.draw_sprite_ext(sprite_index, image_index, Scr.screen_round(self, x), Scr.screen_round(self, y), image_xscale, image_yscale, image_angle, GM.c_white, i_mario.image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, Scr.screen_round(self, x), Scr.screen_round(self, y), image_xscale, image_yscale, image_angle, GM.c_white, 1.0)
	if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
		GM.shader_set(A.sha_blendreplace)
		if GM.instance_exists(A.obj_mario):
			GM.draw_sprite_ext(sprite_index, image_index, Scr.screen_round(self, x), Scr.screen_round(self, y), image_xscale, image_yscale, image_angle, i_mario.blend_star, i_invinc.flashAlpha)
		elif GM.instance_exists(A.obj_player_goal_parent):
			GM.draw_sprite_ext(sprite_index, image_index, Scr.screen_round(self, x), Scr.screen_round(self, y), image_xscale, image_yscale, image_angle, i_goal.blend_star, i_goal.flashAlpha)
		GM.shader_reset()
