# from objects/obj_spring_land（第 5 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）；本 object 不是 holdparent 子类，自己声明
var modo_lava: float = 0.0
var my_object: int = 0
var mytop = null
var enable: float = 0.0
var koopa_inside: float = 0.0
var imagen = null
var sp_obj: float = 0.0
var id_obj: float = 0.0
var golpe_dir: float = 0.0
var mebelow = null
var a: float = 0.0
var offset: float = 0.0
var offsetnext: float = 0.0
var offsetxscale: float = 0.0
var col_pokey = null


# from objects/obj_spring_land/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_spring_land
		1.0:
			sprite_index = A.spr_SMB3_spring_land
		2.0:
			sprite_index = A.spr_spring_land
		3.0:
			sprite_index = A.spr_NSMBU_spring_land
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	direct = 1.0
	swimming = 0.0
	modo_lava = 0.0
	my_object = A.obj_lighting
	mytop = GM.instance_create(x, y, A.obj_solidtop)
	enable = 0.0
	koopa_inside = 0.0
	imagen = 1869.0
	sp_obj = 0.0
	id_obj = 0.0
	golpe_dir = 1.0
	# ORIG-BUG: 条件里同一个 position_meeting 和它的否定 and 在一起，恒为 false，else 分支永远执行；照搬
	if position_meeting(x, (bbox_bottom + 8.0), A.obj_spring_land) and (not position_meeting(x, (bbox_bottom + 8.0), A.obj_spring_land)):
		mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_spring_land, false, false)
		alarm[0] = 10.0
	else:
		mebelow = null
	a = -16.0
	alarm[9] = 2.0
	offset = 0.0
	offsetnext = 0.0
	offsetxscale = 1.0


# from objects/obj_spring_land/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(mytop):
		inst.instance_destroy()


# from objects/obj_spring_land/Step_1.gml
func _step_begin() -> void:
	var next = null
	if not GM.instance_exists(mebelow):
		next = mebelow
		while next != null:
			GM.instance_activate_object(next)
			if GM.instance_exists(next):
				next = next.mebelow
			else:
				next = null


# from objects/obj_spring_land/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if mebelow == null:
		col_pokey = collision_point(x, (bbox_bottom + 8.0), A.obj_spring_land, false, false)
		if position_meeting(x, (bbox_bottom + 8.0), A.obj_spring_land):
			mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_spring_land, false, false)
			vspeed = 0.0
			gravity = 0.0
			alarm[0] = 10.0
		else:
			if gravity == 0.0:
				hspeed = (maxf(0.0, (absf(hspeed) - 0.15)) * GM.gm_sign(hspeed))
				if absf(hspeed) < 0.15:
					hspeed = 0.0
			super._step()
			offset = 0.0
			offsetnext = 0.0
			alarm[0] = -1.0
	else:
		GM.instance_activate_object(mebelow)
		if GM.instance_exists(mebelow):
			x = mebelow.x
			y = (mebelow.y - sprite_height)
		else:
			mebelow = null


# from objects/obj_spring_land/Step_2.gml
func _step_end() -> void:
	if gravity == 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.1:
			hspeed = 0.0
	if GM.instance_exists(mytop):
		mytop.x = x
		mytop.y = y
		if GM.instance_exists(A.obj_mario):
			var i_mario = GM.instance_find(A.obj_mario, 0)
			if collision_rectangle(bbox_left, (bbox_top - 8.0), bbox_right, (bbox_top + 7.0), A.obj_mario, false, false) != null and i_mario.y < (y - 28.0) and i_mario.state < 2.0 and (not place_meeting(x, (y - 16.0), A.obj_spring_land)):
				if vspeed == 0.0:
					for inst in GM.with_list(A.obj_mario):
						inst.y = ceilf((bbox_top - 32.0))
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.y = ceilf((bbox_top - (32.0 - vspeed)))
				if (hspeed > 0.0 and (collision_rectangle((i_mario.bbox_right + hspeed), i_mario.bbox_top, (i_mario.bbox_right + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((i_mario.bbox_left + hspeed), i_mario.bbox_top, (i_mario.bbox_left + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)):
					for inst in GM.with_list(A.obj_mario):
						inst.x += (x - xprevious)
			if collision_rectangle(bbox_left, bbox_top, (bbox_right - 8.0), bbox_bottom, A.obj_mario, false, false) != null and (collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null) and i_mario.x < (x + 6.0):
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = -3.5
				_user_1()
			elif collision_rectangle((bbox_left + 8.0), bbox_top, bbox_right, bbox_bottom, A.obj_mario, false, false) != null and (collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null) and i_mario.x >= (x + 10.0):
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = 3.5
				_user_1()
	super._step_end()


# from objects/obj_spring_land/Alarm_0.gml
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


# from objects/obj_spring_land/Alarm_9.gml
func _alarm_9() -> void:
	if mebelow == null:
		for _rep in range(99):
			if position_meeting(x, (bbox_top + a), A.obj_spring_land):
				a -= 16.0
			else:
				a += 16.0
				if a < -16.0:
					a = -16.0
	alarm[9] = 2.0


# from objects/obj_spring_land/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	if other.held == 0.0:  # UNVERIFIED: obj_block_pow_hold 未移植（空壳），held / explode 读写在空壳上
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_block_pow_hold, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			other.explode = 0.0
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
				other.vspeed = -1.5
				other.hspeed = -2.0
			else:
				other.hspeed = -3.0
				other.vspeed = -2.9
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			other.explode = 0.0
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
				other.vspeed = -1.5
				other.hspeed = 2.0
			else:
				other.vspeed = -2.9
				other.hspeed = 3.0
			_user_1()


# from objects/obj_spring_land/Collision_obj_buzzybeetle.gml
func _collision_obj_buzzybeetle(other: GMObject) -> void:
	if other.wings == 0.0:  # UNVERIFIED: obj_buzzybeetle 未移植（空壳）
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			other.hspeed = -3.0
			if other.inup == 1.0:
				other.inup = 0.0
			else:
				other.vspeed = (-(2.9 - (1.5 * swimming)))
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			other.hspeed = 3.0
			if other.inup == 1.0:
				other.inup = 0.0
			else:
				other.vspeed = (-(2.9 - (1.5 * swimming)))
			_user_1()


# from objects/obj_spring_land/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	if other.held == 0.0:
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
				other.vspeed = -1.5
				other.hspeed = -2.0
			else:
				other.vspeed = -2.9
				other.hspeed = -3.0
			if other.object_index == A.obj_galoomba_hold or other.object_index == A.obj_bobomb_hold:
				other.direct = -1.0
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
				other.vspeed = -1.5
				other.hspeed = 2.0
			else:
				other.vspeed = -2.9
				other.hspeed = 3.0
			if other.object_index == A.obj_galoomba_hold or other.object_index == A.obj_bobomb_hold:
				other.direct = 1.0
			_user_1()


# from objects/obj_spring_land/Collision_obj_physicsparent.gml
func _collision_obj_physicsparent(other: GMObject) -> void:
	if other.object_index == A.obj_jumppiranha and other.inup > 0.0:
		return
	if other.object_index != A.obj_fire_clown and other.object_index != A.obj_thwomp and other.object_index != A.obj_banzaibill and other.object_index != A.obj_billbanzai_red and other.object_index != A.obj_bulletbull_red and other.object_index != A.obj_cap and other.object_index != A.obj_boo and other.object_index != A.obj_spring_land and other.object_index != A.obj_podoboo and other.object_index != A.obj_podoboo_b and other.object_index != A.obj_yoshifire and other.object_index != A.obj_yoshifire_one and other.object_index != A.obj_blooper and other.object_index != A.obj_bulletbill and other.object_index != A.obj_bullebill_base and other.object_index != A.obj_grinder and other.object_index != A.obj_cheepcheep and other.object_index != A.obj_cheepcheep2 and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red and other.object_index != A.obj_muncher and other.object_index != A.obj_muncher_b and other.object_index != A.obj_fireball and other.object_index != A.obj_pokey and other.object_index != A.obj_floruga and other.object_index != A.obj_floruga_body and other.object_index != A.obj_piranhaplant and other.object_index != A.obj_rocky and other.object_index != A.obj_torbellino and other.object_index != A.obj_egg and other.object_index != A.obj_egg_red and other.object_index != A.obj_egg_hatch and other.object_index != A.obj_lakitu:
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			if other.object_index == A.obj_clown or other.object_index == A.obj_clown_fire:
				for inst in GM.with_list(other):
					if inst.sprite_index != inst.s_clown_damage:
						inst.alarm[2] = 30.0
			if other.object_index == A.obj_buzzybeetle or other.object_index == A.obj_spiny:
				for inst in GM.with_list(other):
					inst.inup = 0.0
			if other.object_index != A.obj_buzzybeetle and other.object_index != A.obj_spiny and other.object_index != A.obj_clown and other.object_index != A.obj_clown_fire:
				other.vspeed = (-(2.9 - (1.5 * swimming)))
			other.hspeed = -3.0
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			if other.object_index == A.obj_clown or other.object_index == A.obj_clown_fire:
				for inst in GM.with_list(other):
					if inst.sprite_index != inst.s_clown_damage:
						inst.alarm[2] = 30.0
			if other.object_index == A.obj_buzzybeetle or other.object_index == A.obj_spiny:
				for inst in GM.with_list(other):
					inst.inup = 0.0
			if other.object_index != A.obj_buzzybeetle and other.object_index != A.obj_spiny and other.object_index != A.obj_clown and other.object_index != A.obj_clown_fire:
				other.vspeed = -2.9
			other.hspeed = 3.0
			if other.object_index == A.obj_galoomba_hold or other.object_index == A.obj_bobomb_hold:
				other.direct = 1.0
			_user_1()


# from objects/obj_spring_land/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and other.held == 0.0:
		if other.sprite_index == A.spr_shell_inside:
			imagen = A.spr_shell
		elif other.sprite_index == A.spr_shell_red_inside:
			imagen = A.spr_shell_red
		else:
			imagen = other.sprite_index
		if place_meeting(x, y, A.obj_shell) and GM.eq(x, other.x):
			for inst in GM.with_list(GM.instance_create((other.x + 16.0), other.y, A.obj_shell_held)):
				inst.sprite_index = self.imagen
				inst.koopainside = 0.0
				inst.prevhspeed = 3.8
				inst.hspeed = 3.8
			for inst in GM.with_list(other):
				inst.instance_destroy()
			_user_1()
		elif collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_shell, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_shell_held)):
				inst.sprite_index = self.imagen
				inst.koopainside = 0.0
				inst.prevhspeed = -3.8
				inst.vspeed = (-(2.9 - (1.5 * self.swimming)))
				inst.hspeed = -3.8
			for inst in GM.with_list(other):
				inst.instance_destroy()
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_shell, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_shell_held)):
				inst.sprite_index = self.imagen
				inst.koopainside = 0.0
				inst.prevhspeed = 3.8
				inst.vspeed = (-(2.9 - (1.5 * self.swimming)))
				inst.hspeed = 3.8
			for inst in GM.with_list(other):
				inst.instance_destroy()
			_user_1()


# from objects/obj_spring_land/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			if G.apariencia != 2.0:
				other.fisica = 1.0
			other.hspeed = -3.0
			other.vspeed = (-((2.9 - (1.5 * swimming))))
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			if G.apariencia != 2.0:
				other.fisica = 1.0
			other.hspeed = 3.0
			other.vspeed = (-((2.9 - (1.5 * swimming))))
			_user_1()


# from objects/obj_spring_land/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			if G.apariencia == 1.0:
				other.fisica = 1.0
			other.hspeed = -3.0
			other.vspeed = (-(2.9 - (1.5 * swimming)))
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			if G.apariencia == 1.0:
				other.fisica = 1.0
			other.hspeed = 3.0
			other.vspeed = (-(2.9 - (1.5 * swimming)))
			_user_1()


# from objects/obj_spring_land/Collision_obj_spiny.gml
func _collision_obj_spiny(other: GMObject) -> void:
	if other.wings == 0.0:  # UNVERIFIED: obj_spiny 未移植（空壳）
		if collision_rectangle(bbox_left, bbox_top, (bbox_right - 4.0), bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			other.hspeed = -3.0
			if other.inup == 1.0:
				other.inup = 0.0
			else:
				other.vspeed = (-(2.9 - (1.5 * swimming)))
			_user_1()
		elif collision_rectangle((bbox_left - 4.0), bbox_top, bbox_right, bbox_top, A.obj_physicsparent, false, false) != null and (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			other.hspeed = 3.0
			if other.inup == 1.0:
				other.inup = 0.0
			else:
				other.vspeed = (-(2.9 - (1.5 * swimming)))
			_user_1()


# from objects/obj_spring_land/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_spring_land/Other_11.gml
func _user_1() -> void:
	image_speed = 0.5
	if Scr.outside_view(self) < 0.5:
		GM.audio_stop_sound(Scr.scr_snd_spring(self))
		GM.audio_play_sound(Scr.scr_snd_spring(self), 0.0, false)
