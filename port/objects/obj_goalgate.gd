# from objects/obj_goalgate（第 7 批移植，已核对）
extends GMObject

var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
var ready2: float = 0.0
var ready3: float = 0.0
var tape = null


# from objects/obj_goalgate/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	tape = GM.instance_create((x + 8.0), (y + 8.0), A.obj_goalgate_tape)
	for inst in GM.with_list(GM.instance_create((x + 32.0), y, A.obj_goalgate_front)):
		inst.sprite_index = self.sprite_index


# from objects/obj_goalgate/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_goalgate_tape):
		for inst in GM.with_list(A.obj_goalgate_tape):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_goalgate_front):
		for inst in GM.with_list(A.obj_goalgate_front):
			inst.instance_destroy()


# from objects/obj_goalgate/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_ground3):
		x = GM.instance_find(A.obj_ground3, 0).x
		y = (GM.instance_find(A.obj_ground3, 0).y - 137.0)
	if GM.instance_exists(A.obj_mario):
		var _m: GMObject = GM.instance_find(A.obj_mario, 0)  # PORT: obj_mario.x 等（第一个实例），外层已判断存在
		if _m.x >= (x + 16.0) and _m.x <= (x + 32.0) and (_m.y + 16.0) >= y and _m.y <= (y + 137.0) and (G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0)):
			if GM.instance_exists(A.obj_goalgate_tape):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(A.obj_goalgate_tape):
					inst.event_user(0)
				GM.other = _o
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		sprite_index = A.spr_goalgate
	else:
		sprite_index = A.spr_goalgate_disabled


# from objects/obj_goalgate/Alarm_0.gml
func _alarm_0() -> void:
	if G.timer <= 0.0:
		G.timer = 0.0
	else:
		if G.timer > 4.0:
			alarm[0] = 1.0
			GM.score += 250.0
			G.timer -= 8.0
		elif G.timer < 5.0 and G.timer > 0.0:
			alarm[0] = 2.0
			GM.score += 50.0
			G.timer -= 1.0
		if ready3 == 0.0:
			if G.timer > 0.0:
				ready3 = 1.0
				GM.audio_play_sound(A.snd_count, 0.0, false)
			else:
				ready3 = 2.0
				GM.audio_stop_sound(A.snd_count)
				GM.audio_play_sound(A.snd_countend, 0.0, false)
		elif G.timer < 1.0 and ready3 == 1.0:
			ready3 = 2.0
			GM.audio_stop_sound(A.snd_count)
			GM.audio_play_sound(A.snd_countend, 0.0, false)


# from objects/obj_goalgate/Alarm_1.gml
func _alarm_1() -> void:
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


# from objects/obj_goalgate/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_ground3):
		GM.draw_sprite_ext(sprite_index, -1.0, GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 136.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, -1.0, x, (y + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
