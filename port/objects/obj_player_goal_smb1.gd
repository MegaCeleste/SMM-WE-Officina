# 第 4 批移植，已核对。
extends "res://objects/obj_player_goal_parent.gd"

var flagpole = null
var ready4: float = 0.0
var in_solid: float = 0.0
var anim: float = 0.0
var ready_v: float = 0.0  # 改名(ready)，同 Node.ready
var ready2: float = 0.0
var ready3: float = 0.0
var out_view: float = 0.0
var stream: float = 0.0
var swim: float = 0.0


# from objects/obj_player_goal_smb1/Create_0.gml
func _create() -> void:
	flagpole = -1.0
	ready4 = 0.0
	in_solid = 0.0
	sprite_index = Scr.scr_mariogoal(self)
	image_speed = 0.0
	image_index = 0.0
	var _o1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.event_user(3)
		inst.alarm[2] = 0.0
		inst.alarm[4] = -1.0
	GM.other = _o1
	anim = 0.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	out_view = 0.0
	stream = -1.0
	alarm[11] = 30.0
	swimming = 0.0
	swim = 0.0
	super._create()


# from objects/obj_player_goal_smb1/Step_0.gml
func _step() -> void:
	match G.powerup:
		0.0:
			mask_index = A.spr_smallmask
		-85.0:
			mask_index = A.spr_smallmask
		-77.0:
			mask_index = A.spr_megamask
		_:
			mask_index = A.spr_bigmask
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swim = 1.0
	anim += (0.065 + (absf(hspeed) / 7.5))
	if ready_v == 2.0 or ready_v == 3.0:
		if bbox_top > GM.room_height:
			y = (GM.room_height - 64.0)
			visible = false
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			swimming = 1.0
		else:
			swimming = 0.0
		_user_3()
		_user_4()
		if ready_v == 2.0:
			if hspeed < 0.0:
				ready_v = 3.0
				event_user(15)
				hspeed = 0.0
			elif ready2 != 1.0:
				if swimming == 1.0:
					hspeed = 0.5
				else:
					hspeed = 1.5
	if out_view == 1.0:
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
	if collision_rectangle((bbox_left + 1.0), bbox_bottom, (bbox_right - 1.0), (bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((bbox_left + 1.0), bbox_bottom, (bbox_right - 1.0), (bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null:
		in_solid = 1.0
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
		blend_star = color[int(cp)]
	_user_13()


# from objects/obj_player_goal_smb1/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 2.0
	direct = 1.0


# from objects/obj_player_goal_smb1/Alarm_2.gml
func _alarm_2() -> void:
	if (not GM.audio_is_playing(A.bgm_sm1clear)) and (not GM.audio_is_playing(A.snd_SMB_clear_superball)):
		if GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_creator_jugar_editar):
				inst.event_user(2)
			GM.other = _o1
		elif (not GM.instance_exists(A.obj_editormanager)) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			# UNSURE: obj_superado_bg 在原工程（openwe-ref）里没有 object 定义，只出现在 __global_object_depths 里；a.gd 无此常量。用 asset_get_index 取，取不到（-1）时跳过以免崩溃
			var _superado_bg: int = GM.asset_get_index("obj_superado_bg")
			if _superado_bg >= 0:
				GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), _superado_bg)
	else:
		alarm[2] = 1.0


# from objects/obj_player_goal_smb1/Alarm_3.gml
func _alarm_3() -> void:
	ready2 = 2.0
	depth = 14.0


# from objects/obj_player_goal_smb1/Alarm_4.gml
func _alarm_4() -> void:
	if direct == 1.0:
		direct = -1.0
		x += 8.0
	alarm[5] = 20.0


# from objects/obj_player_goal_smb1/Alarm_5.gml
func _alarm_5() -> void:
	ready_v = 2.0
	direct = 1.0
	if GM.instance_exists(A.obj_flagpole):
		for inst in GM.with_list(A.obj_flagpole):
			inst.alarm[1] = 126.0
			inst.alarm[0] = 360.0


# from objects/obj_player_goal_smb1/Alarm_11.gml
func _alarm_11() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_flag_decender, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_SMB_flag_decender, 0.0, false)
	vspeed = 1.5


# from objects/obj_player_goal_smb1/Collision_obj_flagpole.gml
func _collision_obj_flagpole(other: GMObject) -> void:
	if (ready_v == 0.0 and ready4 == 0.0 and GM.instance_exists(A.obj_SMB_flag) and GM.instance_find(A.obj_SMB_flag, 0).ready_v == 1.0 and y > (other.y + 128.0) and in_solid == 0.0) or (ready_v == 0.0 and ready4 == 0.0 and in_solid == 1.0):
		if G.powerup == -85.0:
			GM.audio_play_sound(A.snd_SMB_clear_link, 0.0, false)
		elif G.powerup == -50.0:
			GM.audio_play_sound(A.snd_SMB_clear_superball, 0.0, false)
		else:
			GM.audio_play_sound(A.bgm_sm1clear, 0.0, false)
		image_speed = 0.0
		image_index = 0.0
		vspeed = 0.0
		if y > (other.y + 128.0):
			y = (other.y + 128.0)
		alarm[4] = 20.0
		ready4 = 1.0


# from objects/obj_player_goal_smb1/Other_14.gml
func _user_4() -> void:
	var solidtop
	var solidpow
	var solidthwomp
	var solidmuncher
	var solidpinchos
	if vspeed >= 0.0:
		solidtop = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		solidpow = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_block_pow_hold, false, false)
		solidthwomp = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_thwomp, false, false)
		solidmuncher = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_muncher, false, false)
		solidpinchos = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_pinchos, false, false)
		if solidtop != null and bbox_bottom < (solidtop.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			y = (solidtop.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidmuncher != null and bbox_bottom < (solidmuncher.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			y = (solidmuncher.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidpinchos != null and bbox_bottom < (solidpinchos.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			y = (solidpinchos.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidthwomp != null and bbox_bottom < (solidthwomp.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			y = (solidthwomp.y + floorf(((y - bbox_bottom) - 16.0)))
		if solidpow != null and bbox_bottom < (solidpow.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
			y = (solidpow.y + floorf(((y - bbox_bottom) - 0.9)))
		if vspeed > 4.0:
			vspeed = 4.0
	if collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 4.0), A.obj_slopeparent, true, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_slopeparent, true, false) == null) and vspeed == 0.0:
		y += 4.0
	if collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, bbox_bottom, A.obj_slopeparent, true, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 8.0), bbox_right, (bbox_bottom - 8.0), A.obj_slopeparent, true, false) == null):
		while collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, bbox_bottom, A.obj_slopeparent, true, false) != null:
			y -= 1.0
	if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_pow_hold, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_block_pow_hold, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_thwomp, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_thwomp, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_muncher, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_pinchos, false, false) == null)) or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, true, false) != null:
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.125
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_pinchos, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_cannon, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_bullebill_base, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_muncher, true, false) != null):
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_solid, true, false) != null:
			y += 1.0
		vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_player_goal_smb1/Other_23.gml
func _user_13() -> void:
	if G.powerup == 0.0:
		mask_index = A.spr_smallmask
	elif G.powerup == -77.0:
		mask_index = A.spr_megamask
	elif G.powerup == -85.0:
		mask_index = A.spr_smallmask
	else:
		mask_index = A.spr_bigmask
	if ready_v < 2.0:
		sprite_index = Scr.scr_mariogoal(self)
		if vspeed > 0.0:
			image_speed = 0.15
		else:
			image_speed = 0.0
			image_index = 0.0
	elif gravity == 0.0:
		if hspeed == 0.0:
			sprite_index = Scr.scr_marioidle(self)
			image_speed = 0.0
			image_index = 0.0
		else:
			sprite_index = Scr.scr_mariowalk(self)
			image_speed = (0.065 + (absf(hspeed) / 7.5))
	elif swimming == 1.0 and swim == 1.0:
		sprite_index = Scr.scr_marioswimhold(self)
		image_speed = 0.15
	else:
		sprite_index = Scr.scr_mariojump(self)
		image_speed = 0.0
		image_index = 0.0


# from objects/obj_player_goal_smb1/Other_40.gml
func _outside_view_0() -> void:
	if out_view == 0.0 and hspeed != 0.0 and x > (xstart + 32.0):
		out_view = 1.0
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0


# from objects/obj_player_goal_smb1/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
	if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
		GM.shader_set(A.sha_blendreplace)
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.instance_find(A.obj_invincibility, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
		GM.shader_reset()
