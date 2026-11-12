# 第 4 批移植，已核对。
extends GMObject

var cap_invisible: float = 0.0
var vvelocidad: float = 0.0
var ready_cap: float = 0.0
var s_cap_stay: int = 0
var s_cap_stay_start: int = 0
var s_cap_start_stay: int = 0
var direct: float = 0.0
var pos_x: float = 0.0
var pos_y: float = 0.0


# from objects/obj_cap_mario/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	visible = false
	cap_invisible = 1.0
	vvelocidad = 0.0
	ready_cap = 0.0
	s_cap_stay = A.spr_cap_stay
	s_cap_stay_start = A.spr_cap_stay_start
	s_cap_start_stay = A.spr_cap_start_stay
	direct = 1.0
	pos_x = 0.0
	pos_y = 0.0


# from objects/obj_cap_mario/Step_0.gml
func _step() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		vvelocidad = i_mario.vspeed
	if G.powerup != 3.0 and (not GM.instance_exists(A.obj_mario_transform2)):
		instance_destroy()


# from objects/obj_cap_mario/Step_2.gml
func _step_end() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	var _o: GMObject = GM.other
	# with (other.id)：Step_2 里 other 的来源见 U14（等于自身）
	var _target: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_target):
		if GM.instance_exists(A.obj_mario):
			inst.event_user(0)
			inst.event_user(1)
			inst.event_user(2)
			inst.event_user(3)
			inst.event_user(4)
			inst.event_user(5)
			inst.event_user(6)
			inst.x = i_mario.x
			inst.y = i_mario.y
		elif GM.instance_exists(A.obj_player_goal_smw):
			inst.event_user(0)
			inst.event_user(1)
			inst.event_user(2)
			inst.event_user(3)
			inst.event_user(4)
			inst.event_user(5)
			inst.event_user(7)
			inst.x = (i_goal.x + inst.pos_x)
			inst.y = (i_goal.y + inst.pos_y)
	GM.other = _o


# from objects/obj_cap_mario/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	return


# from objects/obj_cap_mario/Collision_obj_bowser_fire.gml
func _collision_obj_bowser_fire(other: GMObject) -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if (i_mario.caped == 1.0 or i_mario.stompstyle == 1.0) and (sprite_index == A.spr_cap_spinjump or sprite_index == A.spr_cap_spinjump_fall):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_cap_mario/Collision_obj_bowser_fire_down.gml
func _collision_obj_bowser_fire_down(other: GMObject) -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if (i_mario.caped == 1.0 or i_mario.stompstyle == 1.0) and (sprite_index == A.spr_cap_spinjump or sprite_index == A.spr_cap_spinjump_fall):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_cap_mario/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var o = other
	if GM.instance_exists(A.obj_mario):
		if o.bbox_bottom < ((i_mario.bbox_top - i_mario.vspeed) + 5.0) and o.vspeed > 0.0:
			return
		if (o.hardness < 99.0 or o.object_index == A.obj_buzzybeetle or o.object_index == A.obj_buzzybeetle_b) and sprite_index == A.spr_cap_spinjump and (i_mario.caped == 1.0 or i_mario.stompstyle == 1.0):
			if o.object_index != A.obj_egg:
				GM.audio_stop_sound(A.snd_kick)
				GM.audio_play_sound(A.snd_kick, 0.0, false)
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(GM.instance_create(o.x, o.y, A.obj_score)):
					inst.event_user(0)
				GM.other = _o
				if o.object_index == A.obj_koopa or o.object_index == A.obj_koopa_b or o.object_index == A.obj_koopa_red or o.object_index == A.obj_koopa_red_b or o.object_index == A.obj_galoomba or o.object_index == A.obj_buzzybeetle or o.object_index == A.obj_buzzybeetle_b or o.object_index == A.obj_snow_ball_held or o.object_index == A.obj_shell_held:
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(5)
					GM.other = _o2
				else:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(0)
					GM.other = _o3


# from objects/obj_cap_mario/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if (i_mario.caped == 1.0 or i_mario.stompstyle == 1.0) and (sprite_index == A.spr_cap_spinjump or sprite_index == A.spr_cap_spinjump_fall):
			if other.object_index == A.obj_shell:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(7)
				GM.other = _o
			else:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(5)
				GM.other = _o2


# from objects/obj_cap_mario/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if sprite_index == A.spr_cap_spinjump and (i_mario.caped == 1.0 or i_mario.stompstyle == 1.0):
			GM.audio_stop_sound(Scr.scr_snd_kick(self))
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			if i_mario.x < other.x:
				for inst in GM.with_list(other):
					inst.vspeed = (-((2.0 - (1.0 * inst.swimming))))
					inst.hspeed = 1.2
			else:
				for inst in GM.with_list(other):
					inst.vspeed = (-((2.0 - (1.0 * inst.swimming))))
					inst.hspeed = -1.2


# from objects/obj_cap_mario/Collision_obj_wrench.gml
func _collision_obj_wrench(other: GMObject) -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if (i_mario.caped == 1.0 or i_mario.stompstyle == 1.0) and (sprite_index == A.spr_cap_spinjump or sprite_index == A.spr_cap_spinjump_fall):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_cap_mario/Other_7.gml
func _animation_end() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	if GM.instance_exists(A.obj_mario):
		if sprite_index == s_cap_stay_start and (i_mario.hspeed > 0.0 or i_mario.hspeed < 0.0):
			sprite_index = A.spr_cap_run
		elif sprite_index == s_cap_start_stay:
			sprite_index = s_cap_stay
		elif sprite_index == s_cap_stay_start and i_mario.hspeed == 0.0:
			sprite_index = s_cap_start_stay
		elif sprite_index == A.spr_cap_stay_fall:
			sprite_index = A.spr_cap_fall
	elif GM.instance_exists(A.obj_player_goal_smw):
		if sprite_index == s_cap_stay_start and (i_goal.hspeed > 0.0 or i_goal.hspeed < 0.0):
			sprite_index = A.spr_cap_run
		elif sprite_index == s_cap_start_stay:
			sprite_index = s_cap_stay
		elif sprite_index == s_cap_stay_start and i_goal.hspeed == 0.0:
			sprite_index = s_cap_start_stay
		elif sprite_index == A.spr_cap_stay_fall:
			sprite_index = A.spr_cap_fall


# from objects/obj_cap_mario/Other_10.gml
func _user_0() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	if GM.instance_exists(A.obj_mario):
		if i_mario.state == 3.0:
			depth = -9.0
		elif GM.instance_exists(A.obj_kuribo_drybones) and i_mario.hspeed == 0.0:
			depth = -12.0
		elif G.yoshi > 0.0:
			depth = -10.0
		elif GM.instance_exists(A.obj_mario_transform2):
			depth = -7.0
		else:
			depth = -4.0
	elif GM.instance_exists(A.obj_player_goal_smw):
		if GM.instance_exists(A.obj_kuribo_drybones) and i_goal.speed == 0.0:
			if i_goal.pose == 1.0:
				depth = -4.0
			else:
				depth = -12.0
		elif G.yoshi > 0.0:
			if i_goal.pose == 1.0:
				depth = -4.0
			else:
				depth = -10.0
		else:
			depth = -4.0


# from objects/obj_cap_mario/Other_11.gml
func _user_1() -> void:
	if G.yoshi > 0.0:
		s_cap_stay = A.spr_cap_stay_yoshi
		s_cap_stay_start = A.spr_cap_stay_start_yoshi
		s_cap_start_stay = A.spr_cap_start_stay_yoshi
	else:
		s_cap_stay = A.spr_cap_stay
		s_cap_stay_start = A.spr_cap_stay_start
		s_cap_start_stay = A.spr_cap_start_stay


# from objects/obj_cap_mario/Other_12.gml
func _user_2() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_drybones = GM.instance_find(A.obj_kuribo_drybones, 0)
	if GM.instance_exists(A.obj_mario_transform2) and ready_cap == 1.0:
		return
	if cap_invisible == 1.0 or (GM.instance_exists(A.obj_kuribo_drybones) and i_drybones.invincible == 1.0):
		visible = false
	elif GM.instance_exists(A.obj_mario):
		if i_mario.modo_vuelo == 1.0:
			visible = false
		else:
			visible = true
	elif GM.instance_exists(A.obj_player_goal_smw):
		visible = true


# from objects/obj_cap_mario/Other_13.gml
func _user_3() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	var i_yoshi = GM.instance_find(A.obj_yoshi2, 0)
	if GM.instance_exists(A.obj_mario):
		if i_mario.skidnow == 1.0 and i_mario.hspeed > 0.0:
			direct = -1.0
		elif i_mario.modo_vuelo == 1.0 or i_mario.stompstyle == 1.0 or i_mario.state == 3.0 or i_mario.turning == 1.0 or i_mario.skidnow == 1.0:
			direct = 1.0
		elif GM.instance_exists(A.obj_yoshi2):
			direct = i_yoshi.direct
		else:
			direct = i_mario.direct
	elif GM.instance_exists(A.obj_player_goal_smw):
		direct = i_goal.direct


# from objects/obj_cap_mario/Other_14.gml
func _user_4() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	var i_yoshi = GM.instance_find(A.obj_yoshi2, 0)
	if GM.instance_exists(A.obj_mario):
		if GM.instance_exists(A.obj_yoshi2):
			pos_x = (-((4.0 * i_yoshi.direct)))
		elif GM.instance_exists(A.obj_kuribo_drybones):
			if G.jugador == 0.0:
				pos_x = (-((2.0 * i_mario.direct)))
			else:
				pos_x = 0.0
		else:
			pos_x = 0.0
	elif GM.instance_exists(A.obj_player_goal_smw):
		if GM.instance_exists(A.obj_yoshi2):
			pos_x = (-((4.0 * i_goal.direct)))
		elif GM.instance_exists(A.obj_kuribo_drybones):
			if G.jugador == 0.0:
				pos_x = (-((2.0 * i_goal.direct)))
			else:
				pos_x = 0.0
		else:
			pos_x = 0.0


# from objects/obj_cap_mario/Other_15.gml
func _user_5() -> void:
	var offset: float
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	var i_yoshi = GM.instance_find(A.obj_yoshi2, 0)
	var i_drybones = GM.instance_find(A.obj_kuribo_drybones, 0)
	if GM.instance_exists(A.obj_mario):
		if GM.instance_exists(A.obj_yoshi2):
			if i_mario.isduck == 1.0:
				if i_mario.state == 2.0 and i_mario.vspeed > 0.0:
					pos_y = 0.0
				else:
					pos_y = -2.0
			elif i_yoshi.licking == 1.0 and i_yoshi.jumping == 0.0:
				pos_y = -6.0
			elif i_mario.state == 2.0 and i_mario.vspeed > 0.0:
				pos_y = -8.0
			elif sprite_index == A.spr_cap_run:
				pos_y = -11.0
			else:
				pos_y = -10.0
		elif GM.instance_exists(A.obj_kuribo_drybones):
			offset = i_drybones.offset
			if i_mario.isduck == 1.0:
				if i_mario.state == 2.0 and i_mario.vspeed > 0.0:
					pos_y = 0.0
				else:
					pos_y = (-((2.0 - offset)))
			elif i_mario.state == 2.0 and i_mario.vspeed > 0.0:
				pos_y = 0.0
			else:
				pos_y = (-2.0 - offset)
		elif i_mario.isduck == 1.0:
			if i_mario.state == 2.0 and i_mario.vspeed > 0.0:
				pos_y = 4.0
			else:
				pos_y = 0.0
		elif i_mario.isduckhold == 1.0:
			if i_mario.state == 2.0 and i_mario.vspeed > 0.0:
				pos_y = 2.0
			else:
				pos_y = 0.0
		else:
			pos_y = 0.0
	elif GM.instance_exists(A.obj_player_goal_smw):
		if GM.instance_exists(A.obj_yoshi2):
			if i_goal.vspeed > 0.0:
				pos_y = -8.0
			elif sprite_index == A.spr_cap_run:
				pos_y = -11.0
			else:
				pos_y = -10.0
		elif GM.instance_exists(A.obj_kuribo_drybones):
			pos_y = (-2.0 - i_drybones.offset)
		else:
			pos_y = 0.0
	if G.jugador == 1.0:
		pos_y -= 1.0


# from objects/obj_cap_mario/Other_16.gml
func _user_6() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if i_mario.modo_vuelo == 1.0:
		return
	if GM.instance_exists(A.obj_mario_transform2) and ready_cap == 1.0:
		image_speed = 0.0
		return
	elif i_mario.state == 3.0 or i_mario.turning == 1.0:
		sprite_index = A.spr_cap_climb
		if i_mario.speed == 0.0 or i_mario.turning == 1.0:
			image_speed = 0.0
		else:
			image_speed = 0.15
	elif i_mario.stompstyle == 1.0 or i_mario.caped == 1.0:
		if i_mario.vspeed > 0.0:
			sprite_index = A.spr_cap_spinjump_fall
		else:
			sprite_index = A.spr_cap_spinjump
		image_speed = 0.0
		image_index = i_mario.image_index
	elif i_mario.sprite_index == Scr.scr_mariorunjump(self):
		sprite_index = A.spr_cap_run
		image_speed = absf((i_mario.hspeed / 10.0))
	elif (i_mario.sprite_index == Scr.scr_marioswim(self) or i_mario.sprite_index == Scr.scr_marioswimhold(self)) and i_mario.state == 2.0 and i_mario.isswim == 1.0 and i_mario.vspeed < 0.0:
		sprite_index = A.spr_cap_run
		image_speed = 0.12
	elif (i_mario.sprite_index == Scr.scr_mariohold(self) or G.yoshi > 0.0) and i_mario.pmeter > 5.0 and i_mario.stompstyle == 0.0 and i_mario.vspeed != 0.0:
		sprite_index = A.spr_cap_run
		image_speed = absf((i_mario.hspeed / 10.0))
	elif i_mario.state == 2.0:
		if i_mario.vspeed > 0.0:
			if sprite_index != A.spr_cap_fall:
				sprite_index = A.spr_cap_stay_fall
				image_speed = absf((i_mario.vspeed / 8.0))
			else:
				image_speed = 0.4
		elif sprite_index != s_cap_stay:
			sprite_index = s_cap_start_stay
			image_speed = 0.1
		else:
			image_speed = 0.0
			image_index = 0.0
	elif i_mario.state == 1.0 and i_mario.hspeed != 0.0:
		if sprite_index == A.spr_cap_fall or sprite_index == A.spr_cap_spinjump_fall:
			sprite_index = s_cap_start_stay
			image_speed = 0.1
		elif sprite_index != A.spr_cap_run:
			sprite_index = s_cap_stay_start
			image_speed = 0.1
		else:
			image_speed = absf((i_mario.hspeed / 10.0))
	elif i_mario.state == 0.0 and i_mario.hspeed == 0.0 and (sprite_index == A.spr_cap_run or sprite_index == A.spr_cap_spinjump or sprite_index == A.spr_cap_fall or sprite_index == A.spr_cap_spinjump_fall):
		image_index = 0.0
		image_speed = 0.1
		sprite_index = s_cap_start_stay
	elif sprite_index != s_cap_stay_start and sprite_index != s_cap_start_stay:
		if sprite_index != s_cap_stay:
			sprite_index = s_cap_start_stay
			image_speed = 0.1
		else:
			image_speed = 0.0
			image_index = 0.0
	else:
		image_speed = 0.1
	ready_cap = 1.0


# from objects/obj_cap_mario/Other_17.gml
func _user_7() -> void:
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	if i_goal.hspeed != 0.0:
		if sprite_index == A.spr_cap_fall or sprite_index == A.spr_cap_spinjump_fall:
			sprite_index = s_cap_start_stay
			image_speed = 0.1
		elif sprite_index != A.spr_cap_run:
			sprite_index = s_cap_stay_start
			image_speed = 0.1
		else:
			image_speed = absf((i_goal.hspeed / 10.0))
	elif i_goal.sprite_index == Scr.scr_mariogoal(self):
		sprite_index = s_cap_stay_start
		image_speed = 0.0
		image_index = 0.0
	elif i_goal.vspeed != 0.0:
		if i_goal.vspeed > 0.0:
			if sprite_index != A.spr_cap_fall:
				sprite_index = A.spr_cap_stay_fall
				image_speed = absf((i_goal.vspeed / 8.0))
			else:
				image_speed = 0.4
		elif sprite_index != s_cap_stay:
			sprite_index = s_cap_start_stay
			image_speed = 0.1
		else:
			image_speed = 0.0
			image_index = 0.0
	elif sprite_index != s_cap_stay_start and sprite_index != s_cap_start_stay:
		if sprite_index != s_cap_stay:
			sprite_index = s_cap_start_stay
			image_speed = 0.1
		else:
			image_speed = 0.0
			image_index = 0.0
	else:
		image_speed = 0.1


# from objects/obj_cap_mario/Draw_0.gml
func _gm_draw() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_goal = GM.instance_find(A.obj_player_goal_smw, 0)
	var i_invinc = GM.instance_find(A.obj_invincibility, 0)
	if GM.instance_exists(A.obj_mario):
		GM.draw_sprite_ext(sprite_index, image_index, (i_mario.x + pos_x), ((i_mario.y + pos_y) + 1.0), direct, 1.0, 0.0, GM.c_white, i_mario.image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, (i_mario.x + pos_x), ((i_mario.y + pos_y) + 1.0), direct, 1.0, 0.0, i_mario.blend_star, i_invinc.flashAlpha)
			GM.shader_reset()
	elif GM.instance_exists(A.obj_player_goal_smw):
		GM.draw_sprite_ext(sprite_index, image_index, (i_goal.x + pos_x), ((i_goal.y + pos_y) + 1.0), direct, 1.0, 0.0, GM.c_white, i_goal.image_alpha)
