# from objects/obj_flagpole（第 7 批移植，已核对）
extends GMObject

var check: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
var ready2: float = 0.0
var ready3: float = 0.0
var apariencia: float = 0.0
var count: Array = []  ## 按 apariencia 取计数音效
var count_end: Array = []
var flag = null  ## obj_SMB_flag 实例
var mysolid = null


# from objects/obj_flagpole/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_flagpole
		image_speed = 0.0
		if G.bg_level == "ground":
			image_index = 0.0
		elif G.bg_level == "underground":
			image_index = 1.0
		elif G.bg_level == "sky":
			image_index = 2.0
		elif G.bg_level == "airship":
			image_index = 3.0
		elif G.bg_level == "ghost":
			image_index = 4.0
		elif G.bg_level == "underwater":
			image_index = 5.0
		elif G.bg_level == "desert":
			image_index = 6.0
		elif G.bg_level == "forest":
			image_index = 7.0
		elif G.bg_level == "snow":
			image_index = 10.0
		elif G.bg_level == "mountain":
			if G.modo_noche == 0.0:
				image_index = 2.0
			else:
				image_index = 8.0
		elif G.modo_noche == 1.0:
			image_index = 9.0
		else:
			image_index = 0.0
	else:
		image_speed = 0.0
		image_index = 0.0
	check = 0.0
	alarm[2] = 10.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	apariencia = G.apariencia
	GM.aset(count, 0, A.snd_SMB_count)
	GM.aset(count, 3, A.snd_NSMBU_count)  # GML 数组自动扩展，count[1]、count[2] 是 0
	GM.aset(count_end, 0, A.snd_countend)
	GM.aset(count_end, 3, A.snd_NSMBU_countend)
	if not GM.instance_exists(A.obj_SMB_flag):
		if G.apariencia == 3.0:
			flag = GM.instance_create((x - 12.0), (y + 9.0), A.obj_SMB_flag)
		else:
			flag = GM.instance_create((x - 12.0), (y + 16.0), A.obj_SMB_flag)
	if G.apariencia == 3.0:
		mysolid = GM.instance_create(GM.instance_find(A.obj_ground3, 0).x + 4.0, (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_solid)
	else:
		mysolid = GM.instance_create(GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_solid)
	for inst in GM.with_list(mysolid):
		if G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_flag_base
			inst.image_index = 0.0
		else:
			inst.sprite_index = A.spr_SMB_block_rock
			inst.image_index = 0.0
		inst.image_speed = 0.0
		inst.visible = true


# from objects/obj_flagpole/Destroy_0.gml
func _destroy() -> void:
	if not GM.instance_exists(A.obj_flagpole):
		GM.instance_activate_object(flag)
	GM.instance_activate_object(mysolid)
	if GM.instance_exists(A.obj_SMB_flag):
		for inst in GM.with_list(A.obj_SMB_flag):
			inst.instance_destroy()
	if GM.instance_exists(mysolid):
		for inst in GM.with_list(mysolid):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_NSMBU_flag_mario):
		for inst in GM.with_list(A.obj_NSMBU_flag_mario):
			inst.instance_destroy()


# from objects/obj_flagpole/Step_2.gml
func _step_end() -> void:
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_flagpole
		else:
			sprite_index = A.spr_SMB_flagpole
	elif G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_flagpole_disabled
	else:
		sprite_index = A.spr_SMB_flagpole_disabled


# from objects/obj_flagpole/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_editormanager):
		var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
		GM.other = self
		for inst in GM.with_list(A.obj_creator_jugar_editar):
			inst.event_user(2)
		GM.other = _o
	elif G.level_g == 1.0:
		Scr.scr_init_globals(self)
		GM.room_goto(A.rm_guardabot)
	elif GM.room == A.rm_title:
		Scr.scr_restart(self)
	else:
		# UNSURE: obj_superado_bg 在原工程里没有 object 定义，a.gd 无此常量。照 obj_player_goal_smb1 的写法用 asset_get_index 取，取不到（-1）时跳过
		var _superado_bg: int = GM.asset_get_index("obj_superado_bg")
		if _superado_bg >= 0:
			GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), _superado_bg)


# from objects/obj_flagpole/Alarm_1.gml
func _alarm_1() -> void:
	if G.timer <= 0.0:
		G.timer = 0.0
	else:
		if G.timer > 4.0:
			alarm[1] = 1.0
			GM.score += 250.0
			G.timer -= 8.0
		elif G.timer < 5.0 and G.timer > 0.0:
			alarm[1] = 2.0
			GM.score += 50.0
			G.timer -= 1.0
		if ready3 == 0.0:
			if G.timer > 0.0:
				ready3 = 1.0
				GM.audio_play_sound(count[int(apariencia)], 0.0, true)
			else:
				ready3 = 2.0
				if apariencia == 3.0:
					GM.audio_play_sound(count_end[int(apariencia)], 0.0, false)
				else:
					GM.audio_stop_sound(count[int(apariencia)])
		elif G.timer < 1.0 and ready3 == 1.0:
			ready3 = 2.0
			if apariencia == 3.0:
				GM.audio_stop_sound(A.snd_NSMBU_count)
				GM.audio_play_sound(count_end[int(apariencia)], 0.0, false)
			else:
				GM.audio_stop_sound(count[int(apariencia)])


# from objects/obj_flagpole/Alarm_2.gml
func _alarm_2() -> void:
	check = 1.0


# from objects/obj_flagpole/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if (G.condiciones == 0.0) or ((G.condiciones == 1.0) and ((G.condiciones_clear == 1.0) and (check == 1.0))):
		if (other.x > x) and (other.hspeed < 0.0):
			if other.y < (y - 2.0):
				if place_meeting((x - 4.0), (y + 16.0), A.obj_solid):
					for inst in GM.with_list(GM.instance_create((x + 8.0), other.y, A.obj_player_goal_smb1)):
						inst.flagpole = self
						var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
						var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
						GM.other = inst
						for inst2 in GM.with_list(_f.flag):
							inst2.event_user(0)
						GM.other = _o
						inst.direct = -1.0
				elif other.y >= (y + 144.0):
					pass
				else:
					for inst in GM.with_list(GM.instance_create((x + 10.0), (y - 2.0), A.obj_player_goal_smb1)):
						inst.flagpole = self
						var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
						var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
						GM.other = inst
						for inst2 in GM.with_list(_f.flag):
							inst2.event_user(0)
						GM.other = _o
						inst.direct = -1.0
			else:
				for inst in GM.with_list(GM.instance_create((x + 8.0), other.y, A.obj_player_goal_smb1)):
					inst.flagpole = self
					var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
					var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
					GM.other = inst
					for inst2 in GM.with_list(_f.flag):
						inst2.event_user(0)
					GM.other = _o
					inst.direct = -1.0
		elif other.y < (y - 2.0):
			for inst in GM.with_list(GM.instance_create(x, (y - 2.0), A.obj_player_goal_smb1)):
				inst.flagpole = self
				var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
				GM.other = inst
				for inst2 in GM.with_list(_f.flag):
					inst2.event_user(0)
				GM.other = _o
		else:
			for inst in GM.with_list(GM.instance_create(x, other.y, A.obj_player_goal_smb1)):
				inst.flagpole = self
				var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
				GM.other = inst
				for inst2 in GM.with_list(_f.flag):
					inst2.event_user(0)
				GM.other = _o
		_user_0()
		for inst in GM.with_list(other):  # PORT: other.id 就是 other 本身
			inst.instance_destroy()


# from objects/obj_flagpole/Collision_obj_marioU.gml
func _collision_obj_marioU(other: GMObject) -> void:
	var ytemp
	if (G.condiciones == 0.0) or ((G.condiciones == 1.0) and ((G.condiciones_clear == 1.0) and (check == 1.0))):
		if (other.x > x) and (other.hspeed < 0.0):
			if (other.y > (y - 2.0)) or place_meeting((x - 4.0), (y + 16.0), A.obj_solid):
				if other.y >= (y + 128.0):
					ytemp = (y + 128.0)
				else:
					ytemp = other.y
				for inst in GM.with_list(GM.instance_create(x, ytemp, A.obj_player_goal_nsmbu)):
					inst.flagpole = self
					var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
					var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
					GM.other = inst
					for inst2 in GM.with_list(_f.flag):
						inst2.event_user(0)
					GM.other = _o
					inst.direct = 1.0
					inst.image_index = 4.0
			else:
				for inst in GM.with_list(GM.instance_create(x, (y - 2.0), A.obj_player_goal_nsmbu)):
					inst.flagpole = self
					var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
					var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
					GM.other = inst
					for inst2 in GM.with_list(_f.flag):
						inst2.event_user(0)
					GM.other = _o
					inst.direct = 1.0
					inst.image_index = 4.0
		elif (other.y > (y - 2.0)) or place_meeting(x, (y + 16.0), A.obj_solid):
			if other.y >= (y + 128.0):
				ytemp = (y + 128.0)
			else:
				ytemp = other.y
			for inst in GM.with_list(GM.instance_create(x, ytemp, A.obj_player_goal_nsmbu)):
				inst.flagpole = self
				var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
				GM.other = inst
				for inst2 in GM.with_list(_f.flag):
					inst2.event_user(0)
				GM.other = _o
		else:
			for inst in GM.with_list(GM.instance_create(x, (y - 2.0), A.obj_player_goal_nsmbu)):
				inst.flagpole = self
				var _f = GM.instance_find(A.obj_flagpole, 0)  # obj_flagpole.flag（第一个实例）
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）；这一层的 other 是外层 with 的 inst
				GM.other = inst
				for inst2 in GM.with_list(_f.flag):
					inst2.event_user(0)
				GM.other = _o
		_user_1()
		for inst in GM.with_list(other):  # PORT: other.id 就是 other 本身
			inst.instance_destroy()


# from objects/obj_flagpole/Other_10.gml
func _user_0() -> void:
	var _g = GM.instance_find(A.obj_player_goal_smb1, 0)  # PORT: obj_player_goal_smb1.ystart（第一个实例，含子类 nsmbu）；各分支里读的都是同一个实例，提到开头
	var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
	GM.other = self
	if (_g.ystart + 32.0) <= (y + 31.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 149.0), A.obj_score_flag)):
			inst.limit = (inst.y + 14.0)
			inst.event_user(7)
	elif (_g.ystart + 32.0) <= (y + 51.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 146.0), A.obj_score_flag)):
			inst.limit = (_g.ystart + 16.0)
			inst.event_user(6)
	elif (_g.ystart + 16.0) <= (y + 73.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 146.0), A.obj_score_flag)):
			inst.limit = (_g.ystart + 16.0)
			inst.event_user(3)
	elif (_g.ystart + 16.0) <= (y + 96.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 146.0), A.obj_score_flag)):
			inst.limit = (_g.ystart + 16.0)
			inst.event_user(2)
	elif (_g.ystart + 16.0) <= (y + 128.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 146.0), A.obj_score_flag)):
			inst.limit = (_g.ystart + 16.0)
			inst.event_user(1)
	else:
		for inst in GM.with_list(GM.instance_create((x + 12.0), (y + 146.0), A.obj_score_flag)):
			inst.limit = (_g.ystart + 16.0)
			inst.event_user(0)
	GM.other = _o


# from objects/obj_flagpole/Other_11.gml
func _user_1() -> void:
	var _g = GM.instance_find(A.obj_player_goal_smb1, 0)  # PORT: obj_player_goal_smb1.ystart（第一个实例，含子类 nsmbu）；各分支里读的都是同一个实例，提到开头
	var _gn = GM.instance_find(A.obj_player_goal_nsmbu, 0)  # PORT: obj_player_goal_nsmbu.y（第一个实例），提到开头
	var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
	GM.other = self
	if (_g.ystart + 32.0) <= (y + 31.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (_gn.y + 8.0), A.obj_score_flag)):
			inst.event_user(7)
	elif (_g.ystart + 32.0) <= (y + 51.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (_gn.y + 8.0), A.obj_score_flag)):
			inst.event_user(6)
	elif (_g.ystart + 16.0) <= (y + 73.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (_gn.y + 8.0), A.obj_score_flag)):
			inst.event_user(3)
	elif (_g.ystart + 16.0) <= (y + 96.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (_gn.y + 8.0), A.obj_score_flag)):
			inst.event_user(2)
	elif (_g.ystart + 16.0) <= (y + 128.0):
		for inst in GM.with_list(GM.instance_create((x + 12.0), (_gn.y + 8.0), A.obj_score_flag)):
			inst.event_user(1)
	else:
		for inst in GM.with_list(GM.instance_create((x + 12.0), (_gn.y + 8.0), A.obj_score_flag)):
			inst.event_user(0)
	GM.other = _o


# from objects/obj_flagpole/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, image_index, x, y)
