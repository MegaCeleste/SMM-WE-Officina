extends GMObject

var direct: float = 0.0
var swimming: float = 0.0
var modo_lava: float = 0.0


# from objects/obj_bowser_dead/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			image_speed = 0.15
		1.0:
			sprite_index = A.spr_SMB3_bowser_dead
			image_speed = 0.15
		2.0:
			sprite_index = A.spr_bowser_walk
			image_speed = 0.15
		3.0:
			sprite_index = A.spr_NSMBU_bowser_dead
			image_speed = 1.0
	direct = 1.0
	swimming = 0.0
	modo_lava = 0.0
	gravity = 0.3


# from objects/obj_bowser_dead/Destroy_0.gml
func _destroy() -> void:
	if G.bg_level != "castle" and G.bg_level != "forest":
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.dead_bowser = 1.0
				if G.apariencia == 0.0 or G.apariencia == 3.0:
					inst.alarm[11] = 90.0
				else:
					inst.alarm[11] = 120.0


# from objects/obj_bowser_dead/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			alarm[0] = 1.0
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			alarm[0] = 1.0
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0 and modo_lava == 0.0:
		if G.apariencia != 0.0:
			alarm[0] = 1.0
		modo_lava = 1.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y + 12.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if vspeed > 0.0:
		if swimming == 1.0 or modo_lava == 1.0:
			gravity = 0.05
			if vspeed > 0.8:
				vspeed = 0.8
		else:
			gravity = 0.1
			if vspeed > 3.2:
				vspeed = 3.2
		if GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
			y = (GM.instance_find(A.obj_lava_water, 0).y + 16.0)
		if y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 248.0) or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0 or G.bg_level == "mountain" and G.modo_noche == 1.0))):
			instance_destroy()
	if modo_lava == 1.0:
		hspeed = 0.0
	elif hspeed > 1.0 and hspeed < 2.0:
		hspeed = 1.0
	elif hspeed > -2.0 and hspeed < -1.0:
		hspeed = -1.0


# from objects/obj_bowser_dead/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_lava_water):
		if G.bg_level == "forest":
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		else:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
	alarm[0] = 20.0


# from objects/obj_bowser_dead/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, x, y, direct, 1.0, image_angle, GM.c_white, 1.0)
