# 第 4 批移植，已核对。
extends GMObject

var color: float = 0.0
var turn: float = 0.0
var turning: float = 0.0
var licking: float = 0.0
var locked: float = 0.0
var direct = null
var sprite_mario = null
var index_mario: float = 0.0
var x_mario: float = 0.0
var y_mario: float = 0.0
var mouthholder = null  # object 编号（int）；noone 用 null（同 obj_mario 的写法）
var mouthsprite = null  # sprite 编号（int）；noone 用 null
var mouthnumb: float = 0.0
var powerup = null  # object 编号；noone 用 null
var berry = null
var anim: float = 0.0
var jumping: float = 0.0
var flying: float = 0.0
var flyanim: float = 0.0
var flutter: float = 0.0
var fluttertime: float = 0.0
var f: float = 0.0
var myy: float = 0.0
var stateprev = null
var wings: float = 0.0
var jump: float = 0.0
var s_yoshi_jump: int = 0
var s_yoshi_swallow: int = 0
var s_yoshi_lick: int = 0
var s_yoshi_fm_wait: int = 0
var s_yoshi_wait: int = 0
var s_yoshi_fm: int = 0
var s_yoshi: int = 0
var s_yoshi_fm_jump: int = 0
var follow = null
var sprite_wings = null  # 仅子类（obj_yoshi_blue / obj_yoshi_red）赋值


# from objects/obj_yoshi2/Create_0.gml
func _create() -> void:
	if G.apariencia != 2.0:
		instance_destroy()
		return
	G.yoshi = 1.0
	color = 0.0
	turn = 0.0
	turning = 0.0
	licking = 0.0
	locked = 0.0
	direct = 1.0
	sprite_mario = 0.0
	index_mario = 0.0
	x_mario = 0.0
	y_mario = 0.0
	mouthholder = null
	mouthsprite = null
	mouthnumb = 0.0
	powerup = null
	berry = null
	anim = 0.0
	jumping = 0.0
	flying = 0.0
	flyanim = 0.0
	flutter = 0.0
	fluttertime = 0.0
	f = 0.0
	myy = 0.0
	stateprev = 0.0
	wings = 1.0
	jump = 0.0
	if G.carrieditem != GM.noone:
		mouthholder = int(G.carrieditem)
		G.carrieditem = GM.noone
		mouthsprite = int(G.carriedsprite)
		# ORIG-BUG: 原版清的是 carritedsprite（拼写错误），carriedsprite 没清
		G.carritedsprite = GM.noone
	s_yoshi_jump = A.spr_yoshi_jump
	s_yoshi_swallow = A.spr_yoshi_swallow
	s_yoshi_lick = A.spr_yoshi_lick
	s_yoshi_fm_wait = A.spr_yoshi_fm_wait
	s_yoshi_wait = A.spr_yoshi_wait
	s_yoshi_fm = A.spr_yoshi_fm
	s_yoshi = A.spr_yoshi
	s_yoshi_fm_jump = A.spr_yoshi_fm_jump


# from objects/obj_yoshi2/Destroy_0.gml
func _destroy() -> void:
	G.yoshi = 0.0
	GM.audio_stop_sound(A.snd_yoshi_lick)
	for inst in GM.with_list(A.obj_tongue):
		inst.instance_destroy()
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.visible = true


# from objects/obj_yoshi2/Step_2.gml
func _step_end() -> void:
	var mario
	if GM.keyboard_check_pressed(G.saltar) and not GM.keyboard_check_released(G.saltar):
		jump = 1.0
	elif GM.keyboard_check_released(G.saltar):
		jump = 0.0
	# region Yoshi Logic
	if GM.instance_exists(A.obj_frozenmario):
		_user_1()
	if GM.instance_exists(A.obj_mario):
		if G.powerup == -82.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			_user_1()
		mario = GM.instance_find(A.obj_mario, 0)
		x = mario.x
		y = (mario.y + 16.0)
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 3.0
		if GM.keyboard_check_pressed(G.lanzar_agarrar) and licking == 0.0 and mario.disablecontrols == 0.0 and turning == 0.0:
			if mouthholder == null and color != 1.0:
				if not GM.audio_is_playing(A.snd_yoshi_lick):
					GM.audio_play_sound(A.snd_yoshi_lick, 0.0, false)
				licking = 1.0
				alarm[0] = 5.0
				anim = 0.0
				if mario.vspeed == 0.0:
					locked = 2.0
				else:
					locked = 1.0
			else:
				_user_0()
		if color == 2.0:
			if jump == 1.0:
				# If Yoshi can flutter and it is moving down
				if (flutter == 0.0) and (mario.vspeed >= 2.0):
					# Allow fluttering
					flutter = 1.0
				# If Yoshi is fluttering
				elif flutter == 1.0:
					# Increment flutter time
					fluttertime += 2.0
					# If flutter time is lower than 120
					if fluttertime < 120.0:
						# Make the player ascend
						for inst in GM.with_list(A.obj_mario):
							inst.gravity = 0.0
							# Increment vertical movement
							if inst.vspeed > 0.0:
								inst.vspeed -= 0.4
							else:
								inst.vspeed -= 0.5
								if inst.vspeed < -2.2:
									inst.vspeed = -2.2
					else:
						# End flutter
						flutter = 2.0
			elif (flutter == 1.0) or (mario.vspeed < -2.3):
				# End flutter
				flutter = 2.0
			# Force end flutter if not jumping
			if (flutter == 1.0) and (mario.state != 2.0):
				# End flutter
				flutter = 2.0
		# Force end flutter if not jumping
		if mouthholder != null:
			_user_3()
		for inst in GM.with_list(A.obj_mario):
			inst.mask_index = A.spr_bigmask
		if (mario.state == 2.0) or (mario.statedelay > 0.0):
			jumping = 1.0
		else:
			# End jumping
			jumping = 0.0
			# Allow fluttering
			flutter = 0.0
			if fluttertime > 0.0:
				fluttertime = 0.0
	else:
		if GM.instance_exists(A.obj_player_goal_smw):
			visible = false
			x = GM.instance_find(A.obj_player_goal_smw, 0).x
			y = GM.instance_find(A.obj_player_goal_smw, 0).y
			if mouthholder != null:
				mouthholder = null
				mouthsprite = null
		_user_15()
		if GM.instance_exists(follow):
			x = follow.x
			y = follow.y
			depth = follow.depth
	# endregion
	# region Animations
	if GM.instance_exists(A.obj_mario):
		mario = GM.instance_find(A.obj_mario, 0)
		if licking > 0.5:
			if mario.vspeed == 0.0:
				locked = 2.0
			else:
				locked = 1.0
			if locked == 1.0:
				sprite_index = s_yoshi_swallow
				image_speed = 0.0
				if mario.vspeed != 0.0:
					if mario.vspeed < 0.0:
						image_index = 1.0
					elif mario.vspeed > 0.0:
						image_index = 2.0
				else:
					image_index = 0.0
			else:
				sprite_index = s_yoshi_lick
				image_speed = 0.0
				image_index = anim
		elif licking <= 0.5:
			if mario.isduck == 1.0:
				if mouthholder != null:
					sprite_index = s_yoshi_fm_wait
					image_speed = 0.0
					image_index = 2.0
				elif mouthholder == null:
					sprite_index = s_yoshi_wait
					image_speed = 0.0
					image_index = 0.0
			elif mario.state == 0.0:
				if mouthholder != null:
					sprite_index = s_yoshi_fm
					image_speed = 0.0
					image_index = 0.0
				elif mouthholder == null:
					sprite_index = s_yoshi
					image_speed = 0.0
					image_index = 0.0
			elif mario.state == 1.0:
				if mouthholder != null:
					sprite_index = s_yoshi_fm
					image_speed = (0.13 + (absf(mario.hspeed) / 7.5))
				elif mouthholder == null:
					if sprite_index == A.spr_yoshi_turn:
						if mario.direct_turn == 1.0:
							if image_index <= 1.0:
								sprite_index = s_yoshi
								image_index = 0.0
							else:
								image_speed = -0.15
						elif image_index >= 4.8:
							sprite_index = s_yoshi
							image_index = 0.0
							for inst in GM.with_list(A.obj_mario):
								inst.direct = (-inst.direct)
						else:
							image_speed = 0.5
					else:
						sprite_index = s_yoshi
						image_speed = (0.13 + (absf(mario.hspeed) / 7.5))
			elif mario.state == 2.0:
				if mouthholder != null:
					sprite_index = s_yoshi_fm_jump
					image_speed = 0.0
					if mario.vspeed < 0.0:
						image_index = 0.0
					else:
						image_index = 1.0
				elif mouthholder == null:
					sprite_index = s_yoshi_jump
					image_speed = 0.0
					if mario.vspeed < 0.0:
						image_index = 0.0
					else:
						image_index = 1.0
	if GM.instance_exists(A.obj_mario):
		mario = GM.instance_find(A.obj_mario, 0)
		x = mario.x
		y = (mario.y + 16.0)
		if licking > 0.5:
			if jumping == 0.0:
				f = 21.0
			elif locked == 2.0:
				f = 21.0
			else:
				f = 25.0
		elif turning == 1.0:
			f = 25.0
		elif mario.isduck == 1.0:
			f = 21.0
		else:
			f = 25.0
		if turning == 0.0 and licking == 0.0:
			direct = mario.direct
	if sprite_index == s_yoshi or sprite_index == s_yoshi_fm:
		if image_index > 0.99:
			myy = 1.0
		else:
			myy = 0.0
	else:
		myy = 0.0
	if color == 2.0:
		if GM.instance_exists(A.obj_mario):
			mario = GM.instance_find(A.obj_mario, 0)
			if mario.state == 1.0 or mario.state == 2.0 or flutter == 1.0:
				if GM.instance_exists(A.obj_levelmanager):
					flyanim = GM.instance_find(A.obj_levelmanager, 0).anim
				else:
					flyanim = -1.0
			else:
				flyanim = -1.0
	# endregion


# from objects/obj_yoshi2/Alarm_0.gml
func _alarm_0() -> void:
	anim = 1.0
	GM.instance_create(x, y, A.obj_tongue)


# from objects/obj_yoshi2/Alarm_1.gml
func _alarm_1() -> void:
	anim = 0.0
	alarm[2] = 5.0


# from objects/obj_yoshi2/Alarm_2.gml
func _alarm_2() -> void:
	licking = 0.0
	turning = 0.0
	if powerup != null:
		GM.instance_create(x, y, int(powerup))
		powerup = null


# from objects/obj_yoshi2/Alarm_4.gml
func _alarm_4() -> void:
	# / @description Allow flutter
	flutter = 0.0
	if fluttertime > 0.0:
		fluttertime = 0.0


# from objects/obj_yoshi2/Other_10.gml
func _user_0() -> void:
	var vall: float
	var mario = GM.instance_find(A.obj_mario, 0)
	# mouthsprite 为 noone（null）时 sprite_index 取 -4（原版 sprite_index = noone）
	var ms: int = GM.noone if mouthsprite == null else int(mouthsprite)
	GM.audio_play_sound(A.snd_yoshi_spit, 0.0, false)
	if mario.isduck == 1.0:
		if mouthholder == A.obj_podoboo:
			mouthholder = A.obj_yoshifire
		locked = 2.0
		# UNSURE: mouthholder 为 noone（null）时走 default 分支，int(null) 会报错；原版 instance_create(…, noone) 的行为未知
		match mouthholder:
			A.obj_bones_yoshi_one:
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi_one)):
					inst.hspeed = (1.0 * GM.gm_sign(mario.direct))
			A.obj_bones_yoshi:
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
					inst.alarm[1] = 4.0
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
					inst.alarm[2] = 4.0
			A.obj_yoshifire_one:
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_one)
			A.obj_yoshifire:
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
					inst.alarm[1] = 4.0
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
					inst.alarm[2] = 4.0
			A.obj_yoshifire_purple:
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_purple)):
					inst.alarm[1] = 4.0
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_purple)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_purple)):
					inst.alarm[2] = 4.0
			A.obj_spike_ball:
				if mario.direct > 0.0:
					vall = (x + 12.0)
				else:
					vall = (x - 26.0)
				for inst in GM.with_list(GM.instance_create(vall, (y - 12.0), int(mouthholder))):
					inst.hspeed = ((2.8 + absf(mario.hspeed)) * GM.gm_sign(mario.direct))
					inst.ready_v = 1.0
					inst.fisica = 1.0
					inst.alarm[0] = 10.0
			_:
				if mario.direct > 0.0:
					vall = (x + 10.0)
				else:
					vall = (x - 24.0)
				for inst in GM.with_list(GM.instance_create(vall, (y - 12.0), int(mouthholder))):
					inst.sprite_index = ms
					if inst.object_index == A.obj_brohammer_yoshi:
						inst.hspeed = (0.8 * mario.direct)
					elif inst.object_index == A.obj_snow_ball:
						inst.hspeed = (0.6 * mario.direct)
						inst.alarm[2] = 4.0
					else:
						inst.hspeed = (1.0 * mario.direct)
					inst.y -= 1.0
	else:
		if mouthholder == A.obj_podoboo:
			mouthholder = A.obj_yoshifire
		elif mouthholder == A.obj_shell_drybones:
			mouthholder = A.obj_shell_drybones_held
		elif mouthholder == A.obj_shell or mouthholder == A.obj_shell_empty or mouthholder == A.obj_spiny_empty:
			mouthholder = A.obj_shell_held
		elif mouthholder == A.obj_snow_ball:
			mouthholder = A.obj_snow_ball_held
		locked = 1.0
		match mouthholder:
			A.obj_bones_yoshi_one:
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi_one)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
			A.obj_bones_yoshi:
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
					inst.alarm[1] = 4.0
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_bones_yoshi)):
					inst.hspeed = (1.5 * GM.gm_sign(mario.direct))
					inst.alarm[2] = 4.0
			A.obj_yoshifire_one:
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_one)
			A.obj_yoshifire:
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
					inst.alarm[1] = 4.0
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire)):
					inst.alarm[2] = 4.0
			A.obj_yoshifire_purple:
				GM.audio_play_sound(A.snd_flames, 0.0, false)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_purple)):
					inst.alarm[1] = 4.0
				GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_purple)
				for inst in GM.with_list(GM.instance_create((x + (10.0 * mario.direct)), (y - 12.0), A.obj_yoshifire_purple)):
					inst.alarm[2] = 4.0
			A.obj_spike_ball:
				if mario.direct > 0.0:
					vall = (x + 10.0)
				else:
					vall = (x - 24.0)
				for inst in GM.with_list(GM.instance_create(vall, (y - 16.0), int(mouthholder))):
					inst.ready_v = 1.0
					inst.fisica = 1.0
					inst.hspeed = ((2.8 + absf(mario.hspeed)) * GM.gm_sign(mario.direct))
					inst.alarm[0] = 10.0
			_:
				if mario.direct > 0.0:
					vall = (x + 10.0)
				else:
					vall = (x - 24.0)
				for inst in GM.with_list(GM.instance_create(vall, (y - 16.0), int(mouthholder))):
					inst.sprite_index = ms
					inst.direct = image_xscale
					if inst.object_index == A.obj_block_pow_hold:
						inst.explode = 1.0
					if inst.object_index == A.obj_spike_ball:
						inst.hspeed = (1.2 * GM.gm_sign(mario.direct))
						inst.ready_v = 1.0
						inst.fisica = 1.0
					elif inst.object_index == A.obj_snow_ball_held:
						inst.hspeed = (3.2 * GM.gm_sign(mario.direct))
						inst.fisica = 1.0
						inst.alarm[0] = 10.0
					elif inst.object_index == A.obj_bones_yoshi or inst.object_index == A.obj_bones_yoshi_one:
						inst.hspeed = (0.5 * GM.gm_sign(mario.direct))
					elif inst.sprite_index == A.spr_shell or inst.sprite_index == A.spr_shell_red or inst.sprite_index == A.spr_shell_buzzy_empty or inst.sprite_index == A.spr_shell_spiny_empty:
						inst.prevhspeed = ((2.8 + absf(mario.hspeed)) * GM.gm_sign(mario.direct))
						inst.hspeed = ((2.8 + absf(mario.hspeed)) * GM.gm_sign(mario.direct))
						inst.ready_v = 1.0
						if inst.place_meeting(inst.x, inst.y, A.obj_solid) or inst.place_meeting(inst.x, inst.y, A.obj_physicssolid) or inst.place_meeting(inst.x, inst.y, A.obj_bullebill_base):
							var _o: GMObject = GM.other
							GM.other = self
							inst.event_user(0)
							GM.other = _o
					elif (inst.collision_rectangle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, A.obj_solid, false, false) == null) and (inst.collision_rectangle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, A.obj_physicssolid, false, false) == null) and (inst.collision_rectangle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, A.obj_bullebill_base, false, false) == null):
						if inst.object_index == A.obj_mushroom or inst.object_index == A.obj_1up or inst.object_index == A.obj_star:
							inst.hspeed = ((1.0 - (0.5 * mario.isswim)) * mario.direct)
						else:
							inst.hspeed = (mario.direct + ((2.5 - (1.5 * mario.isswim)) * mario.direct))
					else:
						inst.inwall = 1.0
	mouthholder = null
	mouthsprite = null
	licking = 1.0
	alarm[2] = 5.0
	anim = 0.0


# from objects/obj_yoshi2/Other_11.gml
func _user_1() -> void:
	if color == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_yoshi_abandon)):
			if self.mouthholder != null:
				inst.mouthholder = self.mouthholder
				inst.mouthsprite = self.mouthsprite
			inst.direct = self.direct
	elif color == 1.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_yoshi_abandon)):
			inst.color = 1.0
			if self.mouthholder != null:
				inst.mouthholder = self.mouthholder
				inst.mouthsprite = self.mouthsprite
			inst.direct = self.direct
	elif color == 2.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_yoshi_abandon)):
			inst.color = 2.0
			if self.mouthholder != null:
				inst.mouthholder = self.mouthholder
				inst.mouthsprite = self.mouthsprite
			inst.direct = self.direct
	instance_destroy()


# from objects/obj_yoshi2/Other_12.gml
func _user_2() -> void:
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)
		if licking == 1.0:
			sprite_mario = Scr.scr_mario_yoshi_atack(self)
			index_mario = image_index
			x_mario = (GM.gm_round(x) + mario.shake)
			y_mario = (GM.gm_round(y) - f)
		elif mario.isduck == 1.0:
			sprite_mario = Scr.scr_mario_yoshi_crouch(self)
			index_mario = 0.0
			x_mario = (GM.gm_round(x) + mario.shake)
			y_mario = (GM.gm_round(y) - f)
		else:
			sprite_mario = Scr.scr_marioride(self)
			index_mario = image_index
			x_mario = (GM.gm_round(x) + mario.shake)
			y_mario = (GM.gm_round(y) - f)
		GM.draw_sprite_ext(sprite_mario, index_mario, x_mario, y_mario, GM.instance_find(A.obj_yoshi2, 0).direct, 1.0, 0.0, GM.c_white, mario.image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_mario, index_mario, x_mario, y_mario, GM.instance_find(A.obj_yoshi2, 0).direct, 1.0, 0.0, mario.blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()


# from objects/obj_yoshi2/Other_13.gml
func _user_3() -> void:
	stateprev = GM.instance_find(A.obj_mario, 0).state


# from objects/obj_yoshi2/Other_25.gml
func _user_15() -> void:
	follow = null  # 原版 follow = 0（实例变量约定用 null，见 §3.3 第 15 条）


# from objects/obj_yoshi2/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)
		var offsety: float
		if turning != 0.0:
			_user_2()
			GM.draw_sprite_ext(sprite_index, -1.0, (GM.gm_round(x) + mario.shake), GM.gm_round(y), direct, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(sprite_index, -1.0, (GM.gm_round(x) + mario.shake), GM.gm_round(y), direct, 1.0, 0.0, GM.c_white, 1.0)
			_user_2()
		if mario.isduck == 1.0:
			offsety = 2.0
		else:
			offsety = 0.0
		if color == 2.0:
			GM.draw_sprite_ext(sprite_wings, flyanim, (GM.gm_round(x) + mario.shake - 6.0 * direct), GM.gm_round(y) - 22.0 + offsety, direct, 1.0, 0.0, GM.c_white, 1.0)
