extends "res://objects/obj_deactenemyparent.gd"

var search_mario: float = 0.0
var edible: float = 0.0
var para_rot: float = 0.0
var trow: float = 0.0
var jumping: float = 0.0
var mebelow = null


# from objects/obj_rocangrejo/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_rocangrejo_idle
		1.0:
			sprite_index = A.spr_SMB3_rocangrejo_idle
		2.0:
			sprite_index = A.spr_rocangrejo_idle
		3.0:
			sprite_index = A.spr_NSMBU_rocangrejo_idle
	hardness = 0.0
	stomp = 0.0
	search_mario = 0.0
	direct = -1.0
	edible = 1.0
	wings = 0.0
	paracaidas = 0.0
	para_rot = 0.0
	key = 0.0
	innave = 0.0
	dead_h = 0.0
	swimming = 0.0
	trow = 0.0
	jumping = 0.0
	modo_lava = 0.0
	claw = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	apilar = 0.0
	mebelow = null
	alarm[1] = 180.0


# from objects/obj_rocangrejo/Step_0.gml
func _step() -> void:
	if trow == 1.0:
		if G.apariencia == 3.0:
			if image_index >= 20.0 and image_index < 20.5:
				alarm[2] = 1.0
		elif image_index >= 2.1 and image_index < 2.25:
			alarm[2] = 1.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if gravity == 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.1:
			hspeed = 0.0
	if vspeed > 0.0 and jumping == 1.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.4)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.4:
			hspeed = 0.0
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0)) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	_user_3()
	_user_4()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.set("direct", self.direct)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.set("direct", self.direct)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.set("direct", self.direct)
		instance_destroy()


# from objects/obj_rocangrejo/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_rocangrejo_jump
		1.0:
			sprite_index = A.spr_SMB3_rocangrejo_jump
		2.0:
			sprite_index = A.spr_rocangrejo_jump
		3.0:
			sprite_index = A.spr_NSMBU_rocangrejo_jump
	image_index = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.0
		image_index = 0.0
	if gravity == 0.0:
		jumping = 1.0
		vspeed = (-(3.4 - (1.8 * swimming)))
		hspeed = ((-(1.5 - (1.0 * swimming))) * direct)
	else:
		alarm[0] = 10.0
	y -= 1.0
	jumping = 1.0


# from objects/obj_rocangrejo/Alarm_1.gml
func _alarm_1() -> void:
	if vspeed == 0.0 or claw == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_rocangrejo_throw
			1.0:
				sprite_index = A.spr_SMB3_rocangrejo_throw
			2.0:
				sprite_index = A.spr_rocangrejo_throw
			3.0:
				sprite_index = A.spr_NSMBU_rocangrejo_throw
		image_index = 0.0
		trow = 1.0
	else:
		alarm[1] = 20.0


# from objects/obj_rocangrejo/Alarm_2.gml
func _alarm_2() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_rocangrejo_throw)
		GM.audio_play_sound(A.snd_rocangrejo_throw, 0.0, false)
		for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y - 12.0), A.obj_rorock)):
			inst.hspeed = ((1.0 - (0.5 * self.swimming)) * self.direct)
	else:
		for inst in GM.with_list(GM.instance_create((x + (14.0 * direct)), y, A.obj_rorock)):
			inst.hspeed = ((1.0 - (0.5 * self.swimming)) * self.direct)


# from objects/obj_rocangrejo/Other_7.gml
func _animation_end() -> void:
	if trow == 1.0:
		trow = 0.0
		if claw == 0.0:
			alarm[0] = 1.0
		else:
			_user_2()
		alarm[1] = 180.0


# from objects/obj_rocangrejo/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_rocangrejo_deads
	imdead.image_index = G.apariencia
	if key == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_rocangrejo/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_rocangrejo/Other_12.gml
func _user_2() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_rocangrejo_idle
		1.0:
			sprite_index = A.spr_SMB3_rocangrejo_idle
		2.0:
			sprite_index = A.spr_rocangrejo_idle
		3.0:
			sprite_index = A.spr_NSMBU_rocangrejo_idle
	image_index = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	hspeed = 0.0
	jumping = 0.0


# from objects/obj_rocangrejo/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	var block
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
			if jumping == 1.0:
				_user_2()
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.02
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
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o2
			block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_rocangrejo/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
