extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var s_jump_floruga: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var jump_wings: float = 0.0
var state: float = 0.0
var color: float = 0.0
var seg: float = 0.0
var mybody: Array = []
var closeness: float = 0.0
var amount_previous: float = 0.0
var closeness_h: float = 0.0
var closeness_v: float = 0.0
var i: float = 0.0
var oldx: Array = []
var oldy: Array = []
var moving = null
var multidead = null


# from objects/obj_floruga/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_floruga_head
			sprite_wings = A.spr_SMB_wings
			s_jump_floruga = A.snd_step_enemy
		1.0:
			sprite_index = A.spr_SMB3_floruga_head
			sprite_wings = A.spr_SMB3_wings
			s_jump_floruga = A.snd_step_enemy
		2.0:
			sprite_index = A.spr_floruga_head
			sprite_wings = A.spr_wings
			s_jump_floruga = A.snd_kick
		3.0:
			sprite_index = A.spr_NSMBU_floruga_head
			sprite_wings = A.spr_NSMBU_wings_enemigos
			s_jump_floruga = A.snd_jump_floruga
	hardness = 1.0
	stomp = 5.0
	edible = 2.0
	wings = 0.0
	wings_anim = 0.0
	jump_wings = 0.0
	paracaidas = 0.0
	modo_lava = 0.0
	dead_h = 0.0
	direct = -1.0
	innave = 0.0
	swimming = 0.0
	apilar = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[10] = 2.0
	state = 0.0
	color = 0.0
	# region CREATE BODY PARTS
	# Body parts count
	seg = 5.0
	# Create anatomy
	var b: int = 1
	while b < seg:
		GM.aset(mybody, b, GM.instance_create_depth(xstart, ystart, depth, A.obj_floruga_body))
		if G.apariencia == 3.0:
			mybody[b].image_speed = 0.5
			mybody[b].image_index = (4.0 * b)
		else:
			mybody[b].image_speed = 0.125
			mybody[b].image_index = b
		mybody[b].depth = b
		mybody[b].parent = self
		if b == 1:
			# PORT（用户定，2026-11-12）：原版写 other（是创建者，不是头），第一节身体因此不随头转向；按注释意图改成头自身
			mybody[b].prevsegment = self  # Snap to the head.
		else:
			mybody[b].prevsegment = mybody[b - 1]  # Snap to other consecutive parts.
		b += 1
	# Make body structure
	closeness = 16.0
	amount_previous = 85.0
	closeness_h = 16.0
	closeness_v = 16.0
	# Make body coordinate queue
	i = 1.0
	while i <= amount_previous:
		GM.aset(oldx, i, x)
		GM.aset(oldy, i, y)
		i += 1.0
	# endregion


# from objects/obj_floruga/Destroy_0.gml
func _destroy() -> void:
	i = 1.0
	while i < seg:
		for inst in GM.with_list(mybody[int(i)]):
			inst.instance_destroy()
		i += 1.0


# from objects/obj_floruga/Step_1.gml
func _step_begin() -> void:
	i = 1.0
	while i < seg:
		if not GM.instance_exists(mybody[int(i)]):
			if is_instance_valid(mybody[int(i)]):  # PORT: 已释放的节点传给 instance_activate_object 会报错，GML 里对已销毁 id 是空操作
				GM.instance_activate_object(mybody[int(i)])
		i += 1.0
	if speed == 0.0:
		return
	i = 1.0
	while i < seg:
		if GM.instance_exists(mybody[int(i)]):
			mybody[int(i)].x = oldx[int(i * closeness)]
		i += 1.0
	GM.aset(oldx, 0, x)
	GM.aset(oldy, 0, y)
	i = amount_previous
	while i > 0.0:
		GM.aset(oldx, i, oldx[int(floorf(i - 0.001))])  # PORT: GML 数组下标 i-0.001 按向下取整（假设，同 UNVERIFIED 取整）
		i -= 1.0
	if wings == 1.0:
		i = amount_previous
		while i > 0.0:
			GM.aset(oldy, i, oldy[int(floorf(i - 0.001))])
			i -= 1.0


# from objects/obj_floruga/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		_user_6()
	if wings == 1.0 and paracaidas == 0.0:
		wings_anim += 0.12
		if gravity == 0.0:
			if swimming == 1.0:
				vspeed = -2.062
			else:
				vspeed = -4.125
	if paracaidas == 1.0:
		direct = -1.0
		if x > (xstart + 16.0):
			if hspeed < -0.5:
				hspeed = -0.5
			else:
				hspeed -= 0.015
		elif x < (xstart - 16.0):
			if hspeed > 0.5:
				hspeed = 0.5
			else:
				hspeed += 0.015
		if gravity == 0.0:
			GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
			paracaidas = 0.0
			hspeed = 0.0
			alarm[10] = 10.0
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0


# from objects/obj_floruga/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x < x and hspeed > 0.0:
			hspeed = -1.0
			alarm[0] = 40.0
		elif GM.instance_find(A.obj_mario, 0).x > x and hspeed < 0.0:
			hspeed = 1.0
			alarm[0] = 40.0
		else:
			alarm[0] = 40.0
	else:
		alarm[0] = 1.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.27
	speed = 1.0
	state = 2.0
	i = 1.0
	while i < seg:
		if GM.instance_exists(mybody[int(i)]):
			if G.apariencia == 3.0:
				mybody[int(i)].image_speed = 0.5
			else:
				mybody[int(i)].image_speed = 0.27
		i += 1.0


# from objects/obj_floruga/Alarm_1.gml
func _alarm_1() -> void:
	if state == 1.0:
		alarm[1] = 2.0
		color += 1.0
		if color > 8.0:
			color = 0.0
	else:
		color = 0.0


# from objects/obj_floruga/Alarm_2.gml
func _alarm_2() -> void:
	var smoke1
	var smoke2
	smoke1 = GM.instance_create((x + (4.0 * direct)), (y + 4.0), A.obj_smoke)
	smoke2 = GM.instance_create((x + (4.0 * direct)), (y + 4.0), A.obj_smoke)
	smoke1.sprite_index = A.spr_NSMBU_smoke_floruga
	smoke2.sprite_index = A.spr_NSMBU_smoke_floruga
	smoke1.depth = (depth - 1.0)
	smoke2.depth = (depth - 1.0)
	smoke2.direct = -1.0
	alarm[2] = 80.0


# from objects/obj_floruga/Alarm_10.gml
func _alarm_10() -> void:
	if Scr.outside_view(self) <= 0.5 and gravity == 0.0:
		if state == 2.0:
			match G.apariencia:
				0.0:
					sprite_index = A.spr_SMB_floruga_angry_head
				1.0:
					sprite_index = A.spr_SMB3_floruga_angry_head
				2.0:
					sprite_index = A.spr_floruga_angry_head
				3.0:
					sprite_index = A.spr_NSMBU_floruga_angry_head
			# ORIG-BUG: 循环里改的是自己的 sprite_index（应是 mybody[i].sprite_index），照搬
			i = 1.0
			while i < seg:
				match G.apariencia:
					0.0:
						sprite_index = A.spr_SMB_floruga_angry_body
					1.0:
						sprite_index = A.spr_SMB3_floruga_angry_body
					2.0:
						sprite_index = A.spr_floruga_angry_body
					3.0:
						sprite_index = A.spr_NSMBU_floruga_angry_body
				i += 1.0
		moving = 1.0
		i = 0.0
		while i < 4.0:
			# ORIG-BUG: 循环 i=0..3，mybody[0] 在 GML 里是数组补的 0，with (0) 作用于 object 编号 0 的实例，且第 4 节身体不处理；照搬
			for inst in GM.with_list(mybody[int(i)]):
				inst.set("direct", -1.0)
			i += 1.0
		super._alarm_10()
		# PORT: 原版 event_user(15)，本类及父类链都没有 user 15 事件，GML 里是空操作，直接省略
	else:
		alarm[10] = 1.0


# from objects/obj_floruga/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.sprite_index = sprite_index
	imdead.direct = direct
	imdead.hspeed = 0.0
	imdead.vspeed = -4.0
	multidead = GM.instance_create(x, y, A.obj_enemy_multidead)
	for inst in GM.with_list(multidead):
		inst.count = 4.0
		inst.direct = self.direct
		if self.state == 0.0:
			match G.apariencia:
				0.0:
					inst.sprite_index = A.spr_SMB_floruga_body
				1.0:
					inst.sprite_index = A.spr_SMB3_floruga_body
				2.0:
					inst.sprite_index = A.spr_floruga_body
				3.0:
					inst.sprite_index = A.spr_NSMBU_floruga_body
		else:
			match G.apariencia:
				0.0:
					inst.sprite_index = A.spr_SMB_floruga_angry_body
				1.0:
					inst.sprite_index = A.spr_SMB3_floruga_angry_body
				2.0:
					inst.sprite_index = A.spr_floruga_angry_body
				3.0:
					inst.sprite_index = A.spr_NSMBU_floruga_angry_body
	instance_destroy()


# from objects/obj_floruga/Other_11.gml
func _user_1() -> void:
	GM.audio_stop_sound(s_jump_floruga)
	GM.audio_play_sound(s_jump_floruga, 0.0, false)
	if state == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
			inst.sprite_index = A.spr_wiggler_flower
			inst.image_index = G.apariencia
			inst.image_speed = 0.0
			inst.direct = self.direct
		speed = 0.0
		state = 1.0
		closeness = 8.0
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_floruga_angry_head
			1.0:
				sprite_index = A.spr_SMB3_floruga_angry_head
			2.0:
				sprite_index = A.spr_floruga_angry_head
			3.0:
				sprite_index = A.spr_NSMBU_floruga_angry_head
				alarm[2] = 20.0
		i = 1.0
		while i < seg:
			if GM.instance_exists(mybody[int(i)]):
				match G.apariencia:
					0.0:
						mybody[int(i)].sprite_index = A.spr_SMB_floruga_angry_body
					1.0:
						mybody[int(i)].sprite_index = A.spr_SMB3_floruga_angry_body
					2.0:
						mybody[int(i)].sprite_index = A.spr_floruga_angry_body
					3.0:
						mybody[int(i)].sprite_index = A.spr_NSMBU_floruga_angry_body
			i += 1.0
		amount_previous = 85.0
		alarm[1] = 1.0
		alarm[0] = 60.0


# from objects/obj_floruga/Other_12.gml
func _user_2() -> void:
	if hspeed > 0.0:
		if (collision_rectangle(bbox_right, bbox_top, (bbox_right + (hspeed * 2.0)), bbox_bottom, A.obj_enemyparent, false, true) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + (hspeed * 2.0)), bbox_bottom, A.obj_enemyparent_held, false, true) != null) and (collision_rectangle(bbox_right, bbox_top, (bbox_right + (hspeed * 2.0)), bbox_bottom, A.obj_floruga_body, false, true) == null):
			hspeed = (-hspeed)
	elif hspeed < 0.0:
		if (collision_rectangle((bbox_left - (hspeed * 2.0)), bbox_top, bbox_left, bbox_bottom, A.obj_enemyparent, false, true) != null or collision_rectangle((bbox_left - (hspeed * 2.0)), bbox_top, bbox_left, bbox_bottom, A.obj_enemyparent_held, false, true) != null) and (collision_rectangle((bbox_left - (hspeed * 2.0)), bbox_top, bbox_left, bbox_bottom, A.obj_floruga_body, false, true) == null):
			hspeed = (-hspeed)


# from objects/obj_floruga/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_spring_land, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_spring_land, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
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


# from objects/obj_floruga/Other_16.gml
func _user_6() -> void:
	if gravity == 0.0:
		if hspeed < 0.0:
			if (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 12.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 12.0), A.obj_slopeparent, false, false) == null):
				hspeed = (-hspeed)
				x = xprevious
				if state == 1.0:
					alarm[1] = 40.0
		elif hspeed > 0.0:
			if (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 12.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 12.0), A.obj_slopeparent, false, false) == null):
				hspeed = (-hspeed)
				x = xprevious
				if state == 1.0:
					alarm[1] = 40.0


# from objects/obj_floruga/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		if direct == 1.0:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x - 12.0), (y - 20.0), direct, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x + 12.0), (y - 20.0), direct, 1.0, 0.0, GM.c_white, 1.0)
