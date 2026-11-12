# 第 4 批移植，已核对。
extends GMObject

var offset: float = 0.0
var offsetnext: float = 0.0
var stateprev = null
var flying: float = 0.0
var m_sprite = null
var m_subimagen: float = 0.0
var gran_golpe: float = 0.0
var golpe_count: float = 0.0
var count_audio: float = 0.0
var jump: float = 0.0
var imdead = null
var direct = null


# from objects/obj_kuriboshoe/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_kuriboshoe
	G.yoshi = 2.0
	image_speed = 0.15
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
	jump = 0.0


# from objects/obj_kuriboshoe/Destroy_0.gml
func _destroy() -> void:
	G.yoshi = 0.0
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0


# from objects/obj_kuriboshoe/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_frozenmario):
		_user_0()
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if m.state != 2.0 and m.state != 3.0:
			m_sprite = Scr.scr_mario_shoe(self)
			if m.isduck == 1.0:
				m_subimagen = 1.0
			else:
				m_subimagen = 0.0
		elif G.powerup != -39.0:
			m_sprite = Scr.scr_mario_shoe(self)
			if m.isduck == 1.0:
				m_subimagen = 1.0
			else:
				m_subimagen = 0.0
		elif G.powerup == -39.0:
			m_sprite = Scr.scr_mario_shoe_fall(self)
			if m.wiggle == 0.0:
				if m.vspeed > 0.0 or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
					m_subimagen = 3.0
				else:
					m_subimagen = 0.0
			elif m.wiggle > 12.0:
				m_subimagen = 3.0
			elif m.wiggle > 8.0:
				m_subimagen = 2.0
			elif m.wiggle > 4.0:
				m_subimagen = 1.0
			elif m.wiggle > 1.0:
				m_subimagen = 2.0
			elif m.wiggle == 1.0:
				m_subimagen = 1.0
		x = m.x
		y = (m.y + 16.0)
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 3.0
		if sprite_index == A.spr_SMB_kuriboshoe2 or sprite_index == A.spr_kuriboshoe2:
			if m.state == 2.0 and GM.keyboard_check_pressed(G.abajo):
				gran_golpe = 1.0
				for inst in GM.with_list(A.obj_mario):
					inst.vspeed = 3.0
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = 0.0
			if stateprev == 2.0 and m.state != 2.0:
				GM.audio_play_sound(A.snd_kuriboshoe_steps, 0.0, false)
				if gran_golpe == 1.0 and golpe_count == 0.0:
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke_shoe)):
						inst.hspeed = 2.6
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke_shoe)):
						inst.hspeed = -2.6
						inst.direct = -1.0
					GM.audio_play_sound(A.snd_stomp, 0.0, false)
					var block = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_blockparent, false, false)
					if block != null:
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(block):
							if inst.object_index == A.obj_flipblock:
								inst.alarm[2] = 2.0
							elif inst.ready_v == 0.0:
								inst.ready_v = 1.0
								inst.vspeed = -2.0
								if inst.object_index == A.obj_noteblock:
									inst.alarm[0] = 7.0
								else:
									inst.alarm[0] = 4.0
								inst.event_user(0)
						GM.other = _o
					var block_ice = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_ice, false, false)
					if block_ice != null:
						for inst in GM.with_list(block_ice):
							inst.alarm[0] = 1.0
					var block_rock = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_rock, false, false)
					if block_rock != null:
						for inst in GM.with_list(block_rock):
							inst.alarm[0] = 1.0
					alarm[3] = 10.0
					golpe_count = 1.0
			stateprev = m.state
		elif G.ycolor == 3.0:
			if GM.keyboard_check(GM.vk_shift) and m.isswim == 0.0:
				if flying == 0.0 and m.vspeed > 0.0:
					flying = 1.0
					alarm[1] = 1.0
				if flying == 1.0:
					for inst in GM.with_list(A.obj_mario):
						if inst.collision_rectangle(inst.bbox_left, (inst.bbox_top - 3.0), inst.bbox_right, inst.bbox_top, A.obj_solid, true, false) == null:
							inst.vspeed = -2.0
			else:
				flying = 0.0
	elif GM.instance_exists(A.obj_player_goal_smb3):
		var g3 = GM.instance_find(A.obj_player_goal_smb3, 0)
		x = g3.x
		y = (g3.y + 16.0)
		for inst in GM.with_list(A.obj_player_goal_smb3):
			inst.visible = false
		m_sprite = Scr.scr_mario_shoe(self)
	elif GM.instance_exists(A.obj_player_goal_smw_castle):
		var gc = GM.instance_find(A.obj_player_goal_smw_castle, 0)
		x = gc.x
		y = (gc.y + 16.0)
		for inst in GM.with_list(A.obj_player_goal_smw_castle):
			inst.visible = false
		m_sprite = Scr.scr_mario_shoe(self)


# from objects/obj_kuriboshoe/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if m.state == 1.0 and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_lava_water_drybones, false, false) == null):
			_offset_step()
			offsetnext += 1.0
			if offsetnext == 10.0:
				offsetnext = 0.0
				if G.apariencia == 3.0 and object_index == A.obj_kuribo_drybones and (collision_rectangle(bbox_left, (bbox_bottom + 8.0), bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false) == null):
					GM.audio_stop_sound(A.snd_NSMBU_step_block1)
					GM.audio_play_sound(A.snd_NSMBU_step_block2, 0.0, false)
				elif object_index == A.obj_kuriboshoe2:
					GM.audio_stop_sound(A.snd_kuriboshoe_steps)
					GM.audio_play_sound(A.snd_kuriboshoe_steps, 0.0, false)
		else:
			offsetnext = 0.0
			offset = 0.0
	elif GM.instance_exists(A.obj_player_goal_smb3):
		var g3 = GM.instance_find(A.obj_player_goal_smb3, 0)
		if g3.hspeed != 0.0:
			_offset_step()
			offsetnext += 1.0
			if offsetnext == 10.0:
				offsetnext = 0.0
				if object_index == A.obj_kuriboshoe2:
					GM.audio_stop_sound(A.snd_kuriboshoe_steps)
					GM.audio_play_sound(A.snd_kuriboshoe_steps, 0.0, false)
		else:
			offsetnext = 0.0
			offset = 0.0
	elif GM.instance_exists(A.obj_player_goal_smw):
		var gw = GM.instance_find(A.obj_player_goal_smw, 0)
		if gw.hspeed != 0.0:
			_offset_step()
			offsetnext += 1.0
			if offsetnext == 10.0:
				offsetnext = 0.0
				if object_index == A.obj_kuriboshoe2:
					GM.audio_stop_sound(A.snd_kuriboshoe_steps)
					GM.audio_play_sound(A.snd_kuriboshoe_steps, 0.0, false)
		else:
			offsetnext = 0.0
			offset = 0.0
	alarm[0] = 2.0


# PORT: Alarm_0 里三处相同的 `switch offsetnext { case 0: offset = 1 … case 9: offset = 0 }`，提成辅助函数（语义不变，无 default）
func _offset_step() -> void:
	match offsetnext:
		0.0:
			offset = 1.0
		1.0:
			offset = 2.0
		2.0:
			offset = 3.0
		3.0:
			offset = 4.0
		4.0:
			offset = 5.0
		5.0:
			offset = 4.0
		6.0:
			offset = 3.0
		7.0:
			offset = 2.0
		8.0:
			offset = 1.0
		9.0:
			offset = 0.0


# from objects/obj_kuriboshoe/Alarm_1.gml
func _alarm_1() -> void:
	if flying == 1.0:
		GM.audio_play_sound(A.snd_lick, 0.0, false)
		alarm[1] = 15.0


# from objects/obj_kuriboshoe/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).state == 1.0:
		GM.audio_play_sound(A.snd_kuriboshoe_steps, 0.0, false)
		alarm[0] = 30.0
	else:
		alarm[0] = 2.0


# from objects/obj_kuriboshoe/Alarm_3.gml
func _alarm_3() -> void:
	gran_golpe = 0.0
	golpe_count = 0.0


# from objects/obj_kuriboshoe/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_getshoe)):
		if self.object_index == A.obj_kuriboshoe2:
			inst.bota = 2.0
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
	for inst in GM.with_list(A.obj_mario):
		inst.visible = true
	instance_destroy()


# from objects/obj_kuriboshoe/Other_15.gml
func _user_5() -> void:
	GM.audio_play_sound(A.snd_helmet_remove, 0.0, false)
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	if object_index == A.obj_kuriboshoe2:
		if G.apariencia == 0.0:
			imdead.sprite_index = A.spr_SMB_bota2_deads
		else:
			imdead.sprite_index = A.spr_bota2_deads
	elif G.apariencia == 0.0:
		imdead.sprite_index = A.spr_SMB_bota_deads
	else:
		imdead.sprite_index = A.spr_bota_deads
	imdead.image_index = 0.0
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


# from objects/obj_kuriboshoe/Draw_0.gml
func _gm_draw() -> void:
	var sprite_mega  # 局部变量提升（GML 的 var 是函数作用域）
	var valor  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		direct = m.direct
		if G.powerup == -77.0:
			valor = 32.0
			if object_index == A.obj_kuriboshoe2:
				sprite_mega = A.spr_SMB_kuriboshoe2_big
			else:
				sprite_mega = A.spr_kuriboshoe_big
		else:
			valor = 16.0
			sprite_mega = sprite_index
		GM.draw_sprite_ext(m_sprite, m_subimagen, x, ((y - valor) - offset), m.direct, 1.0, 0.0, GM.c_white, m.image_alpha)
		GM.draw_sprite_ext(sprite_mega, image_index, x, (y - offset), m.direct, 1.0, 0.0, GM.c_white, 1.0)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			var inv = GM.instance_find(A.obj_invincibility, 0)
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(m_sprite, m_subimagen, x, ((y - valor) - offset), m.direct, 1.0, 0.0, m.blend_star, inv.flashAlpha)
			GM.draw_sprite_ext(sprite_mega, image_index, x, (y - offset), m.direct, 1.0, 0.0, m.blend_star, inv.flashAlpha)
			GM.shader_reset()
	elif GM.instance_exists(A.obj_player_goal_smb3):
		var g3 = GM.instance_find(A.obj_player_goal_smb3, 0)
		GM.draw_sprite_ext(m_sprite, m_subimagen, x, ((y - 16.0) - offset), g3.direct, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_index, image_index, x, (y - offset), g3.direct, 1.0, 0.0, GM.c_white, 1.0)
	elif GM.instance_exists(A.obj_player_goal_smw_castle):
		var gc = GM.instance_find(A.obj_player_goal_smw_castle, 0)
		if G.powerup == -77.0:
			GM.draw_sprite_ext(m_sprite, m_subimagen, x, ((y - 32.0) - offset), gc.direct, 1.0, 0.0, GM.c_white, gc.image_alpha)
			if object_index == A.obj_kuriboshoe2:
				GM.draw_sprite_ext(A.spr_SMB_kuriboshoe2_big, image_index, x, (y - offset), gc.direct, 1.0, 0.0, GM.c_white, 1.0)
			else:
				GM.draw_sprite_ext(A.spr_kuriboshoe_big, image_index, x, (y - offset), gc.direct, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(m_sprite, m_subimagen, x, ((y - 16.0) - offset), gc.direct, 1.0, 0.0, GM.c_white, 1.0)
			GM.draw_sprite_ext(sprite_index, image_index, x, (y - offset), gc.direct, 1.0, 0.0, GM.c_white, 1.0)
