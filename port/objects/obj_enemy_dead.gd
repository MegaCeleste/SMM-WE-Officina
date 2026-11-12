extends GMObject

var girar: float = 0.0
var rot_speed: float = 0.0
var swimming: float = 0.0
var modo_lava: float = 0.0
var direct = null
var direct_y: float = 0.0
var scale: float = 0.0
var dead_boss: float = 0.0
var rot_max = null  # 第 4 批补：由 obj_link_arrow 写入


# from objects/obj_enemy_dead/Create_0.gml
func _create() -> void:
	girar = 0.0
	rot_speed = 2.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	modo_lava = 0.0
	if sprite_index != A.spr_boomboom_dead and sprite_index != A.spr_NSMBU_boomboom_dead and sprite_index != A.spr_NSMBU_boomboom_dead_b and sprite_index != A.spr_blooper and sprite_index != A.spr_SMB3_drybones_deads:
		image_speed = 0.0
		image_index = 0.0
	alarm[0] = 1.0
	direct = 1.0
	direct_y = 1.0
	scale = 1.0
	dead_boss = 0.0


# from objects/obj_enemy_dead/Destroy_0.gml
func _destroy() -> void:
	if dead_boss == 1.0 and G.bg_level != "castle" and G.bg_level != "forest":
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.set("dead_bowser", 1.0)
				inst.alarm[11] = 120.0


# from objects/obj_enemy_dead/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -8.0
	if modo_lava == 1.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) < (GM.instance_find(A.obj_lava_water, 0).y - 14.0):
		modo_lava = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		modo_lava = 1.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if girar == 1.0:
		if swimming == 1.0 or modo_lava == 1.0:
			image_angle -= ((6.0 * rot_speed) * GM.gm_sign(hspeed))
		else:
			image_angle -= (16.0 * GM.gm_sign(hspeed))
	if rot_speed > 1.0:
		rot_speed -= 0.01
	else:
		rot_speed = 1.0
	if not GM.instance_exists(A.obj_deadmario):
		if vspeed > 0.0:
			if swimming == 1.0 or modo_lava == 1.0:
				gravity = 0.02
				if vspeed > 1.0:
					vspeed = 1.0
			elif direct_y == -1.0:
				gravity = 0.1
				if vspeed > 1.0:
					vspeed = 1.0
			else:
				gravity = 0.2
				if vspeed > 4.0:
					vspeed = 4.0
			if GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
				y = (GM.instance_find(A.obj_lava_water, 0).y + 16.0)
			if y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 248.0) or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
				instance_destroy()
		elif swimming == 1.0 or modo_lava == 1.0:
			gravity = 0.02
		else:
			gravity = 0.2
	if modo_lava == 1.0:
		hspeed = 0.0
	elif hspeed > 1.0 and hspeed < 2.0:
		hspeed = 1.0
	elif hspeed > -2.0 and hspeed < -1.0:
		hspeed = -1.0


# from objects/obj_enemy_dead/Alarm_0.gml
func _alarm_0() -> void:
	var spd: float  # 局部变量提升（GML 的 var 是函数作用域）
	if sprite_index != A.spr_cannonball and sprite_index != A.spr_SMB3_cannonball and sprite_index != A.spr_SMB_cannonball and sprite_index != A.spr_banzaibill and sprite_index != A.spr_bulletbill and sprite_index != A.spr_SMB3_bulletbill and sprite_index != A.spr_SMB_bulletbill and sprite_index != A.spr_bulletbill_red and sprite_index != A.spr_SMB3_bulletbill_red and sprite_index != A.spr_SMB_bulletbill_red and sprite_index != A.spr_blooper and sprite_index != A.spr_SMB3_blooper and sprite_index != A.spr_SMB_blooper and sprite_index != A.spr_NSMBU_blooper and sprite_index != A.spr_SMB_link_arrow:
		if sprite_index == A.spr_podoboo or sprite_index == A.spr_SMB3_podoboo or sprite_index == A.spr_SMB_podoboo or sprite_index == A.spr_NSMBU_bowserjr_dead:
			spd = 5.0
		else:
			spd = 4.0
	else:
		spd = 0.1
	if swimming == 1.0 or modo_lava == 1.0:
		spd = (spd / 2.5)
	vspeed = (-spd)


# from objects/obj_enemy_dead/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, x, y, (scale * direct), (scale * direct_y), image_angle, GM.c_white, 1.0)
