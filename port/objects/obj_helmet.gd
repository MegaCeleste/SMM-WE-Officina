# from objects/obj_helmet（第 7 批移植，已核对）
extends GMObject

var rotacion: float = 0.0
var rot: float = 0.0
var up: float = 0.0
var pos_y: float = 0.0
var direct = null
var vvelocidad: float = 0.0
var fallow: int = 0  ## PORT: 原版只存 object 编号（obj_lighting 表示“没有”，Other_22 设成 obj_doormario 等），`fallow.x` 按 §3.3 第 16 条取第一个实例
var imdead = null


# from objects/obj_helmet/Create_0.gml
func _create() -> void:
	_user_6()
	image_speed = 0.0
	image_index = 0.0
	rotacion = 0.0
	rot = 1.0
	up = 0.0
	pos_y = 21.0
	direct = 1.0
	vvelocidad = 0.0
	fallow = A.obj_lighting


# from objects/obj_helmet/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		vvelocidad = GM.instance_find(A.obj_mario, 0).vspeed
	speed = 0.0
	gravity = 0.0
	if GM.instance_exists(A.obj_helmet_spiny):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_helmet_spiny):
			inst.event_user(5)
		GM.other = _o


# from objects/obj_helmet/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_mario):
		if G.powerup != -82.0:
			if G.jugador == 0.0:
				_user_8()
			elif G.jugador == 1.0:
				_user_9()
			elif G.jugador > 1.0:
				_user_10()
			if G.apariencia == 0.0 and GM.instance_find(A.obj_mario, 0).state == 3.0:
				if G.powerup == -77.0:
					x = (GM.instance_find(A.obj_mario, 0).x - (12.0 * direct))
				else:
					x = (GM.instance_find(A.obj_mario, 0).x - (6.0 * direct))
			else:
				x = GM.instance_find(A.obj_mario, 0).x
			y = (GM.instance_find(A.obj_mario, 0).y + pos_y)
		if GM.instance_exists(A.obj_kuriboshoe) or GM.instance_exists(A.obj_kuribo_drybones):
			depth = -12.0
		else:
			depth = -9.0
		if GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_find(A.obj_kuribo_drybones, 0).invincible == 1.0:
			image_alpha = 0.0
		elif GM.instance_find(A.obj_mario, 0).invincible == 1.0 and (not GM.instance_exists(A.obj_invincibility)):
			image_alpha = GM.instance_find(A.obj_mario, 0).image_alpha
		else:
			image_alpha = 1.0
		if GM.instance_find(A.obj_mario, 0).stompstyle == 1.0:
			direct = 1.0
		elif GM.instance_exists(A.obj_yoshi2):
			direct = GM.instance_find(A.obj_yoshi2, 0).direct
		else:
			direct = GM.instance_find(A.obj_mario, 0).direct
		if (not GM.instance_exists(A.obj_mario_transform2)) and GM.instance_find(A.obj_mario, 0).state != 3.0:
			_user_7()
		if GM.instance_find(A.obj_mario, 0).state == 3.0:
			rotacion = 0.0
			rotacion = 0.0
			rot = 1.0
			up = 0.0
		_user_6()
	else:
		_user_12()
		if fallow != A.obj_lighting and GM.instance_exists(fallow):
			_user_13()
			# ORIG-BUG: fallow 只会被 Other_22 设成 obj_doormario/obj_doormario_exit/obj_player_warp/obj_player_goal_parent，永远不等于 obj_player_goal_smb1，这个分支走不到
			if fallow == A.obj_player_goal_smb1 and GM.instance_find(fallow, 0).sprite_index == Scr.scr_marioclimb(self):
				if G.powerup == -77.0:
					x = (GM.instance_find(fallow, 0).x - (12.0 * GM.instance_find(fallow, 0).direct))
				else:
					x = (GM.instance_find(fallow, 0).x - (6.0 * GM.instance_find(fallow, 0).direct))
			else:
				x = GM.instance_find(fallow, 0).x
			y = (GM.instance_find(fallow, 0).y + pos_y)
			if GM.instance_find(fallow, 0).object_index == A.obj_player_warp:
				depth = 12.0
			elif GM.instance_exists(A.obj_kuriboshoe) or GM.instance_exists(A.obj_kuribo_drybones):
				depth = -12.0
			else:
				depth = -9.0
			if GM.instance_exists(A.obj_player_goal_smw_castle) and GM.instance_find(A.obj_player_goal_smw_castle, 0).link_mode == 1.0:
				image_alpha = 0.0
			else:
				image_alpha = 1.0
			direct = GM.instance_find(fallow, 0).direct
			if GM.instance_find(fallow, 0).object_index != A.obj_player_warp:
				_user_7()
			else:
				rotacion = 0.0
			if G.powerup == -82.0:
				sprite_index = A.spr_helmet_pballoon
				image_index = 0.0
			else:
				_user_6()


# from objects/obj_helmet/Collision_obj_banzaibill.gml
func _collision_obj_banzaibill(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(0)
	GM.other = _o
	var _o2: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o2


# from objects/obj_helmet/Collision_obj_bone.gml
func _collision_obj_bone(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	imdead = GM.instance_create(other.x, other.y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.image_angle = image_angle
	imdead.sprite_index = other.sprite_index
	if other.hspeed == 0.0:
		# ORIG-BUG: other.bbox_left 和自己的 bbox_right 混用（且 left + right/2 不是中点）
		if (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif other.hspeed < 0.0:
		imdead.hspeed = -1.0
	for inst in GM.with_list(other):
		inst.instance_destroy()


# from objects/obj_helmet/Collision_obj_brohammer.gml
func _collision_obj_brohammer(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_helmet/Collision_obj_bulletbill.gml
func _collision_obj_bulletbill(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(0)
	GM.other = _o
	var _o2: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o2


# from objects/obj_helmet/Collision_obj_bulletbull_red.gml
func _collision_obj_bulletbull_red(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(0)
	GM.other = _o
	var _o2: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o2


# from objects/obj_helmet/Collision_obj_buzzy_ceiling.gml
func _collision_obj_buzzy_ceiling(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 8.0) and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o


# from objects/obj_helmet/Collision_obj_cannonball.gml
func _collision_obj_cannonball(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(0)
	GM.other = _o
	var _o2: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o2


# from objects/obj_helmet/Collision_obj_clown.gml
func _collision_obj_clown(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		other.vspeed = -0.5


# from objects/obj_helmet/Collision_obj_espina.gml
func _collision_obj_espina(other: GMObject) -> void:
	if object_index == A.obj_helmet_spiny:
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
	imdead = GM.instance_create(other.x, other.y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = other.sprite_index
	imdead.image_index = other.image_index
	if other.hspeed == 0.0:
		# ORIG-BUG: other.bbox_left 和自己的 bbox_right 混用（且 left + right/2 不是中点）
		if (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif other.hspeed < 0.0:
		imdead.hspeed = -1.0
	for inst in GM.with_list(other):
		inst.instance_destroy()


# from objects/obj_helmet/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0 and (not GM.keyboard_check(G.lanzar_agarrar)):
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		other.hspeed = GM.lengthdir_x(1.0, GM.point_direction(x, y, other.x, other.y))
		if vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -1.0)


# from objects/obj_helmet/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	gravity = 0.0
	speed = 0.0


# from objects/obj_helmet/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		if vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -2.0)


# from objects/obj_helmet/Collision_obj_physicsparent.gml
func _collision_obj_physicsparent(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 8.0) and other.vspeed >= 0.0 and other.object_index != A.obj_thwomp and other.object_index != A.obj_coin_pow and other.object_index != A.obj_spring_land and other.object_index != A.obj_grinder and other.object_index != A.obj_magikoopa and other.object_index != A.obj_cannon and other.object_index != A.obj_cannon_red and other.object_index != A.obj_mushroom and other.object_index != A.obj_yoshifire and other.object_index != A.obj_yoshifire_one and other.object_index != A.obj_1up and other.object_index != A.obj_fireflower and other.object_index != A.obj_cap and other.object_index != A.obj_star and other.object_index != A.obj_bowser_fire_down and other.object_index != A.obj_bullebill_base and other.object_index != A.obj_piranhaplant and other.object_index != A.obj_boo:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		var o = other  # PORT: 按 §3.3 第 8a 条用不带类型的局部变量访问 other 的自定义变量
		# PORT: 原版 variable_instance_exists(other.object_index, …)，照 Q4 的做法检查 other 本身
		if GM.variable_instance_exists(o, "paracaidas") and o.paracaidas == 1.0:
			o.paracaidas = 0.0
			if other.object_index == A.obj_galoomba or other.object_index == A.obj_galoomba2:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(7)
				GM.other = _o
		if other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
			var bobomb = GM.instance_create((other.x - 8.0), other.y, A.obj_bobomb_hold)
			bobomb.direct = o.direct
			if vvelocidad >= 0.0:
				bobomb.vspeed = -2.0
			else:
				bobomb.vspeed = (vvelocidad + -1.0)
			for inst in GM.with_list(other):
				inst.instance_destroy()
		elif other.object_index == A.obj_podoboo or other.object_index == A.obj_podoboo_b:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o2
		elif other.object_index == A.obj_lakitu:
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o3
		elif other.object_index == A.obj_cheepcheep or other.object_index == A.obj_cheepcheep2:
			var _o4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o4
		elif other.object_index == A.obj_jumppiranha and o.inup != 0.0:
			var _o5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o5
		elif vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -1.0)


# from objects/obj_helmet/Collision_obj_plantfire.gml
func _collision_obj_plantfire(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_helmet/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 8.0) and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(5)
		GM.other = _o


# from objects/obj_helmet/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	var o = other  # PORT: 按 §3.3 第 8a 条用不带类型的局部变量访问 other 的自定义变量
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 8.0) and other.vspeed >= 0.0:
		if object_index == A.obj_helmet_spiny:
			GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o
			return
		else:
			GM.audio_stop_sound(A.snd_helmet)
			GM.audio_play_sound(A.snd_helmet, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_starhelmet
		o.fisica = 1.0
		o.ready_v = 1.0  # PORT: 原名 ready，和 Node.ready 撞名
		if vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -1.0)


# from objects/obj_helmet/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	var o = other  # PORT: 按 §3.3 第 8a 条用不带类型的局部变量访问 other 的自定义变量
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 8.0) and other.vspeed >= 0.0:
		if object_index == A.obj_helmet_spiny:
			GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		else:
			GM.audio_stop_sound(A.snd_helmet)
			GM.audio_play_sound(A.snd_helmet, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_starhelmet
		# PORT: 原版 variable_instance_exists(other.object_index, …)，照 Q4 的做法检查 other 本身
		if GM.variable_instance_exists(o, "paracaidas") and o.paracaidas == 1.0:
			o.paracaidas = 0.0
		o.fisica = 1.0
		o.ready_v = 1.0  # PORT: 原名 ready，和 Node.ready 撞名
		if vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -1.0)


# from objects/obj_helmet/Collision_obj_thwomp.gml
func _collision_obj_thwomp(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_helmet)
		GM.audio_play_sound(A.snd_helmet, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_starhelmet
		if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
			if vvelocidad >= 0.0:
				other.vspeed = -2.0
			else:
				other.vspeed = (vvelocidad + -2.0)
		else:
			other.vspeed = -0.5


# from objects/obj_helmet/Other_15.gml
func _user_5() -> void:
	GM.audio_stop_sound(A.snd_helmet_remove)
	GM.audio_play_sound(A.snd_helmet_remove, 0.0, false)
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	imdead.direct = direct
	if G.apariencia != 2.0 and (sprite_index == A.spr_SMB_helmet_small or sprite_index == A.spr_SMB_helmet_big or sprite_index == A.spr_SMB3_helmet_small or sprite_index == A.spr_SMB3_helmet_big):
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			imdead.image_index = 1.0
		else:
			imdead.image_index = 0.0
	if GM.instance_find(A.obj_mario, 0).hspeed == 0.0:
		if (GM.instance_find(A.obj_mario, 0).bbox_left + (GM.instance_find(A.obj_mario, 0).bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.instance_find(A.obj_mario, 0).bbox_left + (GM.instance_find(A.obj_mario, 0).bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.instance_find(A.obj_mario, 0).hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.instance_find(A.obj_mario, 0).hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_helmet/Other_16.gml
func _user_6() -> void:
	if G.powerup == -82.0:
		sprite_index = A.spr_helmet_pballoon
		image_speed = 0.0
		image_index = 0.0
		return
	if G.apariencia == 0.0:
		if G.powerup == 0.0 or G.powerup == -78.0 or G.powerup == -85.0:
			sprite_index = A.spr_SMB_helmet_small
		elif G.powerup == -77.0:
			sprite_index = A.spr_SMB_helmet_mega
		else:
			sprite_index = A.spr_SMB_helmet_big
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 1.0:
		if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				if G.powerup == 0.0:
					sprite_index = A.spr_SMB3_helmet_small_climb
					image_index = 1.0
				else:
					sprite_index = A.spr_SMB3_helmet_round_night
					image_index = 2.0
			elif G.powerup == 0.0:
				sprite_index = A.spr_SMB3_helmet_small_climb
				image_index = 0.0
			else:
				sprite_index = A.spr_SMB3_helmet_round
				image_index = 2.0
		elif GM.instance_exists(A.obj_spinner):
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				sprite_index = A.spr_SMB3_helmet_round_night
			else:
				sprite_index = A.spr_SMB3_helmet_round
			image_index = GM.instance_find(A.obj_spinner, 0).image_index
		elif G.powerup == 0.0:
			sprite_index = A.spr_SMB3_helmet_small
			image_index = 0.0
		else:
			sprite_index = A.spr_SMB3_helmet_big
			image_index = 0.0
		if ((not GM.instance_exists(A.obj_spinner)) and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).sprite_index != Scr.scr_marioclimb(self)) or GM.instance_exists(A.obj_player_goal_smb3):
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
	if G.apariencia == 2.0:
		if GM.instance_exists(A.obj_yoshi2):
			sprite_index = A.spr_helmet_yoshi
		elif GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
			sprite_index = A.spr_helmet
			image_index = 3.0
		elif GM.instance_exists(A.obj_mario) and (GM.instance_find(A.obj_mario, 0).stompstyle == 1.0 or GM.instance_find(A.obj_mario, 0).caped > 0.0):
			sprite_index = A.spr_helmet
			image_index = GM.instance_find(A.obj_mario, 0).image_index
		elif GM.instance_exists(A.obj_mario) and (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
			sprite_index = A.spr_SMW_helmet_up
		else:
			sprite_index = A.spr_helmet
			image_index = 0.0


# from objects/obj_helmet/Other_17.gml
func _user_7() -> void:
	var m_speed  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).state == 1.0:
			m_speed = (absf(GM.instance_find(A.obj_mario, 0).hspeed) + 1.0)
			if rot == 1.0:
				if up == 0.0:
					if rotacion > -10.0:
						rotacion -= m_speed
					else:
						up = 1.0
				elif up == 1.0:
					if rotacion < 10.0:
						rotacion += m_speed
					else:
						up = 0.0
		else:
			up = 0.0
		if place_free(x, (y + 1.0)) and GM.instance_find(A.obj_mario, 0).vspeed > 0.0 and GM.instance_find(A.obj_mario, 0).stompstyle == 0.0 and GM.instance_find(A.obj_mario, 0).state != 3.0:
			if direct == 1.0:
				if rotacion < 35.0:
					rotacion += 2.25
				else:
					rotacion = 35.0
			elif rotacion > -35.0:
				rotacion -= 2.25
			else:
				rotacion = -35.0
		elif GM.instance_find(A.obj_mario, 0).state != 1.0:
			if rotacion < 0.0:
				rotacion += 2.25
			elif rotacion > 0.0:
				rotacion -= 2.25
			else:
				rotacion = 0.0
	elif fallow != A.obj_lighting and GM.instance_exists(fallow):
		if GM.instance_find(fallow, 0).hspeed != 0.0:
			m_speed = (absf(GM.instance_find(fallow, 0).hspeed) + 1.0)
			if rot == 1.0:
				if up == 0.0:
					if rotacion > -10.0:
						rotacion -= m_speed
					else:
						up = 1.0
				elif up == 1.0:
					if rotacion < 10.0:
						rotacion += m_speed
					else:
						up = 0.0
		else:
			up = 0.0
		if GM.instance_find(fallow, 0).vspeed > 0.0:
			if direct == 1.0:
				if rotacion < 35.0:
					rotacion += 2.25
				else:
					rotacion = 35.0
			elif rotacion > -35.0:
				rotacion -= 2.25
			else:
				rotacion = -35.0
		elif GM.instance_find(fallow, 0).hspeed == 0.0:
			if rotacion < 0.0:
				rotacion += 2.25
			elif rotacion > 0.0:
				rotacion -= 2.25
			else:
				rotacion = 0.0


# from objects/obj_helmet/Other_18.gml
func _user_8() -> void:
	var off  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif G.powerup == -77.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = -8.0
					else:
						pos_y = (-14.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 11.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (10.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 19.0
				else:
					pos_y = 16.0
			elif G.powerup == -78.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 13.0
				else:
					pos_y = 0.0
			elif G.powerup == -77.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 8.0
				else:
					pos_y = 0.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 11.0
			else:
				pos_y = 2.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 17.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 17.0
			else:
				pos_y = 8.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if GM.instance_find(A.obj_mario, 0).state == 0.0:
					off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				else:
					off = (GM.instance_find(A.obj_kuribo_drybones, 0).offset - 2.0)
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if GM.instance_find(A.obj_yoshi2, 0).licking > 0.5:  # PORT: GML 真值判断
					if GM.instance_find(A.obj_yoshi2, 0).jumping == 0.0:
						if G.powerup == 0.0:
							pos_y = 8.0
						else:
							pos_y = 3.0
					elif GM.instance_find(A.obj_yoshi2, 0).locked == 2.0:
						if G.powerup == 0.0:
							pos_y = 9.0
						else:
							pos_y = 3.0
					elif G.powerup == 0.0:
						pos_y = 4.0
					else:
						pos_y = -1.0
				elif G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = 3.0
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
					pos_y = 16.0
				elif GM.instance_find(A.obj_mario, 0).isduckhold == 1.0:
					pos_y = 19.0
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 21.0
				else:
					pos_y = 15.0
			elif (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
				pos_y = 12.0
			elif GM.instance_find(A.obj_mario, 0).isduckhold == 1.0:
				pos_y = 16.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 20.0
			else:
				pos_y = 9.0


# from objects/obj_helmet/Other_19.gml
func _user_9() -> void:
	var off  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif G.powerup == -77.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = -8.0
					else:
						pos_y = (-14.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 11.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (10.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 19.0
				else:
					pos_y = 16.0
			elif G.powerup == -78.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 13.0
				else:
					pos_y = 0.0
			elif G.powerup == -77.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 8.0
				else:
					pos_y = 0.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 11.0
			else:
				pos_y = 2.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 17.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 17.0
			else:
				pos_y = 8.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if GM.instance_find(A.obj_mario, 0).state == 0.0:
					off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				else:
					off = (GM.instance_find(A.obj_kuribo_drybones, 0).offset - 2.0)
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if GM.instance_find(A.obj_yoshi2, 0).licking > 0.5:  # PORT: GML 真值判断
					if GM.instance_find(A.obj_yoshi2, 0).jumping == 0.0:
						if G.powerup == 0.0:
							pos_y = 8.0
						else:
							pos_y = 3.0
					elif GM.instance_find(A.obj_yoshi2, 0).locked == 2.0:
						if G.powerup == 0.0:
							pos_y = 9.0
						else:
							pos_y = 3.0
					elif G.powerup == 0.0:
						pos_y = 4.0
					else:
						pos_y = -1.0
				elif G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = 3.0
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
					pos_y = 15.0
				elif GM.instance_find(A.obj_mario, 0).isduckhold == 1.0:
					pos_y = 18.0
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 14.0
			elif (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
				pos_y = 11.0
			elif GM.instance_find(A.obj_mario, 0).isduckhold == 1.0:
				pos_y = 15.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 19.0
			else:
				pos_y = 8.0


# from objects/obj_helmet/Other_20.gml
func _user_10() -> void:
	var off  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = (11.0 - off)
				elif G.powerup == -77.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = -7.0
					else:
						pos_y = (-12.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (9.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = (12.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 11.0
				else:
					pos_y = (9.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 18.0
			elif G.powerup == -78.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 14.0
				else:
					pos_y = 2.0
			elif G.powerup == -77.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 8.0
				else:
					pos_y = 2.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 14.0
			else:
				pos_y = 6.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 21.0
				else:
					pos_y = 18.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 17.0
			else:
				pos_y = 9.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if GM.instance_find(A.obj_mario, 0).state == 0.0:
					off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				else:
					off = (GM.instance_find(A.obj_kuribo_drybones, 0).offset - 2.0)
				if G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if GM.instance_find(A.obj_yoshi2, 0).licking > 0.5:  # PORT: GML 真值判断
					if GM.instance_find(A.obj_yoshi2, 0).jumping == 0.0:
						if G.powerup == 0.0:
							pos_y = 8.0
						else:
							pos_y = 3.0
					elif GM.instance_find(A.obj_yoshi2, 0).locked == 2.0:
						if G.powerup == 0.0:
							pos_y = 9.0
						else:
							pos_y = 3.0
					elif G.powerup == 0.0:
						pos_y = 4.0
					else:
						pos_y = -1.0
				elif G.powerup == 0.0:
					if GM.instance_find(A.obj_mario, 0).isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = 3.0
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
					pos_y = 17.0
				elif GM.instance_find(A.obj_mario, 0).isduckhold == 1.0:
					pos_y = 19.0
				elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 16.0
			elif (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
				pos_y = 12.0
			elif GM.instance_find(A.obj_mario, 0).isduckhold == 1.0:
				pos_y = 17.0
			elif GM.instance_find(A.obj_mario, 0).isduck == 1.0:
				pos_y = 20.0
			else:
				pos_y = 11.0


# from objects/obj_helmet/Other_22.gml
func _user_12() -> void:
	if GM.instance_exists(A.obj_doormario):
		fallow = A.obj_doormario
	elif GM.instance_exists(A.obj_doormario_exit):
		fallow = A.obj_doormario_exit
	elif GM.instance_exists(A.obj_player_warp):
		fallow = A.obj_player_warp
	elif GM.instance_exists(A.obj_player_goal_parent):
		fallow = A.obj_player_goal_parent


# from objects/obj_helmet/Other_23.gml
func _user_13() -> void:
	var off  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(fallow):
		# ORIG-BUG: fallow 永远不等于 obj_player_goal_smw（见 Other_22），这一句走不到
		if fallow == A.obj_player_goal_smw and GM.instance_find(fallow, 0).pose == 1.0:
			visible = false
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					pos_y = (9.0 - off)
				elif G.powerup == -77.0:
					pos_y = (-14.0 - off)
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					pos_y = (10.0 - off)
				else:
					pos_y = (7.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				pos_y = 16.0
			elif G.powerup == -78.0:
				pos_y = 0.0
			elif G.powerup == -77.0:
				pos_y = 0.0
			else:
				pos_y = 2.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = GM.instance_find(A.obj_kuriboshoe, 0).offset
				if G.powerup == 0.0:
					pos_y = (9.0 - off)
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				if G.powerup == 0.0:
					pos_y = (9.0 - off)
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				pos_y = 17.0
			else:
				pos_y = 8.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if GM.instance_find(fallow, 0).hspeed == 0.0:
					off = GM.instance_find(A.obj_kuribo_drybones, 0).offset
				else:
					off = (GM.instance_find(A.obj_kuribo_drybones, 0).offset - 2.0)
				if G.powerup == 0.0:
					pos_y = (9.0 - off)
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if G.powerup == 0.0:
					pos_y = 3.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if GM.instance_find(fallow, 0).sprite_index == Scr.scr_marioduck(self):
					pos_y = 21.0
				else:
					pos_y = 15.0
			elif GM.instance_find(fallow, 0).sprite_index == Scr.scr_marioduck(self):
				pos_y = 20.0
			else:
				pos_y = 9.0


# from objects/obj_helmet/Draw_0.gml
func _gm_draw() -> void:
	var mpos  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0 and GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
			if G.powerup == -77.0:
				mpos = 12.0
			else:
				mpos = 6.0
			GM.draw_sprite_ext(sprite_index, image_index, (GM.instance_find(A.obj_mario, 0).x - (mpos * direct)), ((GM.instance_find(A.obj_mario, 0).y + pos_y) + 1.0), direct, 1.0, rotacion, GM.instance_find(A.obj_mario, 0).blend_star, GM.instance_find(A.obj_mario, 0).flashAlpha)
		elif GM.instance_exists(A.obj_mario_pballon):
			GM.draw_sprite_ext(sprite_index, image_index, (GM.instance_find(A.obj_mario_pballon, 0).x + GM.instance_find(A.obj_mario_pballon, 0).xDiff_h), (GM.instance_find(A.obj_mario_pballon, 0).y + GM.instance_find(A.obj_mario_pballon, 0).yDiff_h), 1.0, 1.0, GM.instance_find(A.obj_mario_pballon, 0).direction, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, image_index, GM.instance_find(A.obj_mario, 0).x, ((GM.instance_find(A.obj_mario, 0).y + pos_y) + 1.0), direct, 1.0, rotacion, GM.c_white, image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			if G.apariencia == 0.0 and GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
				if G.powerup == -77.0:
					mpos = 12.0
				else:
					mpos = 6.0
				GM.draw_sprite_ext(sprite_index, image_index, (GM.instance_find(A.obj_mario, 0).x - (mpos * direct)), ((GM.instance_find(A.obj_mario, 0).y + pos_y) + 1.0), direct, 1.0, rotacion, GM.instance_find(A.obj_mario, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			elif GM.instance_exists(A.obj_mario_pballon):
				GM.draw_sprite_ext(sprite_index, image_index, (GM.instance_find(A.obj_mario_pballon, 0).x + GM.instance_find(A.obj_mario_pballon, 0).xDiff_h), (GM.instance_find(A.obj_mario_pballon, 0).y + GM.instance_find(A.obj_mario_pballon, 0).yDiff_h), 1.0, 1.0, GM.instance_find(A.obj_mario_pballon, 0).direction, GM.instance_find(A.obj_mario, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			else:
				GM.draw_sprite_ext(sprite_index, image_index, GM.instance_find(A.obj_mario, 0).x, ((GM.instance_find(A.obj_mario, 0).y + pos_y) + 1.0), direct, 1.0, rotacion, GM.instance_find(A.obj_mario, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()
	elif fallow != A.obj_lighting and GM.instance_exists(fallow):
		if fallow == A.obj_player_goal_parent and GM.instance_find(fallow, 0).sprite_index == Scr.scr_marioclimb(self):
			if G.powerup == -77.0:
				mpos = 6.0
			else:
				mpos = 3.0
			GM.draw_sprite_ext(sprite_index, image_index, (GM.instance_find(fallow, 0).x - (mpos * direct)), ((GM.instance_find(fallow, 0).y + pos_y) + 1.0), direct, 1.0, rotacion, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, image_index, GM.instance_find(fallow, 0).x, ((GM.instance_find(fallow, 0).y + pos_y) + 1.0), direct, 1.0, rotacion, GM.c_white, image_alpha)
