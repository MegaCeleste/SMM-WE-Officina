# 第 7 批移植，已核对。
# PORT: obj_x.foo 的读取（第 16 条）在方法开头取一次实例放进不带类型的局部变量（_mario、_shoe…）；
# 原文每次读取都有同一 object 的 instance_exists 守卫（或者原文本身不守卫），取到 null 时不会被解引用，与逐次读取等价。
extends GMObject

var s_brickhelmet_2: int = 0  ## sprite 编号
var s_brickhelmet: int = 0  ## sprite 编号
var s_brickhelmet_3: int = 0  ## sprite 编号（只在 SMW 画风赋值）
var index: float = 0.0
var rotacion: float = 0.0
var rot: float = 0.0
var up: float = 0.0
var pos_y: float = 0.0  # obj_snowball_bro/Collision_obj_mario 读
var direct: float = 0.0
var vvelocidad: float = 0.0
var fallow: int = 0  ## 存 object 编号（不是实例）：obj_lighting 表示“没有”，否则是 _user_12 里选出的 object
var repeat_coins: float = 0.0
var get_coin: float = 0.0
var limit_coins: float = 0.0
var imdead = null


# from objects/obj_brickhelmet/Create_0.gml
func _create() -> void:
	# event_inherited(): 父类无此事件
	match G.apariencia:
		0.0:
			if G.jugador < 2.0:
				s_brickhelmet_2 = A.spr_SMB_brickhelmet_mega
				s_brickhelmet = A.spr_SMB_brickhelmet
			else:
				s_brickhelmet_2 = A.spr_SMB_brickhelmet_mega_t
				s_brickhelmet = A.spr_SMB_brickhelmet_t
		1.0:
			if G.jugador < 2.0:
				s_brickhelmet_2 = A.spr_SMB3_brickhelmet_round
				s_brickhelmet = A.spr_SMB3_brickhelmet
			else:
				s_brickhelmet_2 = A.spr_SMB3_brickhelmet_round_t
				s_brickhelmet = A.spr_SMB3_brickhelmet_t
		2.0:
			if G.jugador < 2.0:
				s_brickhelmet_3 = A.spr_brickhelmet_yoshi
				s_brickhelmet_2 = A.spr_brickhelmet_up
				s_brickhelmet = A.spr_brickhelmet
			else:
				s_brickhelmet_3 = A.spr_brickhelmet_yoshi_t
				s_brickhelmet_2 = A.spr_brickhelmet_up_t
				s_brickhelmet = A.spr_brickhelmet_t
	image_speed = 0.0
	image_index = 0.0
	index = 0.0
	rotacion = 0.0
	rot = 1.0
	up = 0.0
	pos_y = 21.0
	direct = 1.0
	gravity = 0.0
	vvelocidad = 0.0
	fallow = A.obj_lighting
	repeat_coins = 60.0
	get_coin = 0.0
	limit_coins = 200.0
	hspeed = 0.0
	_user_6()
	alarm[4] = 60.0


# from objects/obj_brickhelmet/Step_0.gml
func _step() -> void:
	var _mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		vvelocidad = _mario.vspeed
	speed = 0.0
	gravity = 0.0
	if GM.instance_exists(A.obj_helmet_spiny):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_helmet_spiny):
			inst.event_user(5)
		GM.other = _o
	elif GM.instance_exists(A.obj_helmet):
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_helmet):
			inst.event_user(5)
		GM.other = _o2
	if GM.instance_exists(A.obj_mario_pballon):
		_user_5()


# from objects/obj_brickhelmet/Step_2.gml
func _step_end() -> void:
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _dry = GM.instance_find(A.obj_kuribo_drybones, 0)
	var _yoshi = GM.instance_find(A.obj_yoshi2, 0)
	if GM.instance_exists(A.obj_mario):
		if G.powerup == -29.0 or G.powerup == -38.0 or G.powerup == -43.0 or G.powerup == -30.0:
			for inst in GM.with_list(A.obj_mario):
				inst.helmet = 0.0
			_user_5()
			return
		if G.jugador == 0.0:
			_user_8()
		elif G.jugador == 1.0:
			_user_9()
		elif G.jugador > 1.0:
			_user_10()
		if G.apariencia == 0.0 and _mario.state == 3.0:
			if G.powerup == -77.0:
				x = (_mario.x - (12.0 * direct))
			else:
				x = (_mario.x - (6.0 * direct))
		else:
			x = _mario.x
		y = (_mario.y + pos_y)
		if GM.instance_exists(A.obj_kuriboshoe) or GM.instance_exists(A.obj_kuribo_drybones):
			depth = -12.0
		else:
			depth = -9.0
		if GM.instance_exists(A.obj_kuribo_drybones) and _dry.invincible == 1.0:
			image_alpha = 0.0
		elif _mario.invincible == 1.0 and (not GM.instance_exists(A.obj_invincibility)):
			image_alpha = _mario.image_alpha
		else:
			image_alpha = 1.0
		if _mario.stompstyle == 1.0:
			direct = 1.0
		elif GM.instance_exists(A.obj_yoshi2):
			direct = _yoshi.direct
		else:
			direct = _mario.direct
		if (not GM.instance_exists(A.obj_mario_transform2)) and _mario.state != 3.0:
			_user_7()
		if _mario.state == 3.0:
			rotacion = 0.0
			rotacion = 0.0
			rot = 1.0
			up = 0.0
		if absf(_mario.hspeed) <= 1.3:
			repeat_coins = 30.0
		elif absf(_mario.hspeed) > 1.3 and absf(_mario.hspeed) < 2.3:
			repeat_coins = 15.0
		else:
			repeat_coins = 6.0
		_user_6()
	else:
		_user_12()
		if fallow != A.obj_lighting and GM.instance_exists(fallow):
			_user_13()
			var _f = GM.instance_find(fallow, 0)  # PORT: fallow 存的是 object 编号，fallow.foo 是读它的第一个实例（第 16 条）
			# ORIG-BUG: fallow 只会是 obj_doormario/obj_doormario_exit/obj_player_warp/obj_player_goal_parent（见 Other_22），
			# 和 obj_player_goal_smb1（子类编号）比较恒为假，这个分支走不到
			if fallow == A.obj_player_goal_smb1 and _f.sprite_index == Scr.scr_marioclimb(self):
				if G.powerup == -77.0:
					x = (_f.x - (12.0 * _f.direct))
				else:
					x = (_f.x - (6.0 * _f.direct))
			else:
				x = _f.x
			y = (_f.y + pos_y)
			if _f.object_index == A.obj_player_warp:
				depth = 12.0
			elif GM.instance_exists(A.obj_kuriboshoe) or GM.instance_exists(A.obj_kuribo_drybones):
				depth = -12.0
			else:
				depth = -9.0
			image_alpha = 1.0
			direct = _f.direct
			_user_7()
			_user_6()


# from objects/obj_brickhelmet/Alarm_4.gml
func _alarm_4() -> void:
	var _mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario) and _mario.hspeed != 0.0:
		if get_coin >= limit_coins:
			GM.instance_create(x, y, A.obj_smoke)
			for inst in GM.with_list(A.obj_mario):
				inst.helmet = 0.0
			instance_destroy()
		else:
			GM.instance_create((x - 8.0), y, A.obj_blockcoin)
			get_coin += 1.0
			alarm[4] = repeat_coins
	else:
		alarm[4] = repeat_coins


# from objects/obj_brickhelmet/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	gravity = 0.0
	speed = 0.0


# from objects/obj_brickhelmet/Other_15.gml
func _user_5() -> void:
	var _mario = GM.instance_find(A.obj_mario, 0)
	if not GM.instance_exists(A.obj_player_goal_parent):
		GM.audio_play_sound(A.snd_helmet_remove, 0.0, false)
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	imdead.girar = 1.0
	imdead.direct = direct
	if _mario.hspeed == 0.0:
		# ORIG-BUG: bbox_left + bbox_right / 2 少了括号，不是中心点（两边写法相同，照搬）
		if (_mario.bbox_left + (_mario.bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (_mario.bbox_left + (_mario.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif _mario.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif _mario.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_brickhelmet/Other_16.gml
func _user_6() -> void:
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _spinner = GM.instance_find(A.obj_spinner, 0)
	var _goal_smw = GM.instance_find(A.obj_player_goal_smw, 0)
	match G.apariencia:
		0.0:
			if G.powerup == -77.0:
				sprite_index = s_brickhelmet_2
			else:
				sprite_index = s_brickhelmet
			if direct == 1.0:
				index = 0.0
			else:
				index = 1.0
		1.0:
			if GM.instance_exists(A.obj_mario) and _mario.sprite_index == Scr.scr_marioclimb(self):
				sprite_index = s_brickhelmet_2
				index = 2.0
			elif GM.instance_exists(A.obj_spinner):
				sprite_index = s_brickhelmet_2
				index = _spinner.image_index
			else:
				sprite_index = s_brickhelmet
				index = 0.0
		2.0:
			if GM.instance_exists(A.obj_player_goal_smw) and _goal_smw.pose == 1.0:
				sprite_index = s_brickhelmet
				index = 1.0
			elif GM.instance_exists(A.obj_yoshi2):
				sprite_index = s_brickhelmet_3
			elif GM.instance_exists(A.obj_mario) and _mario.sprite_index == Scr.scr_marioclimb(self):
				sprite_index = s_brickhelmet
				index = 3.0
			elif GM.instance_exists(A.obj_mario) and (_mario.stompstyle == 1.0 or _mario.caped > 0.0):
				sprite_index = s_brickhelmet
				index = _mario.image_index
			elif GM.instance_exists(A.obj_mario) and (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
				sprite_index = s_brickhelmet_2
			else:
				sprite_index = s_brickhelmet
				index = 0.0
		3.0:
			if GM.instance_exists(A.obj_mario) and _mario.airspin == 1.0:
				sprite_index = s_brickhelmet_3
				index = _mario.image_index
			elif GM.instance_exists(A.obj_mario) and _mario.stompstyle == 1.0:
				sprite_index = s_brickhelmet_2
				index = _mario.image_index
			else:
				sprite_index = s_brickhelmet
				index += 0.3


# from objects/obj_brickhelmet/Other_17.gml
func _user_7() -> void:
	var m_speed: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	var _mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if _mario.state == 1.0:
			m_speed = (absf(_mario.hspeed) + 1.0)
			if rot == 1.0:
				if up == 0.0:
					if rotacion > -5.0:
						rotacion -= m_speed
					else:
						up = 1.0
				elif up == 1.0:
					if rotacion < 5.0:
						rotacion += m_speed
					else:
						up = 0.0
		else:
			up = 0.0
			rotacion = 0.0
	elif fallow != A.obj_lighting and GM.instance_exists(fallow):
		var _f = GM.instance_find(fallow, 0)  # PORT: fallow 存的是 object 编号（第 16 条）
		if _f.hspeed != 0.0:
			m_speed = (absf(_f.hspeed) + 1.0)
			if rot == 1.0:
				if up == 0.0:
					if rotacion > -5.0:
						rotacion -= m_speed
					else:
						up = 1.0
				elif up == 1.0:
					if rotacion < 5.0:
						rotacion += m_speed
					else:
						up = 0.0
		else:
			up = 0.0
			rotacion = 0.0


# from objects/obj_brickhelmet/Other_18.gml
func _user_8() -> void:
	var off: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _shoe = GM.instance_find(A.obj_kuriboshoe, 0)
	var _dry = GM.instance_find(A.obj_kuribo_drybones, 0)
	var _yoshi = GM.instance_find(A.obj_yoshi2, 0)
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif G.powerup == -77.0:
					if _mario.isduck == 1.0:
						pos_y = -8.0
					else:
						pos_y = (-14.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 11.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (10.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				if _mario.isduck == 1.0:
					pos_y = 18.0
				else:
					pos_y = 15.0
			elif G.powerup == -78.0:
				if _mario.isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = 0.0
			elif G.powerup == -77.0:
				if _mario.isduck == 1.0:
					pos_y = 6.0
				else:
					pos_y = -2.0
			elif _mario.isduck == 1.0:
				pos_y = 13.0
			else:
				pos_y = 5.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				if _mario.isduck == 1.0:
					pos_y = 18.0
				else:
					pos_y = 15.0
			elif G.powerup == -29.0 and _mario.holding == 0.0:
				if _mario.isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 13.0
			elif _mario.isduck == 1.0:
				pos_y = 17.0
			else:
				pos_y = 8.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if _mario.state == 0.0:
					off = _dry.offset
				else:
					off = (_dry.offset - 2.0)
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if _yoshi.licking > 0.5:  # GML: if obj_yoshi2.licking
					if _yoshi.jumping == 0.0:
						if G.powerup == 0.0:
							pos_y = 8.0
						else:
							pos_y = 3.0
					elif _yoshi.locked == 2.0:
						if G.powerup == 0.0:
							pos_y = 9.0
						else:
							pos_y = 3.0
					elif G.powerup == 0.0:
						pos_y = 4.0
					else:
						pos_y = -1.0
				elif G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = 3.0
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
					pos_y = 16.0
				elif _mario.isduckhold == 1.0:
					pos_y = 19.0
				elif _mario.isduck == 1.0:
					pos_y = 21.0
				else:
					pos_y = 15.0
			elif (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
				pos_y = 12.0
			elif _mario.isduckhold == 1.0:
				pos_y = 16.0
			elif _mario.isduck == 1.0:
				pos_y = 20.0
			else:
				pos_y = 9.0
		elif G.apariencia == 3.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if _mario.state == 0.0:
					off = _dry.offset
				else:
					off = (_dry.offset - 2.0)
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif G.powerup == 0.0:
				if _mario.isduck == 1.0:
					pos_y = 14.0
				else:
					pos_y = 9.0
			elif _mario.isduck == 1.0:
				pos_y = 12.0
			else:
				pos_y = 0.0


# from objects/obj_brickhelmet/Other_19.gml
func _user_9() -> void:
	var off: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _shoe = GM.instance_find(A.obj_kuriboshoe, 0)
	var _dry = GM.instance_find(A.obj_kuribo_drybones, 0)
	var _yoshi = GM.instance_find(A.obj_yoshi2, 0)
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif G.powerup == -77.0:
					if _mario.isduck == 1.0:
						pos_y = -8.0
					else:
						pos_y = (-14.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 11.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (10.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				if _mario.isduck == 1.0:
					pos_y = 19.0
				else:
					pos_y = 16.0
			elif G.powerup == -78.0:
				if _mario.isduck == 1.0:
					pos_y = 13.0
				else:
					pos_y = 0.0
			elif G.powerup == -77.0:
				if _mario.isduck == 1.0:
					pos_y = 8.0
				else:
					pos_y = 0.0
			elif _mario.isduck == 1.0:
				pos_y = 11.0
			else:
				pos_y = 2.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				if _mario.isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 17.0
			elif _mario.isduck == 1.0:
				pos_y = 17.0
			else:
				pos_y = 8.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if _mario.state == 0.0:
					off = _dry.offset
				else:
					off = (_dry.offset - 2.0)
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if _yoshi.licking > 0.5:  # GML: if obj_yoshi2.licking
					if _yoshi.jumping == 0.0:
						if G.powerup == 0.0:
							pos_y = 8.0
						else:
							pos_y = 3.0
					elif _yoshi.locked == 2.0:
						if G.powerup == 0.0:
							pos_y = 9.0
						else:
							pos_y = 3.0
					elif G.powerup == 0.0:
						pos_y = 4.0
					else:
						pos_y = -1.0
				elif G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = 3.0
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
					pos_y = 15.0
				elif _mario.isduckhold == 1.0:
					pos_y = 18.0
				elif _mario.isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 14.0
			elif (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
				pos_y = 11.0
			elif _mario.isduckhold == 1.0:
				pos_y = 15.0
			elif _mario.isduck == 1.0:
				pos_y = 19.0
			else:
				pos_y = 8.0


# from objects/obj_brickhelmet/Other_20.gml
func _user_10() -> void:
	var off: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _shoe = GM.instance_find(A.obj_kuriboshoe, 0)
	var _dry = GM.instance_find(A.obj_kuribo_drybones, 0)
	var _yoshi = GM.instance_find(A.obj_yoshi2, 0)
	if GM.instance_exists(A.obj_mario):
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if _mario.isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = (11.0 - off)
				elif G.powerup == -77.0:
					if _mario.isduck == 1.0:
						pos_y = -7.0
					else:
						pos_y = (-12.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (9.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					if _mario.isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = (12.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 11.0
				else:
					pos_y = (9.0 - off)
			elif G.powerup == 0.0 or G.powerup == -85.0:
				if _mario.isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 18.0
			elif G.powerup == -78.0:
				if _mario.isduck == 1.0:
					pos_y = 14.0
				else:
					pos_y = 2.0
			elif G.powerup == -77.0:
				if _mario.isduck == 1.0:
					pos_y = 8.0
				else:
					pos_y = 2.0
			elif _mario.isduck == 1.0:
				pos_y = 14.0
			else:
				pos_y = 8.0
		elif G.apariencia == 1.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 12.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 12.0
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (5.0 - off)
			elif G.powerup == 0.0:
				if _mario.isduck == 1.0:
					pos_y = 21.0
				else:
					pos_y = 18.0
			elif _mario.isduck == 1.0:
				pos_y = 17.0
			else:
				pos_y = 9.0
		elif G.apariencia == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if _mario.state == 0.0:
					off = _dry.offset
				else:
					off = (_dry.offset - 2.0)
				if G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 11.0
					else:
						pos_y = (9.0 - off)
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_yoshi2):
				if _yoshi.licking > 0.5:  # GML: if obj_yoshi2.licking
					if _yoshi.jumping == 0.0:
						if G.powerup == 0.0:
							pos_y = 8.0
						else:
							pos_y = 3.0
					elif _yoshi.locked == 2.0:
						if G.powerup == 0.0:
							pos_y = 9.0
						else:
							pos_y = 3.0
					elif G.powerup == 0.0:
						pos_y = 4.0
					else:
						pos_y = -1.0
				elif G.powerup == 0.0:
					if _mario.isduck == 1.0:
						pos_y = 13.0
					else:
						pos_y = 3.0
				elif _mario.isduck == 1.0:
					pos_y = 10.0
				else:
					pos_y = -1.0
			elif G.powerup == 0.0:
				if (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
					pos_y = 17.0
				elif _mario.isduckhold == 1.0:
					pos_y = 19.0
				elif _mario.isduck == 1.0:
					pos_y = 20.0
				else:
					pos_y = 16.0
			elif (_mario.isup == 1.0 or _mario.isuphold == 1.0) and _mario.state == 0.0:
				pos_y = 12.0
			elif _mario.isduckhold == 1.0:
				pos_y = 17.0
			elif _mario.isduck == 1.0:
				pos_y = 20.0
			else:
				pos_y = 11.0


# from objects/obj_brickhelmet/Other_22.gml
func _user_12() -> void:
	if GM.instance_exists(A.obj_doormario):
		fallow = A.obj_doormario
	elif GM.instance_exists(A.obj_doormario_exit):
		fallow = A.obj_doormario_exit
	elif GM.instance_exists(A.obj_player_warp):
		fallow = A.obj_player_warp
	elif GM.instance_exists(A.obj_player_goal_parent):
		fallow = A.obj_player_goal_parent


# from objects/obj_brickhelmet/Other_23.gml
func _user_13() -> void:
	var off: float = 0.0  # 局部变量提升（GML 的 var 是函数作用域）
	var _shoe = GM.instance_find(A.obj_kuriboshoe, 0)
	var _dry = GM.instance_find(A.obj_kuribo_drybones, 0)
	if GM.instance_exists(fallow):
		var _f = GM.instance_find(fallow, 0)  # PORT: fallow 存的是 object 编号，fallow.foo 是读它的第一个实例（第 16 条）
		# ORIG-BUG: fallow 不会等于 obj_player_goal_smw（Other_22 只会选父类 obj_player_goal_parent），这一句走不到
		if fallow == A.obj_player_goal_smw and _f.pose == 1.0:
			visible = false
		if G.apariencia == 0.0:
			if GM.instance_exists(A.obj_kuriboshoe):
				off = _shoe.offset
				if G.powerup == 0.0 or G.powerup == -85.0:
					pos_y = (9.0 - off)
				elif G.powerup == -77.0:
					pos_y = (-14.0 - off)
				else:
					pos_y = (7.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
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
				off = _shoe.offset
				if G.powerup == 0.0:
					pos_y = (9.0 - off)
				else:
					pos_y = (8.0 - off)
			elif GM.instance_exists(A.obj_kuribo_drybones):
				off = _dry.offset
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
				if _f.hspeed == 0.0:
					off = _dry.offset
				else:
					off = (_dry.offset - 2.0)
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
				if _f.sprite_index == Scr.scr_marioduck(self):
					pos_y = 21.0
				else:
					pos_y = 15.0
			elif _f.sprite_index == Scr.scr_marioduck(self):
				pos_y = 20.0
			else:
				pos_y = 9.0


# from objects/obj_brickhelmet/Draw_0.gml
func _gm_draw() -> void:
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _inv = GM.instance_find(A.obj_invincibility, 0)
	GM.draw_sprite_ext(sprite_index, index, x, (y + 1.0), direct, 1.0, rotacion, GM.c_white, image_alpha)
	if GM.instance_exists(A.obj_mario):
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, index, x, (y + 1.0), direct, 1.0, rotacion, _mario.blend_star, _inv.flashAlpha)
			GM.shader_reset()
