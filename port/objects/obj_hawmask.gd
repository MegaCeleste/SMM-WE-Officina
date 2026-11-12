# from objects/obj_hawmask（第 7 批移植，已核对）
extends GMObject

var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名），obj_player_goal_smb2 里写的是 ready_v
var ready2: float = 0.0
var solido = null
var sprite_cover: int = 0  ## sprite 编号（取不到时是 -1，见 _create）
var index_cover: float = 0.0


# from objects/obj_hawmask/Create_0.gml
func _create() -> void:
	if (G.bg_level == "castle") or ((G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0))):
		# UNSURE: 原工程（openwe-ref）里没有 spr_SMB2_hawmask_night 这个 sprite（obj_hawmask.yy 的 spriteId 也是 null），原版这里会因读未赋值的变量报错。用 asset_get_index 取，取不到（-1）时不改 sprite_index
		var _spr_night: int = GM.asset_get_index("spr_SMB2_hawmask_night")
		if _spr_night >= 0:
			sprite_index = _spr_night
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	ready2 = 0.0
	solido = GM.instance_create((x + 16.0), y, A.obj_solid)
	for inst in GM.with_list(solido):
		inst.image_yscale = 4.0
	# UNSURE: 原工程里没有 spr_SMB2_goal_ground(_night) 这两个 sprite，原版这里会因读未赋值的变量报错。用 asset_get_index 取，取不到时是 -1（_gm_draw 里跳过）
	if G.modo_noche == 1.0:
		sprite_cover = GM.asset_get_index("spr_SMB2_goal_ground_night")
	else:
		sprite_cover = GM.asset_get_index("spr_SMB2_goal_ground")
	if G.bg_level == "underground":
		index_cover = 1.0
	elif G.bg_level == "castle":
		index_cover = 2.0
	elif G.bg_level == "underwater":
		index_cover = 3.0
	elif G.bg_level == "ghost":
		index_cover = 4.0
	elif (G.bg_level == "airship") or (G.bg_level == "sky"):
		index_cover = 5.0
	elif G.bg_level == "desert":
		index_cover = 6.0
	elif G.bg_level == "forest":
		index_cover = 7.0
	elif G.bg_level == "snow":
		index_cover = 8.0
	else:
		index_cover = 0.0


# from objects/obj_hawmask/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(solido):
		for inst in GM.with_list(solido):
			inst.instance_destroy()


# from objects/obj_hawmask/Alarm_0.gml
func _alarm_0() -> void:
	image_speed = 0.5
	GM.audio_play_sound(A.snd_SMB2_course_clear, 0.0, false)


# from objects/obj_hawmask/Alarm_1.gml
func _alarm_1() -> void:
	if G.timer > 4.0:
		alarm[1] = 1.0
		GM.score += 250.0
		G.timer -= 8.0
	elif (G.timer < 5.0) and (G.timer > 0.0):
		alarm[1] = 2.0
		GM.score += 50.0
		G.timer -= 1.0
	if ready2 == 0.0:
		if G.timer > 0.0:
			ready2 = 1.0
			GM.audio_play_sound(A.snd_count, 0.0, false)
		else:
			ready2 = 2.0
			GM.audio_play_sound(A.snd_countend, 0.0, false)
	elif (G.timer < 1.0) and (ready2 == 1.0):
		ready2 = 2.0
		GM.audio_play_sound(A.snd_countend, 0.0, false)


# from objects/obj_hawmask/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_editormanager) and (GM.instance_find(A.obj_levelmanager, 0).editor == 0.0):
		var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
		GM.other = self
		for inst in GM.with_list(A.obj_creator_jugar_editar):
			inst.event_user(2)
		GM.other = _o
	elif GM.room == A.rm_title:
		Scr.scr_restart(self)
	elif (not GM.instance_exists(A.obj_editormanager)) and (GM.instance_find(A.obj_levelmanager, 0).editor == 0.0):
		# UNSURE: obj_superado_bg 在原工程里没有 object 定义，a.gd 无此常量。照 obj_player_goal_smb1 的写法用 asset_get_index 取，取不到（-1）时跳过
		var _superado_bg: int = GM.asset_get_index("obj_superado_bg")
		if _superado_bg >= 0:
			GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), _superado_bg)


# from objects/obj_hawmask/Other_7.gml
func _animation_end() -> void:
	if ready_v == 0.0:
		image_speed = 0.0
		image_index = 24.0
		depth = -12.0
		if GM.instance_exists(A.obj_player_goal_smb2):
			for inst in GM.with_list(A.obj_player_goal_smb2):
				inst.walk = 1.0
		if GM.instance_exists(solido):
			for inst in GM.with_list(solido):
				inst.instance_destroy()
		alarm[1] = 15.0
		alarm[2] = 120.0
	else:
		image_speed = 0.0
		image_index = 0.0


# from objects/obj_hawmask/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if sprite_cover >= 0:  # PORT: sprite 缺失时跳过（见 _create）
		GM.draw_sprite(sprite_cover, index_cover, (x + 16.0), y)
