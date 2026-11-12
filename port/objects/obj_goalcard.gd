# from objects/obj_goalcard（第 7 批移植，已核对）
extends GMObject

var stream: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
var ready2: float = 0.0
var ready3: float = 0.0
var cardtype: float = 0.0


# from objects/obj_goalcard/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	alarm[0] = 10.0
	stream = -1.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	cardtype = 0.0


# from objects/obj_goalcard/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_ground3):
		x = GM.instance_find(A.obj_ground3, 0).x
		y = (GM.instance_find(A.obj_ground3, 0).y - 88.0)
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		sprite_index = A.spr_SMB3_goalcard
	else:
		sprite_index = A.spr_SMB3_goalcard_disabled


# from objects/obj_goalcard/Alarm_0.gml
func _alarm_0() -> void:
	if not (ready_v > 0.5):
		alarm[0] = 10.0
		if image_index != 3.0:
			image_index += 1.0
		else:
			image_index = 0.0


# from objects/obj_goalcard/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
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
	elif (not GM.instance_exists(A.obj_editormanager)) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		# UNSURE: obj_superado_bg 在原工程里没有 object 定义，a.gd 无此常量。照 obj_player_goal_smb1 的写法用 asset_get_index 取，取不到（-1）时跳过
		var _superado_bg: int = GM.asset_get_index("obj_superado_bg")
		if _superado_bg >= 0:
			GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), _superado_bg)


# from objects/obj_goalcard/Alarm_3.gml
func _alarm_3() -> void:
	if G.timer <= 0.0:
		G.timer = 0.0
	else:
		if G.timer > 4.0:
			alarm[3] = 1.0
			GM.score += 250.0
			G.timer -= 8.0
		elif G.timer < 5.0 and G.timer > 0.0:
			alarm[3] = 2.0
			GM.score += 50.0
			G.timer -= 1.0
		if ready3 == 0.0:
			if G.timer > 0.0:
				ready3 = 1.0
				GM.audio_play_sound(A.snd_SMB_count, 0.0, true)
			else:
				ready3 = 2.0
				GM.audio_stop_sound(A.snd_SMB_count)
		elif G.timer < 1.0 and ready3 == 1.0:
			ready3 = 2.0
			GM.audio_stop_sound(A.snd_SMB_count)


# from objects/obj_goalcard/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_player_goal_smb3)):
			inst.mygoal = self  # PORT: other.id 就是实例本身（§3.3 第 15 条）
			var _m = GM.instance_find(A.obj_mario, 0)  # obj_mario.vspeed / obj_mario.direct（第一个实例）
			inst.vspeed = _m.vspeed
			inst.direct = _m.direct
		GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
		GM.audio_stop_sound(Scr.scr_snd_starman(self))
		GM.audio_stop_sound(Scr.scr_music_link(self))
		GM.audio_stop_sound(A.snd_n64)
		alarm[3] = 120.0
		alarm[2] = 270.0
		if GM.room != A.rm_editor:
			var _p = GM.instance_find(A.obj_persistent, 0)  # obj_persistent.modo_android（第一个实例）
			if _p.modo_android == 1.0 and G.controles_tactiles == 1.0:
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(A.obj_persistent):
					inst.event_user(4)
					inst.event_user(5)
				GM.other = _o
		var _o2: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
		GM.other = self
		for inst in GM.with_list(A.obj_levelmanager):
			inst.event_user(3)
			inst.alarm[2] = 0.0
			inst.alarm[4] = -1.0
		GM.other = _o2
		G.checkpoint = -4.0
		ready_v = 1.0
		_user_2()
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()


# from objects/obj_goalcard/Other_12.gml
func _user_2() -> void:
	GM.audio_play_sound(A.snd_SMB3_course_clear, 0.0, false)
	if image_index == 3.0:
		var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
		GM.other = self
		for inst in GM.with_list(GM.instance_create((x + 16.0), y, A.obj_score)):
			inst.visible = false
			inst.event_user(7)
		GM.other = _o
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 7.0), A.obj_goalcard_get)):
		inst.vspeed = -2.0
		match self.image_index:
			0.0:
				inst.sprite_index = A.spr_SMB3_goalcard_mush
			1.0:
				inst.sprite_index = A.spr_SMB3_goalcard_flower
			2.0:
				inst.sprite_index = A.spr_SMB3_goalcard_star
			3.0:
				inst.sprite_index = A.spr_SMB3_goalcard_1up


# from objects/obj_goalcard/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(A.spr_SMB3_bg_goal, 0.0, (GM.room_width - 310.0), 0.0)
	GM.draw_sprite(A.spr_SMB3_goal_draw, 0.0, (GM.room_width - 307.0), (y - 9.0))
	if GM.instance_exists(A.obj_ground3):
		GM.draw_sprite(A.spr_SMB3_goalbox, 0.0, GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 88.0))
		if not (ready_v > 0.5):
			GM.draw_sprite(sprite_index, -1.0, GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 88.0))
	else:
		GM.draw_sprite(A.spr_SMB3_goalbox, 0.0, x, y)
		if not (ready_v > 0.5):
			GM.draw_sprite(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y))
