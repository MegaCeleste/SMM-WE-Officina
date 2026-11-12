# 第 4 批移植，已核对。
extends "res://objects/obj_brohammer_yoshi.gd"


# from objects/obj_bones_yoshi_one/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	direct = 1.0


# from objects/obj_bones_yoshi_one/Step_0.gml
func _step() -> void:
	# 原版括号：beach 在 or 链最外层（与 obj_bones_yoshi 不同），照搬
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 14.0) and G.bg_level == "forest") or G.bg_level == "beach":
		image_angle -= (6.0 * GM.gm_sign(hspeed))
	else:
		image_angle -= (12.0 * GM.gm_sign(hspeed))
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		instance_destroy()


# from objects/obj_bones_yoshi_one/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if o.hardness < 99.0 and lm.editor == 0.0 and o.object_index != A.obj_grinder and o.object_index != A.obj_thwomp and o.object_index != A.obj_banzaibill and o.object_index != A.obj_podoboo and o.object_index != A.obj_boo and o.object_index != A.obj_thwomp:
		GM.audio_play_sound(A.snd_kick, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(o.x, o.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(o):
			inst.event_user(0)
		GM.other = _o
		_user_0()
	else:
		GM.audio_play_sound(A.snd_kick, 0.0, false)
		_user_0()


# from objects/obj_bones_yoshi_one/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	GM.audio_play_sound(A.snd_kick, 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()


# from objects/obj_bones_yoshi_one/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(GM.other.x, GM.other.y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	for inst in GM.with_list(GM.other):
		inst.instance_destroy()


# from objects/obj_bones_yoshi_one/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (x + 3.0), (y + 3.0), direct, image_yscale, image_angle, GM.c_black, 0.25)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
