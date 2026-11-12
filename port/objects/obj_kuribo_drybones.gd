# 第 4 批移植，已核对。
extends "res://objects/obj_kuriboshoe.gd"

var invincible: float = 0.0
var cont_invincible: float = 0.0
var shake: float = 0.0
var shake_draw: float = 0.0
var salpi: float = 0.0
var salpicadura: float = 0.0
var sprite_l = null


# from objects/obj_kuribo_drybones/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			if G.powerup == -77.0:
				sprite_index = A.spr_SMB_kuribo_drybones_mega
			else:
				sprite_index = A.spr_SMB_kuribo_drybones
		1.0:
			sprite_index = A.spr_SMB3_kuribo_drybones
		2.0:
			sprite_index = A.spr_kuribo_drybones
		3.0:
			sprite_index = A.spr_NSMBU_kuribo_drybones
	G.yoshi = 2.0
	image_speed = 0.0
	image_index = 0.0
	offset = 0.0
	offsetnext = 0.0
	alarm[0] = 2.0
	stateprev = 0.0
	flying = 0.0
	m_sprite = 0.0
	m_subimagen = 0.0
	gran_golpe = 0.0
	golpe_count = 0.0
	count_audio = 0.0
	invincible = 0.0
	cont_invincible = 0.0
	shake = 0.0
	shake_draw = 1.0
	salpi = 0.0
	salpicadura = 0.0


# from objects/obj_kuribo_drybones/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_frozenmario):
		_user_0()
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -82.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			_user_0()
		if m.firing > 0.0:
			if m.firing < 6.0 and m.firing > 3.0:
				m_subimagen = 1.0
			else:
				m_subimagen = 0.0
				m_sprite = Scr.scr_marioshoot_drybones(self)
		elif m.state == 2.0 and G.powerup != -39.0 and G.apariencia != 0.0:
			m_sprite = Scr.scr_mario_drybones_jump(self)
			for inst in GM.with_list(A.obj_mario):
				if (inst.place_free(inst.x, (inst.y + 1.0)) and inst.vspeed > 0.0) or inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 4.0), inst.bbox_right, (inst.bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
					m_subimagen = 1.0
				else:
					m_subimagen = 0.0
		elif m.state == 1.0 and G.apariencia != 0.0:
			m_sprite = Scr.scr_mario_drybones_jump(self)
			m_subimagen = m.image_index
		elif m.state != 2.0 and m.state != 3.0:
			m_sprite = Scr.scr_mario_drybones(self)
			if m.isduck == 1.0:
				m_subimagen = 1.0
			else:
				m_subimagen = 0.0
		elif G.powerup != -39.0:
			m_sprite = Scr.scr_mario_drybones(self)
			if m.isduck == 1.0:
				m_subimagen = 1.0
			else:
				m_subimagen = 0.0
		elif G.powerup == -39.0:
			m_sprite = Scr.scr_mario_drybones_jump(self)
			for inst in GM.with_list(A.obj_mario):
				if inst.wiggle == 0.0:
					if (inst.place_free(inst.x, (inst.y + 1.0)) and inst.vspeed > 0.0) or inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 4.0), inst.bbox_right, (inst.bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
						m_subimagen = 3.0
					else:
						m_subimagen = 0.0
				elif inst.wiggle > 12.0:
					m_subimagen = 3.0
				elif inst.wiggle > 8.0:
					m_subimagen = 2.0
				elif inst.wiggle > 4.0:
					m_subimagen = 1.0
				elif inst.wiggle > 1.0:
					m_subimagen = 2.0
				elif inst.wiggle == 1.0:
					m_subimagen = 1.0
		if collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false) != null and GM.instance_exists(A.obj_mario) and GM.instance_exists(A.obj_lava_water) and m.y < (GM.instance_find(A.obj_lava_water, 0).y - 28.0) and m.state == 1.0:
			if G.apariencia == 3.0:
				image_speed = (m.image_speed / 4.0)
			else:
				image_speed = m.image_speed
			if G.apariencia != 0.0:
				if salpi == 0.0:
					salpicadura = 1.0
					salpi = 1.0
					alarm[8] = 1.0
			else:
				salpi = 0.0
				salpicadura = 0.0
			if (G.bg_level == "forest" or G.bg_level == "beach") and G.apariencia == 2.0:
				if not GM.audio_is_playing(A.snd_chapoteo_agua):
					GM.audio_play_sound(A.snd_chapoteo_agua, 0.0, false)
			elif G.bg_level == "castle" and G.apariencia == 2.0:
				if not GM.audio_is_playing(A.snd_chapoteo_lava):
					GM.audio_play_sound(A.snd_chapoteo_lava, 0.0, false)
			elif G.bg_level == "mountain" and G.modo_noche == 1.0 and G.apariencia == 2.0:
				if not GM.audio_is_playing(A.snd_chapoteo_lava):
					GM.audio_play_sound(A.snd_chapoteo_lava, 0.0, false)
		else:
			salpi = 0.0
			salpicadura = 0.0
			if invincible == 0.0:
				image_speed = 0.0
				image_index = 0.0
		if GM.instance_exists(A.obj_mario) and invincible == 1.0:
			x = m.x
			y = (m.y + 16.0)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 0.0
		else:
			x = m.x
			y = (m.y + 16.0)
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 3.0
		if GM.keyboard_check_pressed(G.abajo) and m.vspeed == 0.0 and m.state < 2.0 and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown_fire, false, false) == null) and invincible == 0.0 and (collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false) == null) and GM.instance_exists(A.obj_mario):
			GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
			for inst in GM.with_list(A.obj_mario):
				inst.invincible = 1.0
			for inst in GM.with_list(A.obj_mario):
				inst.disablecontrols = 1.0
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 0.0
			match G.apariencia:
				0.0:
					if G.powerup == -77.0:
						sprite_index = A.spr_SMB_shell_drybones_crumble_mega
					else:
						sprite_index = A.spr_SMB_shell_drybones_crumble
				1.0:
					sprite_index = A.spr_SMB3_shell_drybones_crumble
				2.0:
					sprite_index = A.spr_shell_drybones_crumble
				3.0:
					sprite_index = A.spr_NSMBU_shell_drybones_desarmar
			if G.apariencia == 3.0:
				image_speed = 0.5
			else:
				image_speed = 0.09
			if invincible == 0.0:
				alarm[4] = 60.0
				invincible = 1.0
		if m.state == 2.0 and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_spring, false, false) == null) and GM.keyboard_check_pressed(G.abajo):
			GM.audio_play_sound(A.snd_shell_drybones_down, 0.0, false)
			gran_golpe = 1.0
			for inst in GM.with_list(A.obj_mario):
				inst.vspeed = 2.0
		if m.state == 2.0 and GM.keyboard_check_pressed(G.arriba) and gran_golpe == 1.0:
			gran_golpe = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.vspeed = -0.2
		if m.state == 2.0 and gran_golpe == 1.0 and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom + 1.0), A.obj_spring, false, false) != null):
			gran_golpe = 0.0
		if stateprev == 2.0 and m.state != 2.0 and (collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + vspeed), A.obj_spring, false, false) == null):
			if gran_golpe == 1.0 and golpe_count == 0.0:
				GM.audio_stop_sound(Scr.scr_snd_break(self))
				GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
				if collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_lava_water, false, false) == null:
					for inst in GM.with_list(A.obj_mario):
						inst.invincible = 1.0
					for inst in GM.with_list(A.obj_mario):
						inst.disablecontrols = 1.0
					for inst in GM.with_list(A.obj_mario):
						inst.hspeed = 0.0
					match G.apariencia:
						0.0:
							if G.powerup == -77.0:
								sprite_index = A.spr_SMB_shell_drybones_crumble_mega
							else:
								sprite_index = A.spr_SMB_shell_drybones_crumble
						1.0:
							sprite_index = A.spr_SMB3_shell_drybones_crumble
						2.0:
							sprite_index = A.spr_shell_drybones_crumble
						3.0:
							sprite_index = A.spr_NSMBU_shell_drybones_desarmar
					if G.apariencia == 3.0:
						image_speed = 0.5
					else:
						image_speed = 0.09
					if invincible == 0.0:
						alarm[4] = 60.0
						invincible = 1.0
				var block = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_blockparent, false, false)
				if block != null:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						if inst.object_index != A.obj_noteblock and inst.object_index != A.obj_musicblock and inst.object_index != A.obj_noteblock_s and inst.ready_v == 0.0:
							inst.event_user(3)
					GM.other = _o
				alarm[3] = 10.0
				golpe_count = 1.0
		stateprev = m.state
	elif GM.instance_exists(A.obj_player_goal_smb3):
		var g3 = GM.instance_find(A.obj_player_goal_smb3, 0)
		x = g3.x
		y = (g3.y + 16.0)
		for inst in GM.with_list(A.obj_player_goal_smb3):
			inst.visible = false
		m_sprite = Scr.scr_mario_drybones(self)
		m_subimagen = 0.0
		image_speed = 0.0
		image_index = 0.0
	elif GM.instance_exists(A.obj_player_goal_smw) and GM.instance_find(A.obj_player_goal_smw, 0).object_index != A.obj_player_goal_smw_castle:
		var gw = GM.instance_find(A.obj_player_goal_smw, 0)
		x = gw.x
		y = (gw.y + 16.0)
		for inst in GM.with_list(A.obj_player_goal_smw):
			inst.visible = false
		image_speed = 0.0
		image_index = 0.0
		if gw.pose == 1.0:
			m_sprite = Scr.scr_mario_drybones_goal(self)
			if gw.helmet == 1.0:
				for inst in GM.with_list(A.obj_helmet):
					inst.instance_destroy()
				m_subimagen = 1.0
			elif gw.helmet == 2.0:
				for inst in GM.with_list(A.obj_helmet_spiny):
					inst.instance_destroy()
				m_subimagen = 2.0
			else:
				m_subimagen = 0.0
		else:
			m_sprite = Scr.scr_mario_drybones(self)
			m_subimagen = 0.0
	elif GM.instance_exists(A.obj_player_goal_smw_castle):
		var gc = GM.instance_find(A.obj_player_goal_smw_castle, 0)
		x = gc.x
		y = (gc.y + 16.0)
		for inst in GM.with_list(A.obj_player_goal_smw_castle):
			inst.visible = false
		m_sprite = Scr.scr_mario_drybones(self)
		m_subimagen = 0.0
		image_speed = 0.0
		image_index = 0.0


# from objects/obj_kuribo_drybones/Alarm_4.gml
func _alarm_4() -> void:
	if GM.keyboard_check(G.abajo):
		if cont_invincible >= 50.0:
			cont_invincible = 0.0
			alarm[5] = 1.0
		else:
			cont_invincible += 1.0
			alarm[4] = 2.0
	else:
		alarm[5] = 1.0


# from objects/obj_kuribo_drybones/Alarm_5.gml
func _alarm_5() -> void:
	if shake < 3.0:
		shake_draw = 1.0
		shake += 1.0
		alarm[6] = 4.0
	else:
		alarm[7] = 8.0
		shake = 0.0
		shake_draw = 1.0


# from objects/obj_kuribo_drybones/Alarm_6.gml
func _alarm_6() -> void:
	shake_draw = -1.0
	alarm[5] = 4.0


# from objects/obj_kuribo_drybones/Alarm_7.gml
func _alarm_7() -> void:
	match G.apariencia:
		0.0:
			if G.powerup == -77.0:
				sprite_index = A.spr_SMB_shell_drybones_crumble_reverse_mega
			else:
				sprite_index = A.spr_SMB_shell_drybones_crumble_reverse
		1.0:
			sprite_index = A.spr_SMB3_shell_drybones_crumble_reverse
		2.0:
			sprite_index = A.spr_shell_drybones_crumble_reverse
		3.0:
			sprite_index = A.spr_NSMBU_shell_drybones_armar
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.09


# from objects/obj_kuribo_drybones/Alarm_8.gml
func _alarm_8() -> void:
	if salpicadura == 1.0:
		if GM.instance_exists(A.obj_mario) and GM.instance_exists(A.obj_lava_water):
			if GM.instance_find(A.obj_mario, 0).state == 1.0:
				if G.bg_level == "forest" and G.modo_noche == 1.0:
					match G.apariencia:
						1.0:
							sprite_l = A.spr_SMB3_megasplash_lava_purple
						3.0:
							sprite_l = A.spr_NSMBU_splash_posion
						_:
							sprite_l = A.spr_megasplash_lava_purple
				elif G.bg_level == "mountain" and G.modo_noche == 1.0:
					match G.apariencia:
						1.0:
							sprite_l = A.spr_SMB3_megasplash_lava
						3.0:
							sprite_l = A.spr_NSMBU_splash_lava
						_:
							sprite_l = A.spr_megasplash_lava
				elif G.bg_level == "forest" or G.bg_level == "beach":
					match G.apariencia:
						1.0:
							sprite_l = A.spr_SMB3_megasplash_water
						3.0:
							sprite_l = A.spr_NSMBU_splash_agua
						_:
							sprite_l = A.spr_megasplash_water
				else:
					match G.apariencia:
						1.0:
							sprite_l = A.spr_SMB3_megasplash_lava
						3.0:
							sprite_l = A.spr_NSMBU_splash_lava
						_:
							sprite_l = A.spr_megasplash_lava
				for inst in GM.with_list(GM.instance_create((x - 16.0), (GM.instance_find(A.obj_lava_water, 0).y - 20.0), A.obj_smoke)):
					inst.sprite_index = self.sprite_l
					inst.depth = -9.0
				for inst in GM.with_list(GM.instance_create((x + 16.0), (GM.instance_find(A.obj_lava_water, 0).y - 20.0), A.obj_smoke)):
					inst.sprite_index = self.sprite_l
					inst.depth = -9.0
				alarm[8] = 30.0
			else:
				alarm[8] = 1.0


# from objects/obj_kuribo_drybones/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_SMB_shell_drybones_crumble or sprite_index == A.spr_SMB_shell_drybones_crumble_mega or sprite_index == A.spr_SMB3_shell_drybones_crumble or sprite_index == A.spr_shell_drybones_crumble:
		image_speed = 0.0
		image_index = 1.0
	elif sprite_index == A.spr_NSMBU_shell_drybones_desarmar:
		image_speed = 0.0
		image_index = 11.0
	elif sprite_index == A.spr_SMB_shell_drybones_crumble_reverse or sprite_index == A.spr_SMB_shell_drybones_crumble_reverse_mega or sprite_index == A.spr_SMB3_shell_drybones_crumble_reverse or sprite_index == A.spr_shell_drybones_crumble_reverse or sprite_index == A.spr_NSMBU_shell_drybones_armar:
		match G.apariencia:
			0.0:
				if G.powerup == -77.0:
					sprite_index = A.spr_SMB_kuribo_drybones_mega
				else:
					sprite_index = A.spr_SMB_kuribo_drybones
			1.0:
				sprite_index = A.spr_SMB3_kuribo_drybones
			2.0:
				sprite_index = A.spr_kuribo_drybones
			3.0:
				sprite_index = A.spr_NSMBU_kuribo_drybones
		image_speed = 0.0
		image_index = 0.0
		invincible = 0.0
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.invincible = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.disablecontrols = 0.0


# from objects/obj_kuribo_drybones/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell_drybones)):
		if GM.instance_exists(A.obj_mario):
			inst.dir = GM.instance_find(A.obj_mario, 0).direct
		elif GM.instance_exists(A.obj_frozenmario):
			inst.dir = GM.instance_find(A.obj_frozenmario, 0).direct
		while inst.collision_rectangle(inst.bbox_right, (inst.bbox_top + 4.0), inst.bbox_right, (inst.bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			inst.x -= 1.0
		while inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 4.0), inst.bbox_left, (inst.bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			inst.x += 1.0
		while inst.collision_rectangle(inst.bbox_right, (inst.bbox_top + 4.0), inst.bbox_right, (inst.bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			inst.x -= 1.0
		while inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 4.0), inst.bbox_left, (inst.bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			inst.x += 1.0
	if G.powerup != -82.0:
		for inst in GM.with_list(A.obj_mario):
			inst.visible = true
	instance_destroy()


# from objects/obj_kuribo_drybones/Other_15.gml
func _user_5() -> void:
	GM.audio_play_sound(A.snd_helmet_remove, 0.0, false)
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = A.spr_kuribo_drybones_deads
	imdead.image_speed = 0.0
	imdead.image_index = G.apariencia
	var m = GM.instance_find(A.obj_mario, 0)
	if m.hspeed == 0.0:
		if (m.bbox_left + (m.bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (m.bbox_left + (m.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif m.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif m.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_kuribo_drybones/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -77.0:
			if invincible == 0.0:
				if m_sprite != null:
					GM.draw_sprite_ext(m_sprite, m_subimagen, (GM.gm_round(x) - m.direct), ((y - 32.0) - offset), m.direct, 1.0, 0.0, GM.c_white, m.image_alpha)
			GM.draw_sprite_ext(sprite_index, image_index, ((GM.gm_round(x) - m.direct) + shake_draw), (y - offset), m.direct, 1.0, 0.0, GM.c_white, 1.0)
		else:
			if invincible == 0.0:
				if m_sprite != null:
					GM.draw_sprite_ext(m_sprite, m_subimagen, (GM.gm_round(x) - m.direct), ((y - 16.0) - offset), m.direct, 1.0, 0.0, GM.c_white, m.image_alpha)
			GM.draw_sprite_ext(sprite_index, image_index, ((GM.gm_round(x) - m.direct) + shake_draw), (y - offset), m.direct, 1.0, 0.0, GM.c_white, 1.0)
			if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
				GM.shader_set(A.sha_blendreplace)
				if invincible == 0.0:
					if m_sprite != null:
						GM.draw_sprite_ext(m_sprite, m_subimagen, (GM.gm_round(x) - m.direct), ((y - 16.0) - offset), m.direct, 1.0, 0.0, m.blend_star, m.flashAlpha)
				GM.draw_sprite_ext(sprite_index, image_index, ((GM.gm_round(x) - m.direct) + shake_draw), (y - offset), m.direct, 1.0, 0.0, m.blend_star, m.flashAlpha)
				GM.shader_reset()
	elif GM.instance_exists(A.obj_player_goal_smb3):
		var g3 = GM.instance_find(A.obj_player_goal_smb3, 0)
		if m_sprite != null:
			GM.draw_sprite_ext(m_sprite, m_subimagen, (GM.gm_round(x) - g3.direct), ((y - 16.0) - offset), g3.direct, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) - g3.direct), (y - offset), g3.direct, 1.0, 0.0, GM.c_white, 1.0)
	elif GM.instance_exists(A.obj_player_goal_smw):
		var gw = GM.instance_find(A.obj_player_goal_smw, 0)
		if m_sprite != null:
			GM.draw_sprite_ext(m_sprite, m_subimagen, (GM.gm_round(x) - gw.direct), ((y - 16.0) - offset), gw.direct, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) - gw.direct), (y - offset), gw.direct, 1.0, 0.0, GM.c_white, 1.0)
