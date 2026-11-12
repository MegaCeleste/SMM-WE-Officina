# 第 4 批移植，已核对。
extends "res://objects/obj_physicsparent.gd"

var hitcombo: float = 0.0


# from objects/obj_yoshifire/Create_0.gml
func _create() -> void:
	image_speed = 0.3
	hitcombo = 0.0
	direct = 1.0
	swimming = 0.0
	hspeed = (1.1 * GM.gm_sign(GM.instance_find(A.obj_mario, 0).direct))
	alarm[0] = 2.0


# from objects/obj_yoshifire/Step_0.gml
func _step() -> void:
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		instance_destroy()


# from objects/obj_yoshifire/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "castle":
		GM.audio_play_sound(A.snd_podoboo, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava
			inst.depth = -10.0
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		GM.audio_play_sound(A.snd_podoboo, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava_purple
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava_purple
			inst.depth = -10.0
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		GM.audio_play_sound(A.snd_podoboo, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava
			inst.depth = -10.0
		instance_destroy()


# from objects/obj_yoshifire/Alarm_0.gml
func _alarm_0() -> void:
	if vspeed == 0.0:
		if hspeed > 0.0:
			hspeed = 3.0
		elif hspeed < 0.0:
			hspeed = -3.0
	elif hspeed > 0.0:
		hspeed = 2.5
	elif hspeed < 0.0:
		hspeed = -2.5
	direct = (1.0 * GM.gm_sign(hspeed))


# from objects/obj_yoshifire/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = -0.5


# from objects/obj_yoshifire/Alarm_2.gml
func _alarm_2() -> void:
	vspeed = 0.5


# from objects/obj_yoshifire/Collision_obj_boomboom.gml
func _collision_obj_boomboom(other: GMObject) -> void:
	GM.audio_play_sound(A.snd_tread_boss, 0.0, false)
	_user_0()


# from objects/obj_yoshifire/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var bobomb
	var o = other
	if o.hardness < 99.0 and o.object_index != A.obj_bobomb_ready:
		if o.object_index == A.obj_bobomb:
			bobomb = GM.instance_create(o.x, o.y, A.obj_bobomb_ready)
			bobomb.wings = o.wings
			bobomb.paracaidas = o.paracaidas
			for inst in GM.with_list(o):
				inst.set("can_wings_deads", 0.0)
				inst.instance_destroy()
		else:
			GM.audio_play_sound(A.snd_kick, 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create(o.x, o.y, A.obj_score)):
				inst.event_user(0)
			for inst in GM.with_list(o):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_yoshifire/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if other.object_index != A.obj_bobomb_hold:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_yoshifire/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_yoshifire/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_smokespin
	instance_destroy()


# from objects/obj_yoshifire/Other_14.gml
func _user_4() -> void:
	var semisolid
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0) and (collision_rectangle((x - 1.0), bbox_bottom, (x + 1.0), (bbox_bottom + 4.0), A.obj_slopeparent, true, false) == null):
			y = (semisolid.bbox_top - 8.0)
	if collision_rectangle((x - 1.0), bbox_bottom, (x + 1.0), (bbox_bottom + 4.0), A.obj_slopeparent, true, false) != null and (collision_rectangle((x - 1.0), (bbox_bottom - 4.0), (x + 1.0), (bbox_bottom - 4.0), A.obj_slopeparent, true, false) == null) and vspeed == 0.0:
		if collision_rectangle((x - 1.0), bbox_bottom, (x + 1.0), (bbox_bottom + 5.0), A.obj_solidtop, false, false) == null:
			y += 4.0
	if vspeed > -0.85 and collision_rectangle((x - 1.0), (bbox_bottom - 4.0), (x + 1.0), bbox_bottom, A.obj_slopeparent, true, false) != null and (collision_rectangle((x - 1.0), (bbox_bottom - 8.0), (x + 1.0), (bbox_bottom - 8.0), A.obj_slopeparent, true, false) == null):
		while collision_rectangle((x - 1.0), (bbox_bottom - 4.0), (x + 1.0), bbox_bottom, A.obj_slopeparent, true, false) != null:
			y -= 1.0
	if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or collision_rectangle((x - 1.0), (bbox_bottom + 1.0), (x + 1.0), (bbox_bottom + 1.0), A.obj_slopeparent, true, false) != null:
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.03
		if vspeed > 1.0:
			vspeed = 1.0


# from objects/obj_yoshifire/Other_40.gml
func _outside_view_0() -> void:
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		instance_destroy()


# from objects/obj_yoshifire/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), direct, 1.0, 0.0, GM.c_white, 1.0)
