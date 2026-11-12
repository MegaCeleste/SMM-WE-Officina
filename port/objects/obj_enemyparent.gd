extends "res://objects/obj_physicsparent.gd"

var hardness = null
var stomp = null
var innave = null
var dead_h = null
var modo_lava = null
var apilar = null
var wings = null
var key = null
var si = null
var mytopid = null
var imdead = null
var claw = null
var boo_huida = null
var can_wings_deads = null  # 第 4 批补：由别的 object 写入


# from objects/obj_enemyparent/Create_0.gml
func _create() -> void:
	for inst in GM.with_list(A.obj_enemyparent):
		inst.hardness = 0.0
		inst.stomp = 0.0
		inst.innave = 0.0
		inst.dead_h = 0.0
		inst.modo_lava = 0.0
		inst.swimming = 0.0
		inst.apilar = 0.0
		inst.direct = -1.0
		inst.wings = 0.0
		inst.paracaidas = 0.0
		inst.key = 0.0


# from objects/obj_enemyparent/Step_1.gml
func _step_begin() -> void:
	var solid_dead = collision_rectangle(x, (bbox_top + 2.0), x, (bbox_top + 2.0), A.obj_solid, true, false)
	var solidtop_dead = collision_rectangle((bbox_left + 3.0), bbox_bottom, (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_solidtop, false, false)
	var pinchos_dead = collision_rectangle((bbox_left + 3.0), bbox_bottom, (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_pinchos, false, false)
	var solid_right = collision_rectangle((x + 6.0), (bbox_top + 2.0), (x + 6.0), (y + 30.0), A.obj_solid, true, false)
	var solid_left = collision_rectangle((x - 6.0), (bbox_top + 2.0), (x - 6.0), (y + 30.0), A.obj_solid, true, false)
	var bullet_right = collision_rectangle((x + 6.0), (bbox_top + 2.0), (x + 6.0), (y + 30.0), A.obj_bullebill_base, true, false)
	var bullet_left = collision_rectangle((x - 6.0), (bbox_top + 2.0), (x - 6.0), (y + 30.0), A.obj_bullebill_base, true, false)
	var muncher_right = collision_rectangle((x + 6.0), (bbox_top + 2.0), (x + 6.0), (y + 30.0), A.obj_muncher, true, false)
	var muncher_left = collision_rectangle((x - 6.0), (bbox_top + 2.0), (x - 6.0), (y + 30.0), A.obj_muncher, true, false)
	var pinchos_right = collision_rectangle((x + 6.0), (bbox_top + 2.0), (x + 6.0), (y + 30.0), A.obj_pinchos, true, false)
	var pinchos_left = collision_rectangle((x - 6.0), (bbox_top + 2.0), (x - 6.0), (y + 30.0), A.obj_pinchos, true, false)
	var cannon_right = collision_rectangle((x + 6.0), (bbox_top + 2.0), (x + 6.0), (y + 30.0), A.obj_cannon, true, false)
	var cannon_left = collision_rectangle((x - 6.0), (bbox_top + 2.0), (x - 6.0), (y + 30.0), A.obj_cannon, true, false)
	var oneway_right = collision_rectangle((x + 5.0), (bbox_top + 2.0), (x + 6.0), (y + 30.0), A.obj_onewaygate_left, true, false)
	var oneway_left = collision_rectangle((x - 5.0), (bbox_top + 2.0), (x - 6.0), (y + 30.0), A.obj_onewaygate_right, true, false)
	if solid_dead != null and solid_dead.vspeed > 0.0 and solid_dead.y < (y + 16.0) and vspeed == 0.0 and gravity == 0.0 and (solidtop_dead != null or pinchos_dead != null):
		if object_index == A.obj_bobomb or object_index == A.obj_bobomb_ready:
			GM.instance_create(x, y, A.obj_explosion)
			instance_destroy()
		else:
			_user_0()  # UNSURE: Step 事件里 other 的值（_user_0 读 other.hspeed 等），此时 GM.other 为 null
	elif (solid_right != null or bullet_right != null or muncher_right != null or pinchos_right != null or cannon_right != null or oneway_right != null) and ((solid_left != null and solid_left.hspeed > 0.0) or (muncher_left != null and muncher_left.hspeed > 0.0) or (cannon_left != null and cannon_left.hspeed > 0.0)):
		if object_index == A.obj_bobomb or object_index == A.obj_bobomb_ready:
			GM.instance_create(x, y, A.obj_explosion)
			instance_destroy()
		else:
			_user_0()  # UNSURE: Step 事件里 other 的值（_user_0 读 other.hspeed 等），此时 GM.other 为 null
	elif (solid_left != null or bullet_left != null or muncher_left != null or pinchos_left != null or cannon_left != null or oneway_left != null) and ((solid_right != null and solid_right.hspeed < 0.0) or (muncher_right != null and muncher_right.hspeed < 0.0) or (cannon_right != null and cannon_right.hspeed < 0.0)):
		if object_index == A.obj_bobomb or object_index == A.obj_bobomb_ready:
			GM.instance_create(x, y, A.obj_explosion)
			instance_destroy()
		else:
			_user_0()  # UNSURE: Step 事件里 other 的值（_user_0 读 other.hspeed 等），此时 GM.other 为 null
	if GM.instance_exists(A.obj_mario) and G.powerup == -80.0 and stomp != 1.0 and stomp != 2.0 and stomp != 5.0:
		var mario = GM.instance_find(A.obj_mario, 0)
		var check = collision_rectangle(mario.bbox_left, (mario.bbox_bottom - 1.0), mario.bbox_right, (mario.bbox_bottom + 1.0), A.obj_solidtop, false, false)
		var check_pinchos = collision_rectangle(mario.bbox_left, (mario.bbox_bottom - 1.0), mario.bbox_right, (mario.bbox_bottom + 1.0), A.obj_pinchos, false, false)
		var check_solid = collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, mario.bbox_top, A.obj_solid, true, false)
		var check_oneway = collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, mario.bbox_top, A.obj_onewaygate_bottom, true, false)
		var check_cannon = collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, mario.bbox_top, A.obj_cannon, true, false)
		var check_bullet = collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, mario.bbox_top, A.obj_bullebill_base, true, false)
		var check_muncher = collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, mario.bbox_top, A.obj_muncher, true, false)
		var check_pinchos2 = collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, mario.bbox_top, A.obj_pinchos, true, false)
		if (((check != null and check != self) or check_pinchos != null) and vspeed >= 0.0) or (((check != null and check != self) or check_pinchos != null) and vspeed < 0.0 and y > (mario.y + 32.0)) or ((check_solid != null or check_oneway != null or check_cannon != null or check_bullet != null or check_muncher != null or check_pinchos2 != null) and vspeed < 0.0):
			for inst in GM.with_list(A.obj_mario):
				inst.inclown = 0.0
			return
		if collision_rectangle(bbox_left, (bbox_top - 8.0), bbox_right, (bbox_top + 7.0), A.obj_mario, false, false) != null and mario.state < 2.0 and speed != 0.0:
			if (check == null) or check.y > y or check.y == y:
				for inst in GM.with_list(A.obj_mario):
					inst.y = ceilf(bbox_top - 31.0)
				if (hspeed > 0.0 and (collision_rectangle((mario.bbox_right + hspeed), mario.bbox_top, (mario.bbox_right + hspeed), (mario.bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((mario.bbox_left + hspeed), mario.bbox_top, (mario.bbox_left + hspeed), (mario.bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
					for inst in GM.with_list(A.obj_mario):
						inst.x += hspeed


# from objects/obj_enemyparent/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0)) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	_user_2()
	_user_3()
	_user_4()
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and object_index != A.obj_grinder and object_index != A.obj_thwomp and object_index != A.obj_podoboo and object_index != A.obj_cheepcheep and object_index != A.obj_boo and object_index != A.obj_bobomb and object_index != A.obj_bobomb_ready and object_index != A.obj_pokey:
		if G.bg_level == "castle":
			if G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
				inst.sprite_index = self.sprite_index
				inst.set("direct", self.direct)
			instance_destroy()
		elif G.bg_level == "forest" and G.modo_noche == 1.0:
			if G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
				inst.sprite_index = self.sprite_index
				inst.set("direct", self.direct)
			instance_destroy()
		elif G.bg_level == "mountain" and G.modo_noche == 1.0:
			if G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
				inst.sprite_index = self.sprite_index
				inst.set("direct", self.direct)
			instance_destroy()


# from objects/obj_enemyparent/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			hspeed = (0.3 * direct)
		else:
			hspeed = (0.5 * direct)


# from objects/obj_enemyparent/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0) and vspeed >= 0.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		if object_index == A.obj_galoomba or object_index == A.obj_galoomba2 or object_index == A.obj_koopa or object_index == A.obj_koopa_red or object_index == A.obj_koopa_b or object_index == A.obj_koopa_red_b or object_index == A.obj_buzzybeetle or object_index == A.obj_buzzybeetle_b or object_index == A.obj_spiny or object_index == A.obj_shell_held or object_index == A.obj_bobomb or object_index == A.obj_bobomb_ready:
			_user_5()
		else:
			_user_0()
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
	elif other.vspeed > 0.0 and bbox_top > (other.y + 15.0) and vspeed == 0.0 and gravity == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		_user_0()
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_enemyparent/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	var o = other
	var obj_mario_inst = GM.instance_find(A.obj_mario, 0)
	var altura  # 局部变量提升（GML 的 var 是函数作用域）
	var v_speed  # 局部变量提升（GML 的 var 是函数作用域）
	if stomp != -1.0 and o.invincible != -1.0 and (not GM.instance_exists(A.obj_slider)):
		if sprite_index == A.spr_shell_buzzy_empty or sprite_index == A.spr_shell_spiny_empty or sprite_index == A.spr_SMB3_shell_empty or sprite_index == A.spr_SMB3_shell_empty_night or sprite_index == A.spr_SMB3_shell_spiny_empty or sprite_index == A.spr_SMB_shell_empty or sprite_index == A.spr_SMB_shell_empty_spiny:
			altura = 12.0
			v_speed = vspeed
		elif object_index == A.obj_shell_held:
			altura = 15.0
			v_speed = 0.0
		else:
			altura = 5.0
			v_speed = vspeed
		if G.apariencia == 3.0 and other.bbox_bottom < ((bbox_top - vspeed) + 14.0) and (stomp == 0.0 or stomp == 3.0) and (o.groundpount == 2.0 or o.helice_fly == 4.0):
			Scr.scr_musicalscale(self, other, self, 1.0)
			GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
			_user_0()
		elif other.bbox_bottom < ((bbox_top - vspeed) + altura) and object_index != A.obj_grinder and object_index != A.obj_crumblebones and object_index != A.obj_thwomp and G.yoshi == 2.0:
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _o
			if GM.instance_exists(A.obj_kuribo_drybones):
				Scr.scr_musicalscale_kick(self, other, self, 1.0)
			else:
				Scr.scr_musicalscale(self, other, self, 1.0)
			GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
			_user_0()
		elif other.bbox_bottom < ((bbox_top - vspeed) + altura) and hardness < 99.0 and stomp != 1.0 and G.powerup == -77.0:
			if object_index == A.obj_shell_held and sprite_index == A.spr_SMB_shell_empty_spiny:
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(0)
				GM.other = _o
			else:
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(1)
				GM.other = _o
				Scr.scr_musicalscale(self, other, self, 1.0)
				GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
				_user_0()
		elif other.bbox_bottom < ((bbox_top - v_speed) + altura):
			if stomp != 3.0 and stomp != 5.0 and stomp != 6.0 and (o.stompstyle == 1.0 or G.yoshi == 1.0 or G.yoshi == 2.0):
				if stomp == 0.0 or stomp == 4.0:
					if object_index == A.obj_bobomb or object_index == A.obj_bobomb_ready:
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o
						GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
						GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
						GM.other = self
						for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_bobomb_hold)):
							inst.set("hitpoint", 1.0)
							inst.event_user(1)
						GM.other = _o
						instance_destroy()
					elif object_index == A.obj_shell_held and (sprite_index == A.spr_shell_spiny_empty or sprite_index == A.spr_NSMBU_shell_spiny_empty or sprite_index == A.spr_SMB3_shell_spiny_empty or sprite_index == A.spr_SMB_shell_empty_spiny):
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o
						GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
						GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					elif object_index == A.obj_charginchuck:
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o
						GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
						_user_1()
					elif object_index == A.obj_charginchuck or object_index == A.obj_cannonball or object_index == A.obj_cannonball_red or object_index == A.obj_NSMBU_charginchuck:
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o
						GM.audio_stop_sound(Scr.scr_snd_stomp(self))
						GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
						GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
						_user_1()
					else:
						if GM.variable_instance_exists(object_index, "key") and key == 1.0:
							for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
								inst.vspeed = -4.0
						if G.apariencia == 3.0:
							Scr.scr_NSMBU_spinstomp(self, other, self, 1.0)
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o
						GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_spinsmoke)
						instance_destroy()
				elif object_index == A.obj_boo or object_index == A.obj_podoboo or object_index == A.obj_podoboo_b or object_index == A.obj_angrysun:
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(0)
					GM.other = _o
				elif stomp == 1.0 and object_index == A.obj_pokey and image_index == 0.0 and G.bg_level == "snow":
					GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(1)
					GM.other = _o
					GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					_user_1()
				else:
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(1)
					GM.other = _o
					GM.audio_stop_sound(Scr.scr_snd_stomp(self))
					GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
					GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
			elif G.powerup != -80.0 and (stomp == 0.0 or stomp == 3.0 or stomp == 5.0):
				match object_index:
					A.obj_buzzybeetle:
						var _oi = GM.instance_find(object_index, 0)  # UNSURE: object_index.wings 按 §3.3 第 16 条取该 object 的第一个实例（不一定是 self）
						if _oi.wings == 0.0:
							si = 1.0
						else:
							si = 0.0
					A.obj_buzzybeetle_b:
						var _oi2 = GM.instance_find(object_index, 0)  # UNSURE: 同上
						if _oi2.wings == 0.0:
							si = 1.0
						else:
							si = 0.0
					A.obj_shell_held:
						var _oi3 = GM.instance_find(object_index, 0)  # UNSURE: 同上（object_index.mytopid）
						if _oi3.mytopid == A.obj_lighting:
							si = 1.0
						else:
							si = 0.0
					_:
						si = 1.0
				if si == 1.0:
					if object_index == A.obj_shell_held and (sprite_index == A.spr_SMB_shell_empty_spiny or sprite_index == A.spr_SMB3_shell_spiny_empty or sprite_index == A.spr_shell_spiny_empty or sprite_index == A.spr_NSMBU_shell_spiny_empty):
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(0)
						GM.other = _o
						return
					if vspeed < 0.0:
						y = yprevious
						if other.vspeed > 0.0:
							other.y = other.yprevious
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(1)
					GM.other = _o
					if stomp == 0.0 or stomp == 3.0:
						if G.apariencia == 3.0:
							if GM.keyboard_check(G.saltar) or GM.keyboard_check(G.saltar_spin):
								Scr.scr_NSMBU_musicalscale_rebote(self, other, self, 1.0)
							else:
								Scr.scr_NSMBU_musicalscale_minirebote(self, other, self, 1.0)
						elif GM.instance_exists(A.obj_mario):
							Scr.scr_musicalscale(self, other, self, 1.0)
					for inst in GM.with_list(GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)):
						if G.apariencia == 3.0:
							inst.sprite_index = A.spr_NSMBU_effect_stomp
					if G.yoshi == 2.0:
						_user_0()
					else:
						_user_1()
			elif stomp == 1.0 and object_index == A.obj_pokey and image_index == 0.0 and G.bg_level == "snow" and G.powerup != -80.0:
				GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(1)
				GM.other = _o
				GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
				_user_1()
		elif bbox_bottom < ((other.bbox_top - other.vspeed) + 3.0) and vspeed > 0.0 and obj_mario_inst.helmet == 1.0:
			return
		elif object_index == A.obj_shell_held and mytopid != A.obj_lighting and mytopid != A.obj_rainmaker and other.y < (y - 29.0) and other.y > (y - 32.0):
			return
		else:
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_enemyparent/Other_10.gml
func _user_0() -> void:
	# / @description Default enemy death script
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	imdead.direct = direct
	if GM.other.hspeed == 0.0:
		# ORIG-BUG: 括号位置错（bbox_left + bbox_right / 2），照搬
		if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_enemyparent/Other_11.gml
func _user_1() -> void:
	return


# from objects/obj_enemyparent/Other_12.gml
func _user_2() -> void:
	var hs_normal  # 局部变量提升（GML 的 var 是函数作用域）
	var hs_water  # 局部变量提升（GML 的 var 是函数作用域）
	var overlap = collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 4.0), A.obj_enemyparent, false, true)
	if overlap != null and overlap.visible == true and overlap.object_index != A.obj_grinder and overlap.object_index != A.obj_angrysun and overlap.object_index != A.obj_banzaibill and overlap.object_index != A.obj_bulletbill and overlap.object_index != A.obj_cannonball and overlap.object_index != A.obj_cannonball_red and overlap.object_index != A.obj_boo and overlap.object_index != A.obj_podoboo and overlap.object_index != A.obj_lakitu:
		if ((bbox_left + bbox_right) * 0.5) > ((overlap.bbox_left + overlap.bbox_right) * 0.5) or (((bbox_left + bbox_right) * 0.5) == ((overlap.bbox_left + overlap.bbox_right) * 0.5) and _uid > overlap._uid):  # UNSURE: GML 的 id > overlap.id（实例 id 比较），用创建序号 _uid 代替
			hspeed = absf(hspeed)
		else:
			hspeed = (-absf(hspeed))
	var overlap2 = collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, true)
	if overlap2 != null and overlap2.inmune == 0.0:
		if ((bbox_left + bbox_right) * 0.5) > ((overlap2.bbox_left + overlap2.bbox_right) * 0.5) or (((bbox_left + bbox_right) * 0.5) == ((overlap2.bbox_left + overlap2.bbox_right) * 0.5) and _uid > overlap2._uid):  # UNSURE: GML 的 id > overlap.id（实例 id 比较），用创建序号 _uid 代替
			hspeed = absf(hspeed)
		else:
			hspeed = (-absf(hspeed))
	match object_index:
		A.obj_monty_chase:
			hs_water = 0.6
			hs_normal = 1.5
		A.obj_chain_chomp_free:
			hs_water = 0.5
			hs_normal = 1.0
		A.obj_chain_chomp_free_b:
			hs_water = 0.5
			hs_normal = 1.0
		A.obj_egg:
			hs_water = 0.5
			hs_normal = 1.0
		A.obj_egg_red:
			hs_water = 0.5
			hs_normal = 1.0
		_:
			hs_water = 0.3
			hs_normal = 0.5
	if object_index != A.obj_grinder:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			if direct == 1.0 and hspeed > hs_water:
				hspeed -= 0.08
				if hspeed <= hs_water:
					hspeed = hs_water
			elif direct == -1.0 and hspeed < (-hs_water):
				hspeed += 0.08
				if hspeed >= (-hs_water):
					hspeed = (-hs_water)
		elif direct == 1.0 and hspeed > hs_normal:
			hspeed -= 0.08
			if hspeed <= hs_normal:
				hspeed = hs_normal
		elif direct == -1.0 and hspeed < (-hs_normal):
			hspeed += 0.08
			if hspeed >= (-hs_normal):
				hspeed = (-hs_normal)


# from objects/obj_enemyparent/Other_15.gml
func _user_5() -> void:
	_user_0()


# from objects/obj_enemyparent/Other_16.gml
func _user_6() -> void:
	if (gravity == 0.0) and collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 5.0, A.obj_slopeparent, true, false) == null:
		if hspeed < 0.0:
			if (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null):
				hspeed = (-hspeed)
		elif hspeed > 0.0:
			if (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null):
				hspeed = (-hspeed)
