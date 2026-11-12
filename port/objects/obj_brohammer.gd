# from objects/obj_brohammer（第 6e 批移植，已核对）
extends GMObject

var direct = null
var modo_lava: float = 0.0
var imdead = null


# from objects/obj_brohammer/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_hammer
		1.0:
			sprite_index = A.spr_SMB3_hammer
		2.0:
			sprite_index = A.spr_hammer
		3.0:
			sprite_index = A.spr_NSMBU_hammer
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 14.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		vspeed = -2.0
		gravity = 0.05
	else:
		vspeed = -3.0
		gravity = 0.125
	direct = 1.0
	modo_lava = 0.0


# from objects/obj_brohammer/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_deadmario):
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 14.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
			if G.apariencia == 0.0:
				image_angle -= (8.0 * GM.gm_sign(hspeed))
			else:
				image_angle -= (6.0 * GM.gm_sign(hspeed))
			gravity = 0.05
		else:
			if G.apariencia == 0.0:
				image_angle -= (25.0 * GM.gm_sign(hspeed))
			else:
				image_angle -= (15.0 * GM.gm_sign(hspeed))
			gravity = 0.125
	if modo_lava == 1.0:
		gravity = 0.05
		if vspeed > 1.0:
			vspeed = 1.0
	elif vspeed > 4.0:
		vspeed = 4.0
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		modo_lava = 1.0


# from objects/obj_brohammer/Collision_obj_invincibility.gml
func _collision_obj_invincibility(other: GMObject) -> void:
	_user_0()


# from objects/obj_brohammer/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_brohammer/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.image_angle = image_angle
	imdead.sprite_index = sprite_index
	if GM.other.hspeed == 0.0:
		# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_brohammer/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
