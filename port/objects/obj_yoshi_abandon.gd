# 第 4 批移植，已核对。
extends "res://objects/obj_physicsparent.gd"

var awake: float = 0.0
var colour: float = 0.0
var color: float = 0.0
var mouthholder = null  # object 编号（int）；noone 用 null（同 obj_yoshi2）
var mouthsprite = null  # sprite 编号（int）；noone 用 null
var modo_lava: float = 0.0
var wings: float = 0.0
var imdead = null


# from objects/obj_yoshi_abandon/Create_0.gml
func _create() -> void:
	if G.apariencia != 2.0:
		instance_destroy()
		return
	awake = 0.0
	colour = 0.0
	color = 0.0
	image_speed = 0.0
	mouthholder = null
	mouthsprite = null
	direct = 1.0
	swimming = 0.0
	modo_lava = 0.0
	wings = 0.0
	if G.apariencia != 3.0:
		alarm[0] = 60.0
		alarm[1] = 76.0
		alarm[2] = 2.0


# from objects/obj_yoshi_abandon/Step_0.gml
func _step() -> void:
	super._step()
	if modo_lava == 0.0:
		if mouthholder != null:
			if color == 0.0:
				sprite_index = A.spr_yoshi_fm_wait
			elif color == 1.0:
				sprite_index = A.spr_yoshi_fm_wait_red
			elif color == 2.0:
				sprite_index = A.spr_yoshi_fm_wait_blue
		elif color == 0.0:
			sprite_index = A.spr_yoshi_wait
		elif color == 1.0:
			sprite_index = A.spr_yoshi_wait_red
		elif color == 2.0:
			sprite_index = A.spr_yoshi_wait_blue
	elif mouthholder != null:
		if color == 0.0:
			sprite_index = A.spr_yoshi_fm
		elif color == 1.0:
			sprite_index = A.spr_yoshi_fm_red
		elif color == 2.0:
			sprite_index = A.spr_yoshi_fm_blue
	elif color == 0.0:
		sprite_index = A.spr_yoshi_runaway
	elif color == 1.0:
		sprite_index = A.spr_yoshi_runaway_red
	elif color == 2.0:
		sprite_index = A.spr_yoshi_runaway_blue
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0
	hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
	if absf(hspeed) < 0.1:
		hspeed = 0.0
	if GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle" and modo_lava == 0.0:
		for inst in GM.with_list(GM.instance_create(x, (y - 16.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava
			inst.depth = -10.0
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0:
		for inst in GM.with_list(GM.instance_create(x, (y - 16.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava_purple
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava_purple
			inst.depth = -10.0
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "mountain" and G.modo_noche == 1.0:
		for inst in GM.with_list(GM.instance_create(x, (y - 16.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava
			inst.depth = -10.0
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and y <= GM.instance_find(A.obj_lava_water, 0).y and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
		y = GM.instance_find(A.obj_lava_water, 0).y
	if y > (GM.room_height + 16.0) or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_yoshi_abandon/Alarm_0.gml
func _alarm_0() -> void:
	image_index = 1.0


# from objects/obj_yoshi_abandon/Alarm_1.gml
func _alarm_1() -> void:
	image_index = 0.0
	alarm[0] = 60.0
	alarm[1] = 76.0


# from objects/obj_yoshi_abandon/Alarm_2.gml
func _alarm_2() -> void:
	if vspeed == 0.0:
		vspeed = -0.9
	alarm[2] = 2.0


# from objects/obj_yoshi_abandon/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var yosh: int
	var o = other
	if o.state == 2.0 and o.holding == 0.0 and o.vspeed > 0.0 and o.visible == true and G.powerup != -82.0 and o.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		for inst in GM.with_list(A.obj_mario):
			inst.x = self.x
			inst.y = (self.y - 16.0)
			inst.direct = self.direct
			inst.holding = 3.0
		if color == 0.0:
			yosh = A.obj_yoshi2
		elif color == 1.0:
			yosh = A.obj_yoshi_red
		elif color == 2.0:
			yosh = A.obj_yoshi_blue
		for inst in GM.with_list(GM.instance_create(x, y, yosh)):
			inst.mouthholder = self.mouthholder
			inst.mouthsprite = self.mouthsprite
		GM.audio_stop_sound(A.snd_yoshi)
		GM.audio_play_sound(A.snd_yoshi, 0.0, false)
		instance_destroy()


# from objects/obj_yoshi_abandon/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = direct
	if sprite_index == A.spr_yoshi_wait:
		imdead.sprite_index = A.spr_yoshi_runaway
	else:
		imdead.sprite_index = A.spr_yoshi_runaway_red
	imdead.image_speed = 0.15
	if GM.other.hspeed == 0.0 and direct == 1.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed == 0.0 and direct == -1.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_yoshi_abandon/Other_14.gml
func _user_4() -> void:
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			if GM.variable_instance_exists(self, "bouncy") and bouncy == 1.0:
				if vspeed > 0.5:
					vspeed = ((-vspeed) / 2.0)
				else:
					vspeed = 0.0
					bouncy = 0.0
			else:
				vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.1
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_bullebill_base, true, false) != null and (not place_meeting(x, y, A.obj_bullebill_base)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o2
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			vspeed = 0.0
	if (bbox_top - 64.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_yoshi_abandon/Draw_0.gml
func _gm_draw() -> void:
	var flyanim: float = GM.instance_find(A.obj_levelmanager, 0).anim
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
	if color == 2.0:
		GM.draw_sprite_ext(A.spr_wings, flyanim, (GM.gm_round(x) - 5.5 * direct), GM.gm_round(y) - 17.0, direct, 1.0, 0.0, GM.c_white, 1.0)
