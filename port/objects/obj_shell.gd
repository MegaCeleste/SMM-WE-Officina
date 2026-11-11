extends "res://objects/obj_enemyparent_held.gd"

var koopainside = null
var sacudirse: float = 0.0
var rotacion: float = 0.0
var nomatar: float = 0.0
var wings: float = 0.0
var w_wings: float = 0.0
var key = null
var dead_h: float = 0.0
var apilar: float = 0.0
var flip = null
var isduckhold = null
var imdead = null
var imheld = null


# from objects/obj_shell/Create_0.gml
func _create() -> void:
	koopainside = 0.0
	super._create()
	direct = 1.0
	sacudirse = 0.0
	shake = 0.0
	rotacion = 0.0
	nomatar = 0.0
	wings = 0.0
	w_wings = 0.0
	key = 0.0
	swimming = 0.0
	dead_h = 0.0
	apilar = 0.0
	flip = 0.0
	kickme = 0.0
	alarm[1] = 1.0
	alarm[2] = 4.0


# from objects/obj_shell/Step_1.gml
func _step_begin() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if sacudirse == 1.0:
		if shake == 0.0:
			if rotacion > -10.0:
				rotacion -= 5.0
			else:
				shake = 1.0
		elif shake == 1.0:
			if rotacion < 10.0:
				rotacion += 5.0
			else:
				shake = 0.0
	if GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_speed = 0.0
			inst.set("direct", 1.0)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_speed = 0.0
			inst.set("direct", 1.0)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_speed = 0.0
			inst.set("direct", 1.0)
		instance_destroy()


# from objects/obj_shell/Alarm_1.gml
func _alarm_1() -> void:
	if sprite_height >= 19.0:
		mask_index = A.spr_shell_b
	else:
		mask_index = A.spr_shell


# from objects/obj_shell/Alarm_2.gml
func _alarm_2() -> void:
	kickme = 1.0


# from objects/obj_shell/Alarm_3.gml
func _alarm_3() -> void:
	sacudirse = 1.0
	match sprite_index:
		A.spr_SMB_shell:
			sprite_index = A.spr_SMB_shell_wakeup
			image_speed = 0.2
		A.spr_SMB_shell_red:
			sprite_index = A.spr_SMB_shell_red_wakeup
			image_speed = 0.2
		A.spr_SMB_shell_b:
			sprite_index = A.spr_SMB_shell_wakeup_b
			image_speed = 0.2
		A.spr_SMB_shell_red_b:
			sprite_index = A.spr_SMB_shell_red_wakeup_b
			image_speed = 0.2
		A.spr_SMB3_shell:
			sprite_index = A.spr_SMB3_shell_wakeup
			image_speed = 0.2
		A.spr_SMB3_shell_red:
			sprite_index = A.spr_SMB3_shell_red_wakeup
			image_speed = 0.2
		A.spr_SMB3_shell_b:
			sprite_index = A.spr_SMB3_shell_wakeup_b
			image_speed = 0.2
		A.spr_SMB3_shell_red_b:
			sprite_index = A.spr_SMB3_shell_red_wakeup_b
			image_speed = 0.2


# from objects/obj_shell/Alarm_4.gml
func _alarm_4() -> void:
	if GM.instance_exists(A.obj_player_warp):
		alarm[4] = 30.0
	else:
		shake = 0.0
		alarm[3] = -1.0
		if koopainside != 0.0:
			match koopainside:  # 各处赋的都是浮点数值
				-1.0:
					if sprite_index == A.spr_SMB_shell_buzzy or sprite_index == A.spr_SMB_shell_buzzy_night or sprite_index == A.spr_SMB3_shell_buzzy or sprite_index == A.spr_SMB3_shell_buzzy_night or sprite_index == A.spr_shell_buzzy or sprite_index == A.spr_NSMBU_shell_buzzy:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_buzzybeetle)):
							inst.set("direct", self.direct)
						instance_destroy()
					elif sprite_index == A.spr_SMB_shell_buzzy_b or sprite_index == A.spr_SMB_shell_buzzy_night_b or sprite_index == A.spr_SMB3_shell_buzzy_b or sprite_index == A.spr_SMB3_shell_buzzy_night_b or sprite_index == A.spr_shell_buzzy_b or sprite_index == A.spr_NSMBU_shell_buzzy_b:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_buzzybeetle_b)):
							inst.set("direct", self.direct)
						instance_destroy()
					elif sprite_index == A.spr_SMB_spiny_dead or sprite_index == A.spr_SMB3_spiny_dead or sprite_index == A.spr_spiny_dead or sprite_index == A.spr_NSMBU_spiny_dead:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_spiny)):
							inst.set("direct", self.direct)
						instance_destroy()
				1.0:
					if sprite_height > 16.0:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_beachkoopa_b)):
							inst.image_speed = 0.15
							inst.set("cankill", 1.0)
						sprite_index = A.spr_shell_b
					else:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_beachkoopa)):
							inst.image_speed = 0.15
							inst.set("cankill", 1.0)
						sprite_index = A.spr_shell
					alarm[5] = -1.0
					koopainside = 0.0
					sacudirse = 0.0
				2.0:
					if sprite_height > 16.0:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_beachkoopa_red_b)):
							inst.image_speed = 0.15
							inst.set("cankill", 1.0)
						sprite_index = A.spr_shell_red_b
					else:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_beachkoopa_red)):
							inst.image_speed = 0.15
							inst.set("cankill", 1.0)
						sprite_index = A.spr_shell_red
					alarm[5] = -1.0
					koopainside = 0.0
					sacudirse = 0.0
		else:
			if sprite_index == A.spr_SMB_shell_wakeup or sprite_index == A.spr_SMB3_shell_wakeup:
				GM.instance_create(x, y, A.obj_koopa)
				instance_destroy()
				return
			elif sprite_index == A.spr_SMB_shell_red_wakeup or sprite_index == A.spr_SMB3_shell_red_wakeup:
				GM.instance_create(x, y, A.obj_koopa_red)
				instance_destroy()
			if sprite_index == A.spr_SMB_shell_wakeup_b or sprite_index == A.spr_SMB3_shell_wakeup_b:
				GM.instance_create(x, y, A.obj_koopa_b)
				instance_destroy()
				return
			elif sprite_index == A.spr_SMB_shell_red_wakeup_b or sprite_index == A.spr_SMB3_shell_red_wakeup_b:
				GM.instance_create(x, y, A.obj_koopa_red_b)
				instance_destroy()
				return
			else:
				match sprite_index:
					A.spr_NSMBU_shell:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_koopa)):
							inst.sprite_index = A.spr_NSMBU_koopa_wakeup
							inst.set("direct", self.direct)
							inst.set("wake", 1.0)
					A.spr_NSMBU_shell_red:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_koopa_red)):
							inst.sprite_index = A.spr_NSMBU_koopa_red_wakeup
							inst.set("direct", self.direct)
							inst.set("wake", 1.0)
					A.spr_NSMBU_shell_b:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_koopa_b)):
							inst.sprite_index = A.spr_NSMBU_koopa_b_wakeup
							inst.set("direct", self.direct)
							inst.set("wake", 1.0)
					A.spr_NSMBU_shell_red_b:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_koopa_red_b)):
							inst.sprite_index = A.spr_NSMBU_koopa_red_b_wakeup
							inst.set("direct", self.direct)
							inst.set("wake", 1.0)
			instance_destroy()


# from objects/obj_shell/Alarm_5.gml
func _alarm_5() -> void:
	if image_index == 0.0:
		image_index = 1.0
		alarm[5] = 10.0
	else:
		image_index = 0.0
		alarm[5] = (120.0 + GM.random(GM.gm_round(120.0)))


# from objects/obj_shell/Alarm_6.gml
func _alarm_6() -> void:
	inmune = 0.0


# from objects/obj_shell/Alarm_7.gml
func _alarm_7() -> void:
	match sprite_index:
		A.spr_shell_inside:
			GM.instance_create(x, y, A.obj_koopa)
			instance_destroy()
		A.spr_shell_red_inside:
			GM.instance_create(x, y, A.obj_koopa_red)
			instance_destroy()
		A.spr_shell_inside_b:
			GM.instance_create(x, y, A.obj_koopa_b)
			instance_destroy()
		A.spr_shell_red_inside_b:
			GM.instance_create(x, y, A.obj_koopa_red_b)
			instance_destroy()


# from objects/obj_shell/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if kickme == 1.0 and inmune == 0.0 and (not GM.instance_exists(A.obj_invincibility)):
		if held == 0.0:
			if Scr.scr_canhold(self) > 0.5 and (inwall <= 0.5) and sprite_height <= 19.0:
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
			elif bbox_bottom < ((other.bbox_top - other.vspeed) + 5.0) and vspeed >= 0.0 and object_index == A.obj_shell_empty and (not GM.instance_exists(A.obj_helmet)) and G.apariencia != 3.0 and o.helmet == 0.0:
				GM.audio_play_sound(A.snd_helmet_add, 0.0, false)
				o.helmet = 1.0
				GM.instance_create(other.x, (other.y + 15.0), A.obj_helmet)
				instance_destroy()
			elif bbox_bottom < ((other.bbox_top - other.vspeed) + 5.0) and vspeed >= 0.0 and object_index == A.obj_spiny_empty and (not GM.instance_exists(A.obj_helmet)) and G.apariencia != 3.0 and o.helmet == 0.0:
				GM.audio_play_sound(A.snd_helmet_spiny_add, 0.0, false)
				for inst in GM.with_list(A.obj_mario):
					inst.helmet = 1.0
				GM.instance_create(other.x, (other.y + 15.0), A.obj_helmet_spiny)
				for inst in GM.with_list(GM.instance_create((i_mario.x - 4.0), (i_mario.y + 14.0), A.obj_smoke)):
					inst.sprite_index = A.spr_sparkles_helmet
				instance_destroy()
			elif inmune == 0.0:
				if G.apariencia == 3.0 and other.bbox_bottom < ((bbox_top - vspeed) + 14.0) and o.groundpount == 2.0:
					GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
					GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					if object_index == A.obj_bobomb_hold:
						if (i_mario.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
							hspeed = 4.2
							direct = 1.0
						elif (i_mario.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
							hspeed = -4.2
							direct = -1.0
						else:
							hspeed = 4.2
							direct = 1.0
					else:
						_user_0()
				elif (o.stompstyle == 1.0 or G.yoshi == 1.0) and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0:
					if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0:
						if object_index == A.obj_spiny_empty and G.apariencia > 1.0:
							var _o: GMObject = GM.other
							GM.other = self
							for inst in GM.with_list(other):
								inst.event_user(1)
							GM.other = _o
							GM.audio_stop_sound(Scr.scr_snd_stomp(self))
							GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
							GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
						else:
							var _o2: GMObject = GM.other
							GM.other = self
							for inst in GM.with_list(A.obj_mario):
								inst.event_user(1)
							GM.other = _o2
							if G.apariencia == 3.0:
								Scr.scr_NSMBU_spinstomp(self, other, self, 1.0)
							GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_spinsmoke)
							instance_destroy()
				elif G.yoshi == 2.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0:
					if object_index == A.obj_spiny_empty:
						var _o3: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o3
						if G.apariencia < 2.0:
							if GM.instance_exists(A.obj_kuribo_drybones):
								GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
							else:
								GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
						else:
							GM.audio_play_sound(A.snd_kick, 0.0, false)
						GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					else:
						var _o4: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(other):
							inst.event_user(1)
						GM.other = _o4
						GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
						GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
						_user_0()
				elif G.powerup == -80.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.y < (y - 29.0) and other.y > (y - 32.0):
					pass
				elif vspeed >= 0.0 or (vspeed >= 0.0 and G.yoshi > 0.0):
					if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and object_index == A.obj_spiny_empty and GM.instance_exists(A.obj_mario):
						var _o5: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(A.obj_mario):
							inst.event_user(0)
						GM.other = _o5
					else:
						GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
						if not GM.instance_exists(A.obj_smoke):
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
								inst.sprite_index = A.spr_spinthump
						var _o6: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(A.obj_mario):
							if inst.holding == 0.0 and G.apariencia != 0.0 and G.apariencia != 3.0:
								inst.event_user(7)
						GM.other = _o6
						alarm[5] = -1.0
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell_held)):
							match self.sprite_index:
								A.spr_shell_inside:
									inst.sprite_index = A.spr_shell
								A.spr_shell_red_inside:
									inst.sprite_index = A.spr_shell_red
								A.spr_shell_inside_b:
									inst.sprite_index = A.spr_shell_b
								A.spr_shell_red_inside_b:
									inst.sprite_index = A.spr_shell_red_b
								A.spr_SMB3_shell_wakeup:
									inst.sprite_index = A.spr_SMB3_shell
								A.spr_SMB3_shell_red_wakeup:
									inst.sprite_index = A.spr_SMB3_shell_red
								A.spr_SMB3_shell_wakeup_b:
									inst.sprite_index = A.spr_SMB3_shell_b
								A.spr_SMB3_shell_red_wakeup_b:
									inst.sprite_index = A.spr_SMB3_shell_red_b
								A.spr_SMB_shell_wakeup:
									inst.sprite_index = A.spr_SMB_shell
								A.spr_SMB_shell_red_wakeup:
									inst.sprite_index = A.spr_SMB_shell_red
								A.spr_SMB_shell_wakeup_b:
									inst.sprite_index = A.spr_SMB_shell_b
								A.spr_SMB_shell_red_wakeup_b:
									inst.sprite_index = A.spr_SMB_shell_red_b
								_:
									inst.sprite_index = self.sprite_index
							if GM.instance_exists(A.obj_mario):
								inst.set("koopainside", self.koopainside)
								if (not GM.instance_exists(A.obj_mario)) or i_mario.x < (inst.x + 8.0):
									if i_mario.hspeed == 0.0:
										inst.hspeed = 2.0
										inst.set("spd", 2.5)
									else:
										inst.hspeed = (2.0 + (i_mario.hspeed / 2.0))
										inst.set("spd", (2.2 + absf((i_mario.hspeed / 2.0))))
									inst.set("prevhspeed", inst.hspeed)
									if inst.get("spd") > 3.2:
										inst.set("spd", 3.2)
								else:
									if i_mario.hspeed == 0.0:
										inst.hspeed = -2.0
										inst.set("spd", -2.5)
									else:
										inst.hspeed = (-((2.0 + absf((i_mario.hspeed / 2.0)))))
										inst.set("spd", (-((2.2 + absf((i_mario.hspeed / 2.0))))))
									inst.set("prevhspeed", inst.hspeed)
									if inst.get("spd") < -3.2:
										inst.set("spd", -3.2)
								inst.vspeed = self.vspeed
							inst.set("hardness", self.hardness)
							inst.set("flip", self.flip)
							inst.set("inmune", 1.0)
							inst.alarm[2] = 12.0
						instance_destroy()


# from objects/obj_shell/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.set("girar", 1.0)
	match sprite_index:
		A.spr_SMB_shell:
			imdead.sprite_index = A.spr_SMB_shell_deads
		A.spr_SMB_shell_red:
			imdead.sprite_index = A.spr_SMB_shell_red_deads
		A.spr_SMB_shell_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB_shell_red_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB_shell_buzzy_night_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB_shell_buzzy:
			imdead.sprite_index = A.spr_SMB_shell_buzzy_deads
			imdead.image_index = 0.0
			imdead.image_speed = 0.0
		A.spr_SMB_shell_buzzy_night:
			imdead.sprite_index = A.spr_SMB_shell_buzzy_deads
			imdead.image_index = 1.0
			imdead.image_speed = 0.0
		A.spr_SMB_spiny_dead:
			imdead.sprite_index = A.spr_SMB_shell_spiny_deads
		A.spr_SMB_shell_empty:
			imdead.sprite_index = A.spr_SMB_shell_buzzy_empty_deads
		A.spr_SMB_shell_empty_night:
			imdead.sprite_index = A.spr_SMB_shell_buzzy_empty_night_deads
		A.spr_SMB_shell_empty_spiny:
			imdead.sprite_index = A.spr_SMB_shell_spiny_empty_deads
		A.spr_SMB3_shell:
			imdead.sprite_index = A.spr_SMB3_koopa_deads
		A.spr_SMB3_shell_red:
			imdead.sprite_index = A.spr_SMB3_koopa_red_deads
		A.spr_SMB3_shell_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB3_shell_red_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB3_spiny_dead:
			imdead.sprite_index = A.spr_SMB3_shell_spiny_deads
		A.spr_SMB3_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB3_shell_buzzy_night_b:
			imdead.sprite_index = sprite_index
		A.spr_SMB3_shell_buzzy:
			imdead.sprite_index = A.spr_SMB3_shell_buzzy_deads
			imdead.image_index = 0.0
			imdead.image_speed = 0.0
		A.spr_SMB3_shell_buzzy_night:
			imdead.sprite_index = A.spr_SMB3_shell_buzzy_deads
			imdead.image_index = 1.0
			imdead.image_speed = 0.0
		A.spr_SMB3_shell_empty:
			imdead.sprite_index = A.spr_SMB3_shell_buzzy_empty_deads
		A.spr_SMB3_shell_empty_night:
			imdead.sprite_index = A.spr_SMB3_shell_buzzy_empty_night_deads
		A.spr_SMB3_shell_spiny_empty:
			imdead.sprite_index = A.spr_SMB3_shell_spiny_empty_deads
		A.spr_shell:
			imdead.sprite_index = A.spr_shell_deads
		A.spr_shell_red:
			imdead.sprite_index = A.spr_shell_red_deads
		A.spr_shell_b:
			imdead.sprite_index = sprite_index
		A.spr_shell_red_b:
			imdead.sprite_index = sprite_index
		A.spr_shell_buzzy:
			imdead.sprite_index = A.spr_shell_buzzy_deads
		A.spr_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_spiny_dead:
			imdead.sprite_index = A.spr_shell_spiny_deads
		A.spr_shell_buzzy_empty:
			imdead.sprite_index = A.spr_buzzy_empty_deads
		A.spr_shell_spiny_empty:
			imdead.sprite_index = A.spr_spiny_empty_deads
		A.spr_NSMBU_shell:
			imdead.sprite_index = A.spr_NSMBU_shell_deads
		A.spr_NSMBU_shell_red:
			imdead.sprite_index = A.spr_NSMBU_shell_red_deads
		A.spr_NSMBU_shell_b:
			imdead.sprite_index = sprite_index
		A.spr_NSMBU_shell_red_b:
			imdead.sprite_index = sprite_index
		A.spr_NSMBU_spiny_dead:
			imdead.sprite_index = A.spr_NSMBU_shell_spiny_deads
		A.spr_NSMBU_shell_buzzy:
			imdead.sprite_index = A.spr_NSMBU_shell_buzzy_deads
		A.spr_NSMBU_shell_buzzy_b:
			imdead.sprite_index = sprite_index
		A.spr_NSMBU_shell_buzzy_empty:
			imdead.sprite_index = A.spr_NSMBU_shell_buzzy_empty_deads
		A.spr_NSMBU_shell_spiny_empty:
			imdead.sprite_index = A.spr_NSMBU_shell_spiny_empty_deads
		_:
			imdead.sprite_index = A.spr_shell_deads
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
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


# from objects/obj_shell/Other_12.gml
func _user_2() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var lugar  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.keyboard_check(G.abajo):
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null:
			inwall = 1.0
			hspeed = 0.0
		if i_mario.vspeed != 0.0:
			vspeed = 0.3
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
		vspeed = (-((6.125 - (3.5 * swimming))))
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
		for inst in GM.with_list(GM.instance_create(lugar, (y + 1.0), A.obj_shell_held)):
			inst.vspeed = 0.1
			match self.sprite_index:
				A.spr_shell_inside:
					inst.sprite_index = A.spr_shell
				A.spr_shell_red_inside:
					inst.sprite_index = A.spr_shell_red
				A.spr_SMB3_shell_wakeup:
					inst.sprite_index = A.spr_SMB3_shell
				A.spr_SMB3_shell_red_wakeup:
					inst.sprite_index = A.spr_SMB3_shell_red
				A.spr_SMB_shell_wakeup:
					inst.sprite_index = A.spr_SMB_shell
				A.spr_SMB_shell_red_wakeup:
					inst.sprite_index = A.spr_SMB_shell_red
				_:
					inst.sprite_index = self.sprite_index
			inst.set("koopainside", self.koopainside)
			if i_mario.hspeed == 0.0:
				inst.hspeed = 2.0
				inst.set("spd", 2.5)
			else:
				inst.hspeed = (2.2 + absf((i_mario.hspeed / 2.0)))
				inst.set("spd", (2.2 + absf((i_mario.hspeed / 2.0))))
			inst.set("prevhspeed", inst.hspeed)
			if inst.get("spd") > 3.2:
				inst.set("spd", 3.2)
			inst.hspeed *= GM.gm_sign(i_mario.direct)
			inst.set("prevhspeed", inst.get("prevhspeed") * GM.gm_sign(i_mario.direct))
			inst.set("spd", inst.get("spd") * GM.gm_sign(i_mario.direct))
			inst.set("hardness", self.hardness)
			inst.set("flip", self.flip)
			inst.set("inmune", 1.0)
			inst.alarm[2] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
		instance_destroy()


# from objects/obj_shell/Other_17.gml
func _user_7() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_shell)
	imheld.sprite_index = sprite_index
	imheld.flip = 1.0
	if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = -0.5
	if G.apariencia == 2.0:
		if koopainside != 0.0:
			imheld.koopainside = koopainside
			imheld.alarm[3] = 540.0
			imheld.alarm[4] = 600.0
	else:
		imheld.koopainside = koopainside
		imheld.alarm[3] = 540.0
		imheld.alarm[4] = 600.0
	instance_destroy()


# from objects/obj_shell/Draw_0.gml
func _gm_draw() -> void:
	if sprite_height < 20.0:
		if flip == 0.0:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, rotacion, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (y + 17.0), direct, -1.0, rotacion, GM.c_white, image_alpha)
	elif flip == 0.0:
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, rotacion, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, -1.0, rotacion, GM.c_white, image_alpha)
