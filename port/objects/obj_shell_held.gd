extends "res://objects/obj_enemyparent.gd"

var koopainside = null
var edible: float = 0.0
var fall: float = 0.0
var midair: float = 0.0
var s_dry: float = 0.0
var prevhspeed: float = 0.0
var prevvspeed: float = 0.0
var harmplayer: float = 0.0
var flip = null
var shell_drop: float = 0.0
var inmune: float = 0.0
var spd: float = 0.0
var imheld = null


# from objects/obj_shell_held/Create_0.gml
func _create() -> void:
	koopainside = 0.0
	hardness = 0.0
	stomp = 0.0
	edible = 1.0
	fall = 0.0
	midair = 0.0
	s_dry = A.spr_drybones_deads
	direct = -1.0
	prevhspeed = 0.0
	prevvspeed = 0.0
	harmplayer = 0.0
	swimming = 0.0
	dead_h = 0.0
	key = 0.0
	apilar = 0.0
	flip = 0.0
	shell_drop = 0.0
	mytopid = A.obj_lighting
	inmune = 0.0
	spd = 2.5
	if G.apariencia == 3.0:
		image_speed = 0.25
	else:
		image_speed = 0.2
	alarm[10] = 4.0
	if G.apariencia == 3.0:
		alarm[11] = 2.0


# from objects/obj_shell_held/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(mytopid, A.obj_lighting) and not GM.veq(mytopid, A.obj_rainmaker) and GM.instance_exists(mytopid):
		for inst in GM.with_list(mytopid):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_shell_trail):
		for inst in GM.with_list(A.obj_shell_trail):
			inst.instance_destroy()


# from objects/obj_shell_held/Step_1.gml
func _step_begin() -> void:
	pass


# from objects/obj_shell_held/Step_0.gml
func _step() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var check
	var check_2
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y >= (i_lava_water.y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if hspeed > 0.0 and hspeed < spd:
		hspeed += 0.05
		if hspeed >= spd:
			hspeed = spd
	elif hspeed < 0.0 and hspeed > (-spd):
		hspeed -= 0.05
		if hspeed <= (-spd):
			hspeed = (-spd)
	if fall == 0.0 and vspeed == 0.0 and gravity == 0.0 and GM.instance_exists(A.obj_mario):
		if (collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, true, false) == null) and (collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, true, false) == null):
			move_snap(4.0, 2.0)
			y += 4.0
			fall = 1.0
	elif fall == 1.0 and gravity == 0.0:
		fall = 0.0
	prevhspeed = hspeed
	prevvspeed = vspeed
	_user_3()
	if not GM.instance_exists(A.obj_deadmario):
		_user_4()
	else:
		gravity = 0.0
		speed = 0.0
	if hspeed != prevhspeed:
		if Scr.outside_view(self) <= 0.5:
			GM.audio_stop_sound(Scr.scr_snd_bump(self))
			GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		hardness = 100.0
		alarm[0] = 2.0
		GM.instance_create(x, y, A.obj_blockbumper)
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_index = self.image_index
			inst.image_speed = 0.0
			inst.set("direct", 1.0)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_index = self.image_index
			inst.image_speed = 0.0
			inst.set("direct", 1.0)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_index = self.image_index
			inst.image_speed = 0.0
			inst.set("direct", 1.0)
		instance_destroy()
	if GM.veq(mytopid, A.obj_lighting):
		return
	if not GM.veq(mytopid, A.obj_lighting) and not GM.veq(mytopid, A.obj_rainmaker) and GM.instance_exists(mytopid) and GM.instance_exists(A.obj_mario):
		mytopid.x = x
		mytopid.y = y
		check = collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom - 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_solidtop, false, false)
		check_2 = collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom - 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_physicssolid, false, false)
		if (check != null and check != mytopid) or check_2 != null:
			return
		if collision_rectangle(bbox_left, (bbox_top - 8.0), bbox_right, (bbox_top + 7.0), A.obj_mario, false, false) != null and i_mario.y < (y - 28.0) and i_mario.state < 2.0:
			if vspeed == 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.y = ceilf((bbox_top - 32.0))
			else:
				for inst in GM.with_list(A.obj_mario):
					inst.y = ceilf((bbox_top - (32.0 - vspeed)))
			if (hspeed > 0.0 and (collision_rectangle((i_mario.bbox_right + hspeed), i_mario.bbox_top, (i_mario.bbox_right + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((i_mario.bbox_left + hspeed), i_mario.bbox_top, (i_mario.bbox_left + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle((i_mario.bbox_right + hspeed), i_mario.bbox_top, (i_mario.bbox_right + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((i_mario.bbox_left + hspeed), i_mario.bbox_top, (i_mario.bbox_left + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle((i_mario.bbox_right + hspeed), i_mario.bbox_top, (i_mario.bbox_right + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((i_mario.bbox_left + hspeed), i_mario.bbox_top, (i_mario.bbox_left + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle((i_mario.bbox_right + hspeed), i_mario.bbox_top, (i_mario.bbox_right + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((i_mario.bbox_left + hspeed), i_mario.bbox_top, (i_mario.bbox_left + hspeed), (i_mario.bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
				for inst in GM.with_list(A.obj_mario):
					inst.x += hspeed


# from objects/obj_shell_held/Alarm_0.gml
func _alarm_0() -> void:
	if (collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom + 8.0), A.obj_blockbumper, false, false) == null) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_blockparent, false, false) == null):
		if sprite_index == A.spr_SMB_shell_buzzy or sprite_index == A.spr_SMB_shell_buzzy_night or sprite_index == A.spr_SMB3_shell_buzzy or sprite_index == A.spr_SMB3_shell_buzzy_night or sprite_index == A.spr_shell_buzzy or sprite_index == A.spr_NSMBU_shell_buzzy:
			hardness = 1.0
		else:
			hardness = 0.0
	else:
		alarm[0] = 1.0


# from objects/obj_shell_held/Alarm_1.gml
func _alarm_1() -> void:
	if swimming == 1.0:
		if hspeed > 0.0:
			prevhspeed = 1.5
			hspeed = 1.5
		elif hspeed < 0.0:
			prevhspeed = -1.5
			hspeed = -1.5
	elif hspeed > 0.0:
		prevhspeed = 3.3
		hspeed = 3.3
	elif hspeed < 0.0:
		prevhspeed = -3.3
		hspeed = -3.3


# from objects/obj_shell_held/Alarm_2.gml
func _alarm_2() -> void:
	inmune = 0.0


# from objects/obj_shell_held/Alarm_10.gml
func _alarm_10() -> void:
	if GM.veq(mytopid, A.obj_rainmaker) and sprite_index != A.spr_SMB_shell_empty_spiny and sprite_index != A.spr_shell_spiny_empty and sprite_index != A.spr_SMB3_shell_spiny_empty:
		mytopid = GM.instance_create(x, y, A.obj_solidtop)


# from objects/obj_shell_held/Alarm_11.gml
func _alarm_11() -> void:
	for inst in GM.with_list(GM.instance_create_depth(x, y, -1.0, A.obj_shell_trail)):
		inst.set("value", 1.0)
		inst.sprite_index = self.sprite_index
	alarm[11] = 2.0


# from objects/obj_shell_held/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if hspeed != 0.0 and GM.instance_exists(self) and o.hardness < 99.0:
		if GM.instance_exists(A.obj_mario):
			match G.apariencia:
				0.0:
					Scr.scr_musicalscale_SMB3(self, i_mario, other, 1.0)
				1.0:
					Scr.scr_musicalscale_SMB3(self, i_mario, other, 1.0)
				2.0:
					Scr.scr_musicalscale(self, i_mario, other, 1.0)
				3.0:
					Scr.scr_musicalscale_kick(self, i_mario, other, 1.0)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
	if other.object_index == A.obj_shell_held:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2
		_user_0()
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_score)):
			inst.event_user(5)
		GM.other = _o3


# from objects/obj_shell_held/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if bbox_bottom < ((other.bbox_top - other.vspeed) + 5.0) and vspeed > 0.0 and G.apariencia != 3.0 and o.helmet == 0.0 and (sprite_index == A.spr_shell_buzzy_empty or sprite_index == A.spr_SMB3_shell_empty or sprite_index == A.spr_SMB3_shell_empty_night or sprite_index == A.spr_SMB_shell_empty or sprite_index == A.spr_SMB_shell_empty_night):
		GM.audio_play_sound(A.snd_helmet_add, 0.0, false)
		for inst in GM.with_list(A.obj_mario):
			inst.helmet = 1.0
		GM.instance_create(i_mario.x, (i_mario.y + 15.0), A.obj_helmet)
		instance_destroy()
	elif bbox_bottom < ((other.bbox_top - other.vspeed) + 5.0) and vspeed > 0.0 and G.apariencia != 3.0 and o.helmet == 0.0 and (sprite_index == A.spr_SMB_shell_empty_spiny or sprite_index == A.spr_SMB3_shell_spiny_empty or sprite_index == A.spr_shell_spiny_empty):
		GM.audio_play_sound(A.snd_helmet_spiny_add, 0.0, false)
		for inst in GM.with_list(A.obj_mario):
			inst.helmet = 1.0
		GM.instance_create(i_mario.x, (i_mario.y + 15.0), A.obj_helmet_spiny)
		for inst in GM.with_list(GM.instance_create((i_mario.x - 4.0), (i_mario.y + 14.0), A.obj_smoke)):
			inst.sprite_index = A.spr_sparkles_helmet
		instance_destroy()
	elif inmune == 0.0:
		super._collision_obj_mario(other)


# from objects/obj_shell_held/Other_10.gml
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


# from objects/obj_shell_held/Other_11.gml
func _user_1() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if sprite_index == A.spr_SMB_shell_empty_spiny or sprite_index == A.spr_SMB3_shell_spiny_empty or sprite_index == A.spr_shell_spiny_empty:
		if i_mario.stompstyle == 1.0:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.other):  # UNSURE: Step 事件里的 other.id，原版意图疑为 obj_mario；按字面取 GM.other
				inst.event_user(1)
			GM.other = _o
			GM.audio_play_sound(A.snd_stomp, 0.0, false)
			GM.instance_create(GM.other.x, (GM.other.y + 22.0), A.obj_spinthump)
		else:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_mario):
				inst.event_user(0)
			GM.other = _o2
	elif GM.veq(mytopid, A.obj_lighting):
		if sprite_index == A.spr_NSMBU_shell_buzzy_empty or sprite_index == A.spr_shell_buzzy_empty or sprite_index == A.spr_SMB3_shell_empty or sprite_index == A.spr_SMB3_shell_empty_night or sprite_index == A.spr_SMB_shell_empty or sprite_index == A.spr_SMB_shell_empty_night:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell_empty)):
				inst.set("inwall", 1.0)
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
				inst.sprite_index = self.sprite_index
				inst.flip = self.flip
				inst.inwall = 1.0
				if G.apariencia == 2.0:
					if self.koopainside < 0.0:
						inst.koopainside = self.koopainside
						inst.alarm[3] = 540.0
						inst.alarm[4] = 600.0
				else:
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
				if self.koopainside == 1.0 or self.koopainside == 2.0:
					inst.koopainside = 0.0
		if koopainside == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_beachkoopa)):
				inst.sprite_index = A.spr_beachkoopa
				if (i_mario.bbox_left + (inst.bbox_right / 2.0)) < (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = 3.0
				elif (i_mario.bbox_left + (inst.bbox_right / 2.0)) > (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = -3.0
				inst.alarm[11] = 30.0
				inst.set("ready_v", 0.0)
		elif koopainside == 2.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_beachkoopa_red)):
				inst.sprite_index = A.spr_beachkoopa_red
				if (i_mario.bbox_left + (inst.bbox_right / 2.0)) < (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = 3.0
				elif (i_mario.bbox_left + (inst.bbox_right / 2.0)) > (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = -3.0
				inst.alarm[11] = 30.0
				inst.set("ready_v", 0.0)
		instance_destroy()


# from objects/obj_shell_held/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
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


# from objects/obj_shell_held/Other_14.gml
func _user_4() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	var block
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			if not GM.variable_instance_exists(self, "bouncy"):
				vspeed = 0.0
			elif vspeed > 0.5:
				vspeed = ((-vspeed) / 2.0)
			else:
				vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				if not GM.audio_is_playing(A.snd_oneway):
					GM.audio_play_sound(A.snd_oneway, 0.0, false)
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
	elif swimming <= 0.5:
		gravity = 0.22
		if vspeed > 7.0:
			vspeed = 7.0
	else:
		gravity = 0.02
		if vspeed > 2.0:
			vspeed = 2.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_hurtsolid2)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o2
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_shell_held/Other_15.gml
func _user_5() -> void:
	if sprite_index == A.spr_shell_buzzy_empty or sprite_index == A.spr_SMB3_shell_empty or sprite_index == A.spr_SMB3_shell_empty_night or sprite_index == A.spr_SMB_shell_empty or sprite_index == A.spr_SMB_shell_empty_night:
		imheld = GM.instance_create(x, (y - 1.0), A.obj_shell_empty)
	else:
		imheld = GM.instance_create(x, (y - 1.0), A.obj_shell)
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
	if sprite_index != A.spr_shell_buzzy_empty and sprite_index != A.spr_SMB3_shell_empty and sprite_index != A.spr_SMB3_shell_empty_night and sprite_index != A.spr_SMB_shell_empty and sprite_index != A.spr_SMB_shell_empty_night:
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


# from objects/obj_shell_held/Draw_0.gml
func _gm_draw() -> void:
	if sprite_height < 20.0:
		if flip == 0.0:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (y + 17.0), direct, -1.0, 0.0, GM.c_white, image_alpha)
	elif flip == 0.0:
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, -1.0, 0.0, GM.c_white, image_alpha)
