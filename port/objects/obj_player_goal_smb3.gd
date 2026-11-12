# 第 4 批移植，已核对。
extends "res://objects/obj_player_goal_parent.gd"

var mygoal = null
var anim: float = 0.0
var ready_v: float = 0.0  # 改名(ready)，同 Node.ready
var ready2: float = 0.0
var swim: float = 0.0


# from objects/obj_player_goal_smb3/Create_0.gml
func _create() -> void:
	mygoal = -1.0
	image_speed = 0.0
	gravity = 0.25
	anim = 0.0
	ready_v = 0.0
	ready2 = 0.0
	swimming = 0.0
	swim = 0.0
	# DESACTIVARCONTROL


# from objects/obj_player_goal_smb3/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	_user_3()
	_user_4()
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swim = 1.0
	anim += 0.2
	if gravity == 0.0:
		if swimming == 1.0:
			hspeed += 0.1
			if hspeed > 0.8:
				hspeed = 0.8
		else:
			hspeed += 0.08
			if hspeed > 1.6:
				hspeed = 1.6
	if ready_v == 1.0:
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
	if G.star_flash == 1.0:
		if cp_cont == 0.0:
			flashAlpha -= 0.15
			if flashAlpha < 0.3:
				cp_cont = 1.0
				if cp < 2.0:
					cp += 1.0
				else:
					cp = 0.0
		else:
			flashAlpha += 0.15
			if flashAlpha > 0.9:
				cp_cont = 0.0
		blend_star = color[int(cp)]  # ORIG-BUG: 本 object 的 Create 没有 event_inherited，color 从未赋值（原版 star_flash == 1 时会读未定义变量）


# from objects/obj_player_goal_smb3/Step_2.gml
func _step_end() -> void:
	if G.powerup == 0.0:
		mask_index = A.spr_smallmask
	elif G.powerup == -77.0:
		mask_index = A.spr_megamask
	elif G.powerup == -85.0:
		mask_index = A.spr_smallmask
	else:
		mask_index = A.spr_bigmask
	if vspeed != 0.0:
		if swimming == 1.0 and swim == 1.0:
			sprite_index = Scr.scr_marioswimhold(self)
			image_speed = 0.15
		else:
			sprite_index = Scr.scr_mariojump(self)
			image_speed = 0.0
			if vspeed < 0.0:
				image_index = 0.0
			else:
				image_index = 1.0
	elif hspeed == 0.0:
		sprite_index = Scr.scr_marioidle(self)
		image_speed = 0.0
	else:
		sprite_index = Scr.scr_mariowalk(self)
		image_speed = 0.3
	if hspeed > 0.0:
		direct = 1.0


# from objects/obj_player_goal_smb3/Other_40.gml
func _outside_view_0() -> void:
	if ready_v == 0.0:
		ready_v = 1.0
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
		visible = false


# from objects/obj_player_goal_smb3/Draw_0.gml
func _gm_draw() -> void:
	if G.yoshi == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.instance_find(A.obj_invincibility, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()
