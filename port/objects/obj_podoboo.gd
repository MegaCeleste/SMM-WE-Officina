extends "res://objects/obj_enemyparent.gd"

var edible: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名），同 obj_noteblock 的改名
var w_wings: float = 0.0
var rot: float = 0.0
var rotacion: float = 0.0


# from objects/obj_podoboo/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_podoboo
			image_speed = 0.2
		1.0:
			sprite_index = A.spr_SMB3_podoboo
			image_speed = 0.2
		2.0:
			sprite_index = A.spr_podoboo
			image_speed = 0.2
		3.0:
			sprite_index = A.spr_NSMBU_podoboo
			image_speed = 0.3
	hardness = 100.0
	stomp = 2.0
	edible = 1.0
	modo_lava = 0.0
	direct = 1.0
	ready_v = 0.0
	dead_h = 0.0
	swimming = 0.0
	innave = 0.0
	wings = 0.0
	w_wings = 0.0
	paracaidas = 0.0
	apilar = 0.0
	rot = 2.0
	rotacion = 180.0
	alarm[10] = 1.0


# from objects/obj_podoboo/Step_0.gml
func _step() -> void:
	if y < (ystart + 42.0) and ready_v == 1.0:
		ready_v = 0.0
		gravity = 0.2
	if y < (ystart + 16.0) and ready_v == 0.0 and vspeed < 0.0 and rot == 0.0:
		rot = 1.0
	if rot == 1.0:
		if rotacion >= 180.0:
			rotacion = 180.0
			rot = 2.0
		else:
			rotacion += 10.0
	if bbox_top > GM.room_height:
		if ready_v <= 0.5:  # GML: !ready
			ready_v = 1.0
			alarm[0] = 10.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0)):
		if ready_v <= 0.5 and vspeed > 0.0:  # GML: !ready
			ready_v = 1.0
			alarm[0] = 10.0
			if G.apariencia != 0.0:
				if G.bg_level == "forest":
					GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
				else:
					GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
	direct = 1.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y >= GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		if vspeed > 1.0:
			vspeed = 1.0
	elif vspeed > 6.0:
		vspeed = 6.0


# from objects/obj_podoboo/Alarm_0.gml
func _alarm_0() -> void:
	visible = false
	vspeed = 0.0
	gravity = 0.0
	rot = 0.0
	rotacion = 0.0
	alarm[1] = 120.0


# from objects/obj_podoboo/Alarm_1.gml
func _alarm_1() -> void:
	if x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) and x < ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0):
		if GM.instance_exists(A.obj_lava_water):
			if GM.instance_find(A.obj_lava_water, 0).y > (ystart + 16.0):
				visible = true
				vspeed = -4.0
				alarm[2] = 10.0
			else:
				alarm[1] = 10.0
		else:
			visible = true
			vspeed = -4.0
			alarm[2] = 10.0
	else:
		alarm[1] = 10.0


# from objects/obj_podoboo/Alarm_2.gml
func _alarm_2() -> void:
	GM.audio_stop_sound(A.snd_podoboo)
	GM.audio_play_sound(A.snd_podoboo, 0.0, false)
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.apariencia != 0.0 and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0)):
		if G.bg_level == "forest":
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		else:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)


# from objects/obj_podoboo/Alarm_10.gml
func _alarm_10() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
		gravity = 0.1
	else:
		gravity = 0.2


# from objects/obj_podoboo/Collision_obj_bobomb.gml
func _collision_obj_bobomb(other: GMObject) -> void:
	if other.object_index != A.obj_bobomb_ready:
		for inst in GM.with_list(other):
			var bobomb = GM.instance_create(inst.x, inst.y, A.obj_bobomb_ready)
			bobomb.direct = inst.direct
			bobomb.wings = inst.wings
			bobomb.paracaidas = inst.paracaidas
			for inst2 in GM.with_list(bobomb):
				inst2.alarm[10] = 1.0
			inst.can_wings_deads = 0.0
			inst.instance_destroy()


# from objects/obj_podoboo/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = sprite_index
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_podoboo/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
