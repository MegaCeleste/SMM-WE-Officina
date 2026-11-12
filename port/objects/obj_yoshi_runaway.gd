# 第 4 批移植，已核对。
extends "res://objects/obj_physicsparent.gd"

var colour: float = 0.0
var color: float = 0.0
var mouthholder = null  # object 编号（int）；noone 用 null（同 obj_yoshi2）
var mouthsprite = null  # sprite 编号（int）；noone 用 null
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var modo_lava: float = 0.0


# from objects/obj_yoshi_runaway/Create_0.gml
func _create() -> void:
	colour = 0.0
	color = 0.0
	swimming = 0.0
	image_speed = 0.3
	if GM.instance_exists(A.obj_mario):
		direct = GM.instance_find(A.obj_mario, 0).direct
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = -4.0
			inst.visible = true
	else:
		direct = 1.0
	hspeed = (direct * 2.0)
	G.yoshi = 0.0
	mouthholder = null
	mouthsprite = null
	GM.audio_play_sound(A.snd_yoshi_golpe, 0.0, false)
	ready_v = 0.0
	modo_lava = 0.0
	alarm[0] = 80.0
	alarm[1] = 1.0
	# event_inherited(): 父类无此事件


# from objects/obj_yoshi_runaway/Step_0.gml
func _step() -> void:
	super._step()
	_user_1()
	if hspeed > 0.0:
		direct = 1.0
	else:
		direct = -1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0 and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and y <= GM.instance_find(A.obj_lava_water, 0).y and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
		y = GM.instance_find(A.obj_lava_water, 0).y
	if y > (GM.room_height + 16.0) or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_yoshi_runaway/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 1.0


# from objects/obj_yoshi_runaway/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if ready_v > 0.5 and o.state == 2.0 and o.holding == 0.0 and o.visible == true and o.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		for inst in GM.with_list(A.obj_mario):
			inst.x = self.x
			inst.y = (self.y - 18.0)
			inst.direct = self.direct
			inst.holding = 3.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_yoshi2)):
			inst.mouthholder = self.mouthholder
			inst.mouthsprite = self.mouthsprite
		GM.audio_play_sound(A.snd_yoshi, 0.0, false)
		instance_destroy()


# from objects/obj_yoshi_runaway/Other_11.gml
func _user_1() -> void:
	if mouthholder != null:
		sprite_index = A.spr_yoshi_fm
	else:
		sprite_index = A.spr_yoshi_runaway


# from objects/obj_yoshi_runaway/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o2
		hspeed = (-hspeed)
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
		if (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
				x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0


# from objects/obj_yoshi_runaway/Draw_0.gml
func _gm_draw() -> void:
	var flyanim: float = GM.instance_find(A.obj_levelmanager, 0).anim
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
	if object_index == A.obj_yoshi_runaway_blue:
		GM.draw_sprite_ext(A.spr_wings, flyanim, (GM.gm_round(x) - 6.0 * direct), GM.gm_round(y) - 22.0, direct, 1.0, 0.0, GM.c_white, 1.0)
