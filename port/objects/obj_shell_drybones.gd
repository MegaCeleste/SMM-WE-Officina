# from objects/obj_shell_drybones（第 5 批移植，已核对）
extends "res://objects/obj_shell.gd"

var s_dry: float = 0.0
var imdead2 = null
var imdead3 = null
var dir = null  # 由 obj_kuribo_drybones/Other_10.gml 写入


# from objects/obj_shell_drybones/Create_0.gml
func _create() -> void:
	super._create()
	s_dry = A.spr_drybones_deads
	inmune = 1.0
	alarm[6] = 10.0
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_shell_drybones
		1.0:
			sprite_index = A.spr_SMB3_shell_drybones
		2.0:
			sprite_index = A.spr_shell_drybones
		3.0:
			sprite_index = A.spr_NSMBU_shell_drybones


# from objects/obj_shell_drybones/Destroy_0.gml
func _destroy() -> void:
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_player_warp):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_doormario):
			inst.holding = 0.0


# from objects/obj_shell_drybones/Collision_obj_fireball.gml
func _collision_obj_fireball(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.instance_destroy()


# from objects/obj_shell_drybones/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if kickme == 1.0 and inmune == 0.0 and (not GM.instance_exists(A.obj_invincibility)) and o.groundpount == 0.0:
		if held == 0.0:
			if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0 and G.yoshi == 0.0 and o.state == 2.0 and o.holding == 0.0 and ((not GM.keyboard_check(G.lanzar_agarrar)) or G.apariencia == 0.0):
				_user_1()
			elif Scr.scr_canhold(self) > 0.5 and (inwall <= 0.5):
				o.holding = 2.0
				if G.apariencia == 2.0 and o.isduck == 1.0:
					isduckhold = 1.0
				if G.apariencia == 3.0:
					GM.audio_play_sound(GM.choose(A.snd_NSMBU_hold1, A.snd_NSMBU_hold2), 0.0, false)
					for inst in GM.with_list(other):
						inst.triple_jump = 0.0
						inst.triple_count = 0.0
				held = 1.0
				depth = -7.0
				gravity = 0.0
				speed = 0.0
			elif inmune == 0.0:
				if o.stompstyle == 1.0 or (G.yoshi == 1.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0):
					if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0:
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(A.obj_mario):
							inst.event_user(1)
						GM.other = _o
						_user_0()
				elif G.yoshi == 2.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0:
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(1)
					GM.other = _o2
					if G.apariencia < 2.0:
						if GM.instance_exists(A.obj_kuribo_drybones):
							GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
						else:
							GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
					else:
						GM.audio_play_sound(A.snd_kick, 0.0, false)
					GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					_user_0()
				elif vspeed >= 0.0 or (vspeed >= 0.0 and G.yoshi > 0.0):
					GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
					if not GM.instance_exists(A.obj_smoke):
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
							inst.sprite_index = A.spr_spinthump
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_mario):
						if inst.holding == 0.0 and G.apariencia != 0.0 and G.apariencia != 3.0:
							inst.event_user(7)
					GM.other = _o3
					alarm[5] = -1.0
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell_drybones_held)):
						inst.sprite_index = self.sprite_index
						if GM.instance_exists(A.obj_mario):
							if (not GM.instance_exists(A.obj_mario)) or i_mario.x < (inst.x + 8.0):
								if i_mario.hspeed == 0.0:
									inst.hspeed = 2.0
									inst.spd = 2.5
								else:
									inst.hspeed = (2.0 + (i_mario.hspeed / 2.0))
									inst.spd = (2.2 + absf((i_mario.hspeed / 2.0)))
								inst.prevhspeed = inst.hspeed
								if inst.spd > 3.2:
									inst.spd = 3.2
							else:
								if i_mario.hspeed == 0.0:
									inst.hspeed = -2.0
									inst.spd = -2.5
								else:
									inst.hspeed = (-((2.0 + absf((i_mario.hspeed / 2.0)))))
									inst.spd = (-((2.2 + absf((i_mario.hspeed / 2.0)))))
								inst.prevhspeed = inst.hspeed
								if inst.spd < -3.2:
									inst.spd = -3.2
							inst.vspeed = self.vspeed
						inst.inmune = 1.0
						inst.alarm[2] = 12.0
					instance_destroy()


# from objects/obj_shell_drybones/Other_10.gml
func _user_0() -> void:
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	match G.apariencia:
		0.0:
			s_dry = A.spr_SMB_shell_drybones_deads
		1.0:
			s_dry = A.spr_SMB3_shell_drybones_deads
		2.0:
			s_dry = A.spr_shell_drybones_deads2
		3.0:
			s_dry = A.spr_NSMBU_shell_drybones_deads
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = int(s_dry)  # PORT: s_dry 声明为 float（存的是 sprite 编号），赋给 int 型 sprite_index 时显式转换
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.direct = direct
	imdead.gravity = 0.16
	imdead2 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead2.girar = 1.0
	imdead2.sprite_index = int(s_dry)
	imdead2.image_speed = 0.0
	imdead2.image_index = 1.0
	imdead2.direct = direct
	imdead2.gravity = 0.16
	imdead3 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead3.girar = 1.0
	imdead3.sprite_index = int(s_dry)
	imdead3.image_speed = 0.0
	imdead3.image_index = 2.0
	imdead3.direct = direct
	imdead3.gravity = 0.16
	imdead.hspeed = -0.5
	imdead.vspeed = -0.5
	imdead2.hspeed = -0.5
	imdead3.hspeed = 0.5
	instance_destroy()


# from objects/obj_shell_drybones/Other_11.gml
func _user_1() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if i_mario.visible == true:
		x = i_mario.x
		y = (i_mario.y + 16.0)
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 3.0
		GM.audio_play_sound(A.snd_shell_drybones_in, 0.0, false)
		GM.instance_create(i_mario.x, i_mario.y, A.obj_kuribo_drybones)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.dash_atack = 0.0
			inst.dash_cont = 0.0
			inst.arrow = 0.0
			inst.arrow_ready = 0.0
			inst.event_user(15)
		GM.other = _o
		instance_destroy()


# from objects/obj_shell_drybones/Other_12.gml
func _user_2() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	var lugar  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.keyboard_check(G.abajo):
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null:
			inwall = 1.0
			hspeed = 0.0
		hspeed = (0.5 * i_mario.direct)
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
		inmune = 1.0
		alarm[6] = 15.0
	elif GM.keyboard_check(G.arriba) and G.apariencia == 2.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		if i_mario.hspeed == 0.0:
			hspeed = 0.0
		else:
			hspeed = (i_mario.direct / 2.0)
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			vspeed = -3.0
			swimming = 1.0
		else:
			vspeed = -6.125
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null:
			inwall = 1.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
	elif vspeed >= 0.0:
		if G.apariencia == 3.0:
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_throw1, A.snd_NSMBU_throw2, A.snd_NSMBU_throw1), 0.0, false)
		else:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o2
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		if i_mario.helice_fly != 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.helice_fly = 5.0
		alarm[5] = -1.0
		if place_meeting(x, y, A.obj_solid):
			if i_mario.direct == 1.0:
				lugar = (x - 16.0)
			else:
				lugar = (x + 16.0)
		else:
			lugar = x
		for inst in GM.with_list(GM.instance_create(lugar, y, A.obj_shell_drybones_held)):
			inst.vspeed = 0.1
			inst.sprite_index = self.sprite_index
			if i_mario.hspeed == 0.0:
				inst.hspeed = 2.0
				inst.spd = 2.5
			else:
				inst.hspeed = (2.2 + absf((i_mario.hspeed / 2.0)))
				inst.spd = (2.2 + absf((i_mario.hspeed / 2.0)))
			inst.prevhspeed = inst.hspeed
			if inst.spd > 3.2:
				inst.spd = 3.2
			inst.hspeed *= GM.gm_sign(i_mario.direct)
			inst.prevhspeed *= GM.gm_sign(i_mario.direct)
			inst.spd *= GM.gm_sign(i_mario.direct)
			inst.hardness = self.hardness
			inst.inmune = 1.0
			inst.alarm[2] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
		instance_destroy()


# from objects/obj_shell_drybones/Other_14.gml
func _user_4() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		var solidlava = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if solidlava != null and bbox_bottom < (solidlava.yprevious + 5.0):
			y = (solidlava.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_lava_water_drybones, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_lava_water_drybones, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif swimming <= 0.5:
		gravity = 0.15
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			# 原文是数字 40、103，按 port-plan §9 Q3 当作 obj_holdparent、obj_enemyparent_held
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_shell_drybones/Other_17.gml
func _user_7() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > i_lava_water.y and G.bg_level == "forest" and G.modo_noche == 0.0):
		vspeed = -2.125
	else:
		vspeed = -4.125
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		hspeed = -0.5
