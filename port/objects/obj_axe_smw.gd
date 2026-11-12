# from objects/obj_axe_smw（第 7 批移植，已核对）
extends GMObject

var cadena: float = 0.0
var caer: float = 0.0
var soporte = null
var piso1 = null
var piso2 = null
var piso3 = null
var piso4 = null
var piso5 = null
var piso6 = null
var piso7 = null
var piso8 = null
var piso9 = null
var piso10 = null
var piso11 = null
var piso12 = null
var piso13 = null
var piso14 = null
var castle = null


# from objects/obj_axe_smw/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_axe
		1.0:
			sprite_index = A.spr_SMB3_axe
		2.0:
			sprite_index = A.spr_axe_smw
		3.0:
			sprite_index = A.spr_NSMBU_axe
		4.0:
			sprite_index = A.spr_SMB_axe
	if G.apariencia == 1.0:
		image_speed = 0.09
	else:
		image_speed = 0.15
	cadena = 0.0
	caer = 0.0
	soporte = GM.instance_create((x - 16.0), y, A.obj_solid)
	soporte.image_xscale = 2.0
	piso1 = GM.instance_create((x - 32.0), (y + 16.0), A.obj_castle_floor)
	piso2 = GM.instance_create((x - 48.0), (y + 16.0), A.obj_castle_floor)
	piso3 = GM.instance_create((x - 64.0), (y + 16.0), A.obj_castle_floor)
	piso4 = GM.instance_create((x - 80.0), (y + 16.0), A.obj_castle_floor)
	piso5 = GM.instance_create((x - 96.0), (y + 16.0), A.obj_castle_floor)
	piso6 = GM.instance_create((x - 112.0), (y + 16.0), A.obj_castle_floor)
	piso7 = GM.instance_create((x - 128.0), (y + 16.0), A.obj_castle_floor)
	piso8 = GM.instance_create((x - 144.0), (y + 16.0), A.obj_castle_floor)
	piso9 = GM.instance_create((x - 160.0), (y + 16.0), A.obj_castle_floor)
	piso10 = GM.instance_create((x - 176.0), (y + 16.0), A.obj_castle_floor)
	piso11 = GM.instance_create((x - 192.0), (y + 16.0), A.obj_castle_floor)
	piso12 = GM.instance_create((x - 208.0), (y + 16.0), A.obj_castle_floor)
	piso13 = GM.instance_create((x - 224.0), (y + 16.0), A.obj_castle_floor)
	piso14 = GM.instance_create((x - 240.0), (y + 16.0), A.obj_castle_floor)
	castle = GM.instance_create((x + 64.0), (y - 32.0), A.obj_castle)


# from objects/obj_axe_smw/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(piso1):
		for inst in GM.with_list(piso1):
			inst.instance_destroy()
	if GM.instance_exists(piso2):
		for inst in GM.with_list(piso2):
			inst.instance_destroy()
	if GM.instance_exists(piso3):
		for inst in GM.with_list(piso3):
			inst.instance_destroy()
	if GM.instance_exists(piso4):
		for inst in GM.with_list(piso4):
			inst.instance_destroy()
	if GM.instance_exists(piso5):
		for inst in GM.with_list(piso5):
			inst.instance_destroy()
	if GM.instance_exists(piso6):
		for inst in GM.with_list(piso6):
			inst.instance_destroy()
	if GM.instance_exists(piso7):
		for inst in GM.with_list(piso7):
			inst.instance_destroy()
	if GM.instance_exists(piso8):
		for inst in GM.with_list(piso8):
			inst.instance_destroy()
	if GM.instance_exists(piso9):
		for inst in GM.with_list(piso9):
			inst.instance_destroy()
	if GM.instance_exists(piso10):
		for inst in GM.with_list(piso10):
			inst.instance_destroy()
	if GM.instance_exists(piso11):
		for inst in GM.with_list(piso11):
			inst.instance_destroy()
	if GM.instance_exists(piso12):
		for inst in GM.with_list(piso12):
			inst.instance_destroy()
	if GM.instance_exists(piso13):
		for inst in GM.with_list(piso13):
			inst.instance_destroy()
	if GM.instance_exists(piso14):
		for inst in GM.with_list(piso14):
			inst.instance_destroy()
	if GM.instance_exists(soporte):
		for inst in GM.with_list(soporte):
			inst.instance_destroy()
	if GM.instance_exists(castle):
		for inst in GM.with_list(castle):
			inst.instance_destroy()


# from objects/obj_axe_smw/Step_0.gml
func _step() -> void:
	if caer == 1.0:
		if image_angle >= 90.0:
			image_angle = 90.0
			if G.apariencia == 3.0:
				GM.audio_play_sound(A.snd_NSMBU_hacha, 0.0, false)
			else:
				GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
			Scr.init_shake(self, 1.0)
			cadena = 1.0
			alarm[0] = 5.0
			alarm[2] = 65.0
			if GM.instance_exists(A.obj_enemy_dead_castle):
				for inst in GM.with_list(A.obj_enemy_dead_castle):
					inst.alarm[0] = 65.0
					inst.alarm[1] = 185.0
			caer = 2.0
		else:
			image_angle += 5.0


# from objects/obj_axe_smw/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(piso1):
		inst.alarm[0] = 1.0
	for inst in GM.with_list(piso2):
		inst.alarm[0] = 5.0
	for inst in GM.with_list(piso3):
		inst.alarm[0] = 10.0
	for inst in GM.with_list(piso4):
		inst.alarm[0] = 15.0
	for inst in GM.with_list(piso5):
		inst.alarm[0] = 20.0
	for inst in GM.with_list(piso6):
		inst.alarm[0] = 25.0
	for inst in GM.with_list(piso7):
		inst.alarm[0] = 30.0
	for inst in GM.with_list(piso8):
		inst.alarm[0] = 35.0
	for inst in GM.with_list(piso9):
		inst.alarm[0] = 40.0
	for inst in GM.with_list(piso10):
		inst.alarm[0] = 45.0
	for inst in GM.with_list(piso11):
		inst.alarm[0] = 50.0
	for inst in GM.with_list(piso12):
		inst.alarm[0] = 55.0
	for inst in GM.with_list(piso13):
		inst.alarm[0] = 60.0
	for inst in GM.with_list(piso14):
		inst.alarm[0] = 65.0


# from objects/obj_axe_smw/Alarm_1.gml
func _alarm_1() -> void:
	GM.audio_play_sound(A.bgm_smwclear_castle, 0.0, false)
	var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.event_user(3)
		inst.alarm[2] = 0.0
	GM.other = _o


# from objects/obj_axe_smw/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_player_goal_smw_castle):
		for inst in GM.with_list(A.obj_player_goal_smw_castle):
			inst.fall = 1.0
			inst.alarm[6] = 150.0
	alarm[3] = 630.0


# from objects/obj_axe_smw/Alarm_3.gml
func _alarm_3() -> void:
	if (not GM.audio_is_playing(A.snd_SMB_course_clear_castle)) and (not GM.audio_is_playing(A.snd_SMB_clear_castle_link)) and (not GM.audio_is_playing(A.snd_SMB3_course_clear_castle)) and (not GM.audio_is_playing(A.bgm_smwclear_castle)) and (not GM.audio_is_playing(A.snd_NSMBU_clear_castle)):
		if GM.instance_exists(A.obj_editormanager):
			var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(A.obj_creator_jugar_editar):
				inst.event_user(2)
			GM.other = _o
		elif GM.room == A.rm_title:
			Scr.scr_restart(self)
		elif G.level_g == 1.0:
			GM.room_goto(A.rm_guardabot)
		else:
			# UNSURE: obj_superado_bg 在原工程（openwe-ref）里没有 object 定义，a.gd 无此常量。照 obj_player_goal_smb1 的写法用 asset_get_index 取，取不到（-1）时跳过以免崩溃
			var _superado_bg: int = GM.asset_get_index("obj_superado_bg")
			if _superado_bg >= 0:
				GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), _superado_bg)
	else:
		alarm[3] = 10.0


# from objects/obj_axe_smw/Alarm_4.gml
func _alarm_4() -> void:
	if G.level_g == 1.0:
		pass


# from objects/obj_axe_smw/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		if caer == 0.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			caer = 1.0
			var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(A.obj_score):
				inst.event_user(5)
			GM.other = _o
			_user_0()
			for inst in GM.with_list(other):  # PORT: other.id 就是 other 本身（§3.3 第 15 条）
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_player_goal_smw_castle)):
					inst2.direct = inst.direct
					inst2.jump_type = inst.jump_type
					inst2.sprite_index = inst.sprite_index
					inst2.image_index = inst.image_index
				if GM.instance_exists(A.obj_mario_pballon):
					for inst2 in GM.with_list(A.obj_mario_pballon):
						inst2.speed = 0.0
				inst.instance_destroy()


# from objects/obj_axe_smw/Other_10.gml
func _user_0() -> void:
	var enemy  # 实例（instance_create 的返回值）
	if GM.instance_exists(A.obj_enemyparent):
		for inst in GM.with_list(A.obj_enemyparent):
			if inst.object_index == A.obj_boo:
				inst.boo_huida = 1.0
			elif inst.object_index == A.obj_egg or inst.object_index == A.obj_egg_red or inst.object_index == A.obj_podoboo or inst.object_index == A.obj_podoboo_b:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_smoke)):
					inst2.sprite_index = A.spr_destroy_enemy
				inst.instance_destroy()
			elif inst.object_index != A.obj_grinder:
				enemy = GM.instance_create(inst.x, inst.y, A.obj_enemy_dead_castle)
				enemy.sprite_index = inst.sprite_index
				enemy.image_index = inst.image_index
				enemy.direct = inst.direct
				inst.instance_destroy()
	if GM.instance_exists(A.obj_bowserjr_shell):
		GM.instance_create(x, y, A.obj_bowserjr_dead_castle)
		# ORIG-BUG: 这里不在 with 里，销毁的是斧头自己（不是 obj_bowserjr_shell），生成位置也是斧头的坐标。照搬
		instance_destroy()
	if GM.instance_exists(A.obj_bossparent):
		for inst in GM.with_list(A.obj_bossparent):
			if inst.object_index == A.obj_SMB_bowser or inst.object_index == A.obj_SMB3_bowser or inst.object_index == A.obj_SMW_bowser or inst.object_index == A.obj_NSMBU_bowser:
				enemy = GM.instance_create(inst.x, inst.y, A.obj_bowser_dead_castle)
				enemy.sprite_index = inst.sprite_index
				enemy.image_index = inst.image_index
				enemy.direct = inst.direct
			elif inst.object_index == A.obj_bowserjr or inst.object_index == A.obj_NSMBU_bowserjr:
				enemy = GM.instance_create(inst.x, inst.y, A.obj_bowserjr_dead_castle)
				enemy.sprite_index = inst.sprite_index
				enemy.image_index = inst.image_index
				enemy.direct = inst.direct
			else:
				enemy = GM.instance_create(inst.x, inst.y, A.obj_enemy_dead_castle)
				enemy.sprite_index = inst.sprite_index
				enemy.image_index = inst.image_index
				enemy.direct = inst.direct
			inst.instance_destroy()


# from objects/obj_axe_smw/Draw_0.gml
func _gm_draw() -> void:
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		draw_self()
	else:
		GM.draw_sprite(A.spr_axe_disabled, G.apariencia, x, y)
	GM.draw_sprite(A.spr_axe_support, G.apariencia, (x - 16.0), y)
	if cadena == 0.0:
		GM.draw_sprite(A.spr_cadena, G.apariencia, (x - 48.0), y)
