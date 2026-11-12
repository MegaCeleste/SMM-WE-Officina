# from objects/obj_frozenmario（第 5 批移植，已核对）
extends GMObject

var yview: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var sprite = null  # 存 sprite 编号，由 obj_snowball_bro 写入
var index: float = 0.0
var sprite_break: float = 0.0
var direct: float = 0.0
var helmet: float = 0.0
var helmet_sprite: float = 0.0
var helmet_index: float = 0.0
var helmet_y: float = 0.0
var cap_sprite: float = 0.0
var cap_index: float = 0.0
var cap_x: float = 0.0
var cap_y: float = 0.0
var shake: float = 0.0
var swimming: float = 0.0
var rotacion: float = 0.0


# from objects/obj_frozenmario/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	yview = (y + 32.0)
	ready_v = 0.0
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
	sprite = -4  # PORT: 存的是 sprite 编号（不是实例），-4 照原值写成 int，传给 draw_sprite_ext 的 int 形参
	index = 0.0
	if G.apariencia == 3.0:
		sprite_break = A.spr_NSMBU_smoke_snowball
	else:
		sprite_break = A.spr_frozenblock_break
	direct = 1.0
	helmet = 0.0
	helmet_sprite = A.spr_SMB_helmet_small
	helmet_index = 0.0
	helmet_y = 0.0
	cap_sprite = A.spr_cap_stay_start
	cap_index = 0.0
	cap_x = 0.0
	cap_y = 0.0
	shake = 0.0
	swimming = 0.0
	rotacion = 0.0
	alarm[0] = 120.0
	alarm[1] = 180.0


# from objects/obj_frozenmario/Destroy_0.gml
func _destroy() -> void:
	var i_levelmanager = GM.instance_find(A.obj_levelmanager, 0)
	var mario2: int  # 局部变量提升（GML 的 var 是函数作用域）
	if (not GM.instance_exists(A.obj_mario)) and i_levelmanager.editor == 0.0:
		if G.apariencia == 3.0:
			mario2 = A.obj_marioU
		else:
			mario2 = A.obj_mario
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, mario2)):
			inst.direct = self.direct
			inst.helmet = self.helmet
			inst.event_user(0)
		GM.other = _o


# from objects/obj_frozenmario/Step_0.gml
func _step() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "castle":
		GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
		alarm[1] = 1.0
	elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_posion)
		alarm[1] = 1.0


# from objects/obj_frozenmario/Alarm_0.gml
func _alarm_0() -> void:
	if swimming == 0.0:
		if shake == 0.0:
			x += 1.0
			shake = 1.0
		else:
			x -= 1.0
			shake = 0.0
		alarm[0] = 2.0


# from objects/obj_frozenmario/Alarm_1.gml
func _alarm_1() -> void:
	_user_1()
	if G.apariencia == 3.0:
		for inst in GM.with_list(GM.instance_create(x, (y + 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_smoke_foo
			inst.image_speed = 0.5
	else:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y + 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_smokespin
			inst.image_speed = 0.2
	for inst in GM.with_list(GM.instance_create((x + 6.0), (y + 8.0), A.obj_shard)):
		inst.motion_set(45.0, 4.0)
		inst.sprite_index = int(self.sprite_break)  # PORT: sprite_break 声明为 float（存 sprite 编号），赋给 int 型 sprite_index 时显式转换
		if G.apariencia == 3.0:
			inst.image_index = 0.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x + 6.0), y, A.obj_shard)):
		inst.motion_set(60.0, 4.0)
		inst.sprite_index = int(self.sprite_break)
		if G.apariencia == 3.0:
			inst.image_index = 1.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 1.0
	for inst in GM.with_list(GM.instance_create((x - 6.0), y, A.obj_shard)):
		inst.motion_set(120.0, 4.0)
		inst.sprite_index = int(self.sprite_break)
		if G.apariencia == 3.0:
			inst.image_index = 2.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 0.0
	for inst in GM.with_list(GM.instance_create((x - 6.0), (y + 8.0), A.obj_shard)):
		inst.motion_set(135.0, 4.0)
		inst.sprite_index = int(self.sprite_break)
		if G.apariencia == 3.0:
			inst.image_index = 3.0
		else:
			inst.image_index = G.apariencia
		inst.dir = 0.0
	instance_destroy()


# from objects/obj_frozenmario/Other_11.gml
func _user_1() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_estalactita_break)
			GM.audio_play_sound(A.snd_estalactita_break, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_estalactita_break)
			GM.audio_play_sound(A.snd_NSMBU_estalactita_break, 0.0, false)


# from objects/obj_frozenmario/Draw_0.gml
func _gm_draw() -> void:
	var posyy  # 局部变量提升（GML 的 var 是函数作用域）
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if G.powerup == -82.0:
		posyy = 24.0
	else:
		posyy = 0.0
	if G.powerup == 3.0:
		# PORT: cap_sprite / helmet_sprite 声明为 float（存 sprite 编号），传 int 形参时显式转换
		GM.draw_sprite_ext(int(cap_sprite), cap_index, (x + cap_x), (y + cap_y), direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite, index, GM.gm_round(x), (y + posyy), direct, 1.0, rotacion, GM.c_white, 1.0)
	if helmet != 0.0 and G.powerup != -82.0:
		GM.draw_sprite_ext(int(helmet_sprite), helmet_index, x, (y + helmet_y), direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 0.3)
