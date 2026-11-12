extends "res://objects/obj_deactenemyparent.gd"

var waddlewing_jump: int = 0
var waddlewing_fly: int = 0
var waddlewing_wall: int = 0
var waddlewing: int = 0
var search_mario: float = 0.0
var edible: float = 0.0
var para_rot: float = 0.0
var jumping: float = 0.0
var anim: float = 0.0
var big: float = 0.0
var cambio_gombaya: float = 0.0
var doublejump: float = 0.0
var timer_ardilla: float = 0.0
var timer_walljump: float = 0.0
var walljump: float = 0.0
var walljump_ex: float = 0.0
var fly_anim: float = 0.0


# from objects/obj_waddlewing/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			waddlewing_jump = A.spr_SMB_waddlewing_jump
			waddlewing_fly = A.spr_SMB_waddlewing_fly
			waddlewing_wall = A.spr_SMB_waddlewing_wall
			waddlewing = A.spr_SMB_waddlewing
			sprite_index = A.spr_SMB_waddlewing
		1.0:
			waddlewing_jump = A.spr_SMB3_waddlewing_jump
			waddlewing_fly = A.spr_SMB3_waddlewing_fly
			waddlewing = A.spr_SMB3_waddlewing
			waddlewing_wall = A.spr_SMB3_waddlewing_wall
			sprite_index = A.spr_SMB3_waddlewing
		2.0:
			waddlewing_jump = A.spr_waddlewing_jump
			waddlewing_fly = A.spr_waddlewing_fly
			waddlewing = A.spr_waddlewing
			waddlewing_wall = A.spr_waddlewing_wall
			sprite_index = A.spr_waddlewing
		3.0:
			waddlewing_jump = A.spr_NSMBU_waddlewing_jump
			waddlewing_fly = A.spr_NSMBU_waddlewing_fly
			waddlewing = A.spr_NSMBU_waddlewing
			waddlewing_wall = A.spr_NSMBU_waddlewing_wall
			sprite_index = A.spr_NSMBU_waddlewing
	search_mario = 0.0
	hardness = 0.0
	stomp = 0.0
	direct = -1.0
	edible = 1.0
	wings = 0.0
	paracaidas = 0.0
	para_rot = 0.0
	key = 0.0
	jumping = 0.0
	anim = 0.0
	big = 0.0
	innave = 0.0
	dead_h = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	cambio_gombaya = 0.0
	doublejump = 0.0
	timer_ardilla = 0.0
	timer_walljump = 0.0
	walljump = 0.0
	walljump_ex = 0.0
	fly_anim = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.9
	else:
		image_speed = 0.15
	alarm[10] = 2.0
	alarm[0] = 120.0


# from objects/obj_waddlewing/Step_0.gml
func _step() -> void:
	super._step()
	# Jump and fly
	_user_6()
	# Check for a wall collision
	_user_8()
	if gravity != 0.0 and doublejump != 1.0:
		doublejump = 2.0
		fly_anim = 1.0
		hspeed = (0.5 * direct)
		hspeed += 0.6 * direct


# from objects/obj_waddlewing/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 3.0:
		if sprite_index == waddlewing_wall and image_index >= 10.0:
			image_speed = 0.0
			image_index = 10.0
		elif sprite_index == waddlewing_jump and image_index >= 13.0:
			image_speed = 0.0
			image_index = 13.0
		else:
			image_speed = 0.9
	if walljump == 0.0 or walljump == 2.0:
		if doublejump == 1.0:
			sprite_index = waddlewing_jump
		elif doublejump == 2.0:
			if (G.apariencia == 3.0 and GM.eq(image_index, 13.0)) or (fly_anim == 1.0):
				sprite_index = waddlewing_fly
			elif G.apariencia != 3.0:
				sprite_index = waddlewing_fly
		else:
			sprite_index = waddlewing
	else:
		sprite_index = waddlewing_wall


# from objects/obj_waddlewing/Alarm_0.gml
func _alarm_0() -> void:
	if wings == 1.0:
		if gravity == 0.0:
			jumping = 1.0
			if swimming == 0.0:
				vspeed = -2.5
			else:
				vspeed = -1.25
		else:
			alarm[0] = 10.0


# from objects/obj_waddlewing/Alarm_1.gml
func _alarm_1() -> void:
	if search_mario == 0.0:
		search_mario = 1.0
	else:
		search_mario = 0.0


# from objects/obj_waddlewing/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if paracaidas == 1.0 or vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = (0.3 * direct)
			else:
				hspeed = (0.5 * direct)
		else:
			alarm[10] = 2.0


# from objects/obj_waddlewing/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	if G.apariencia != 3.0:
		imdead.sprite_index = A.spr_waddlewing_deads
		imdead.image_index = G.apariencia
	else:
		imdead.sprite_index = A.spr_NSMBU_waddlewing_deads
		imdead.image_index = 0.0
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
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


# from objects/obj_waddlewing/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_waddlewing/Other_13.gml
# PORT: 原版此处是 obj_physicsparent/Other_13.gml 的逐字副本（已逐句比对，完全一致，且无 event_inherited），
# 所以不重复翻译，直接用 obj_physicsparent.gd 的 _user_3()


# from objects/obj_waddlewing/Other_14.gml
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
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.0, A.obj_slopeparent, true, false) != null) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		timer_ardilla = -1.0
		doublejump = 0.0
		walljump_ex = 0.0
		fly_anim = 0.0
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
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
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
			timer_ardilla = 14.0
			doublejump = 2.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o
			vspeed = 0.0
	if ((bbox_top - 16.0) > GM.room_height and object_index != A.obj_player_goal_parent and object_index != A.obj_podoboo) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)) and object_index != A.obj_podoboo and object_index != A.obj_grrrol and object_index != A.obj_spring_land and object_index != A.obj_player_goal_parent):
		instance_destroy()
	_user_14()


# from objects/obj_waddlewing/Other_15.gml
func _user_5() -> void:
	var imheld
	_user_0()
	instance_destroy()


# from objects/obj_waddlewing/Other_16.gml
func _user_6() -> void:
	if doublejump == 0.0:
		if hspeed < 0.0:
			if (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null):
				doublejump = 1.0
				timer_ardilla = 0.0
				walljump_ex = 0.0
		elif hspeed > 0.0:
			if (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null):
				doublejump = 1.0
				timer_ardilla = 0.0
				walljump_ex = 0.0
	if doublejump == 1.0 and timer_ardilla != 14.0:
		timer_ardilla += 1.0
	if doublejump == 1.0 and timer_ardilla != 0.0 and timer_ardilla < 12.0:
		vspeed = -3.0
		hspeed += 0.2 * direct
	elif timer_ardilla > 12.0 and vspeed >= 0.0:
		timer_ardilla = 14.0
		doublejump = 2.0
	if doublejump == 2.0:
		vspeed = 0.0
		if walljump_ex == 0.0:
			vspeed += 0.655
		else:
			vspeed += 1.0


# from objects/obj_waddlewing/Other_17.gml
func _user_7() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_waddlewing
		1.0:
			sprite_index = A.spr_SMB3_waddlewing
		2.0:
			sprite_index = A.spr_waddlewing


# from objects/obj_waddlewing/Other_18.gml
func _user_8() -> void:
	if walljump == 0.0 and gravity != 0.0:
		if collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_solid, true, false) != null or collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_onewaygate_left, true, false) != null:
			walljump = 1.0
			doublejump = 0.0
			fly_anim = 0.0
			direct = 1.0
		elif collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_solid, true, false) != null or collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_onewaygate_right, true, false) != null:
			walljump = 1.0
			doublejump = 0.0
			fly_anim = 0.0
			direct = -1.0
	if walljump == 1.0:
		hspeed = 0.0
		gravity = 0.0
		vspeed = 0.0
		timer_walljump += 1.0
	if timer_walljump > 50.0:
		hspeed = 0.5 * direct
		doublejump = 1.0
		walljump = 2.0
		walljump_ex = 1.0
		timer_walljump = 0.0
		timer_ardilla = 0.0
	if collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_solid, true, false) == null and collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_solid, true, false) == null and collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_physicssolid, true, false) == null and collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_physicssolid, true, false) == null and collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_bullebill_base, true, false) == null and collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_bullebill_base, true, false) == null and collision_rectangle(bbox_right, bbox_top + 4.0, bbox_right + 1.0, bbox_bottom - 1.0, A.obj_onewaygate_left, true, false) == null and collision_rectangle(bbox_left - 1.0, bbox_top + 4.0, bbox_left, bbox_bottom - 1.0, A.obj_onewaygate_right, true, false) == null:
		walljump = 0.0


# from objects/obj_waddlewing/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		match G.apariencia:
			0.0:
				GM.draw_sprite_ext(A.spr_SMB_wings_16x16, anim, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
			1.0:
				GM.draw_sprite_ext(A.spr_SMB3_wings2, anim, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
			2.0:
				GM.draw_sprite_ext(A.spr_wings2, anim, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
			3.0:
				GM.draw_sprite_ext(A.spr_NSMBU_wings_enemigos, anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, 0.0, GM.c_white, 1.0)
	#
	# draw_text(x,y,string(gravity))
	# draw_text(x+5,y,string(hspeed))
	# draw_set_color(c_black)
	# draw_text(x+5,y,string(walljump))
	# /*
