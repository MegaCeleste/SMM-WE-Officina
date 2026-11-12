# from objects/obj_spring（第 5 批移植，已核对）
extends "res://objects/obj_holdparent.gd"

var ready3: float = 0.0
var object_jump: float = 0.0
var object_jump2: float = 0.0


# from objects/obj_spring/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_spring
		1.0:
			sprite_index = A.spr_SMB3_spring
		2.0:
			sprite_index = A.spr_spring
		3.0:
			sprite_index = A.spr_NSMBU_spring
		4.0:
			# UNSURE: 原文 sprite_index = spr_SMB2_spring，但工程里没有这个资源（原版读未定义变量会报错）；apariencia 取值 0-3，此分支应不可达，这里不赋值
			pass
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	object_jump = 0.0
	object_jump2 = 0.0
	super._create()


# from objects/obj_spring/Step_0.gml
func _step() -> void:
	super._step()
	if GM.instance_exists(A.obj_mario) and held == 0.0 and ready2 == 1.0:
		if image_index >= 2.7:
			ready2 = 2.0
			if G.apariencia == 3.0:
				if GM.keyboard_check(int(G.saltar)) or GM.keyboard_check(int(G.saltar_spin)):
					GM.audio_play_sound(A.snd_NSMBU_spring_high, 0.0, false)
				else:
					GM.audio_stop_sound(A.snd_NSMBU_spring)
					GM.audio_play_sound(A.snd_NSMBU_spring, 0.0, false)
			else:
				GM.audio_stop_sound(Scr.scr_snd_spring(self))
				GM.audio_play_sound(Scr.scr_snd_spring(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_mario):
				if inst.disablecontrols == 0.0:
					inst.jump_type = GM.choose(1.0, 2.0, 3.0)
					inst.event_user(1)
				if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and inst.y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0)):
					inst.vspeed = -3.625
				else:
					inst.vspeed = -5.225
			GM.other = _o
		if ready2 == 1.0:
			for inst in GM.with_list(A.obj_mario):
				inst.state = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.jumpnow = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.y = ((y + (image_index * 4.0)) - 31.0)


# from objects/obj_spring/Alarm_1.gml
func _alarm_1() -> void:
	ready2 = 0.0


# from objects/obj_spring/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	var spd: float
	if held == 0.0 and other.held == 0.0:
		if other.bbox_bottom < ((bbox_top - vspeed) + 8.0) and other.vspeed > 0.0:
			if (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) == null):
				spd = 5.225
			else:
				spd = 0.6
			other.hspeed = 0.0
			other.vspeed = (-(spd - (1.0 * swimming)))
			if image_speed == 0.0:
				image_speed = 0.3
			if Scr.outside_view(self) < 0.5:
				GM.audio_stop_sound(Scr.scr_snd_spring(self))
				GM.audio_play_sound(Scr.scr_snd_spring(self), 0.0, false)


# from objects/obj_spring/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if held < 0.5:
		if (other.bbox_bottom < (yprevious + 6.0) or other.groundpount != 0.0) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) == null) and other.vspeed > 0.0 and ready_v == 0.0:
			image_speed = 0.3
			for inst in GM.with_list(other):
				inst.hspeed = 0.0
				inst.vspeed = 0.0
				inst.stompstyle = 0.0
				inst.state = 0.0
				inst.jumping = 0.0
				if inst.object_index == A.obj_marioU:
					inst.triple_jump = 0.0
					inst.triple_count = 0.0
					inst.airspin = 0.0
					inst.airspin_count = 0.0
					inst.groundpount = 0.0
					inst.walljump = 0.0
					inst.helice_fly = 0.0
					inst.disablecontrols = 0.0
				if GM.keyboard_check(int(G.abajo)):
					if G.apariencia == 1.0 or G.apariencia == 3.0:
						if inst.holding != 2.0:
							inst.isduck = 1.0
					elif G.apariencia == 2.0:
						if inst.holding == 2.0:
							inst.isduck = 1.0
							inst.isduckhold = 1.0
						else:
							inst.isduck = 1.0
			ready_v = 1.0
			ready2 = 1.0


# from objects/obj_spring/Collision_obj_physicsparent.gml
func _collision_obj_physicsparent(other: GMObject) -> void:
	var bullet_base: GMObject
	var physolido: GMObject
	var solidphy: GMObject
	var spd: float
	if other.object_index == A.obj_jumppiranha and other.inup > 0.0:
		return
	# 注：obj_player_goal_smb1 / obj_player_goal_smw_castle 的 ready / fall 读自空壳（原文 ready 在这里写作 ready_v）
	if (held < 0.5 and other.object_index != A.obj_banzaibill and other.object_index != A.obj_billbanzai_red and other.object_index != A.obj_bulletbill and other.object_index != A.obj_bulletbull_red and other.object_index != A.obj_fire_clown and other.object_index != A.obj_cap and other.object_index != A.obj_podoboo and other.object_index != A.obj_angrysun and other.object_index != A.obj_yoshifire and other.object_index != A.obj_yoshifire_one and other.object_index != A.obj_cheepcheep and other.object_index != A.obj_thwomp and other.object_index != A.obj_grinder and other.object_index != A.obj_boo and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red and other.object_index != A.obj_helmet and other.object_index != A.obj_helmet_spiny and other.object_index != A.obj_player_goal_smb1 and other.object_index != A.obj_player_goal_smw_castle and other.object_index != A.obj_magikoopa and other.object_index != A.obj_piranhaplant and other.object_index != A.obj_rocky and other.object_index != A.obj_lakitu) or (other.object_index == A.obj_player_goal_smb1 and (other.ready_v == 2.0 or other.ready_v == 3.0)) or (other.object_index == A.obj_player_goal_smw_castle and other.fall == 1.0):
		if other.bbox_bottom < ((bbox_top - vspeed) + 8.0) and other.vspeed > 0.0:
			bullet_base = collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false)
			physolido = collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_physicssolid, true, false)
			solidphy = collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false)
			if (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) == null) and ((bullet_base == null) or (bullet_base != null and bullet_base == other)) and ((physolido == null) or (physolido != null and physolido == other)) and ((solidphy == null) or (solidphy != null and solidphy == other)):
				spd = 5.225
			else:
				spd = 0.5
			if other.object_index == A.obj_clown or other.object_index == A.obj_clown_fire or (other.object_index == A.obj_jumppiranha and G.apariencia == 2.0):
				spd = (spd / 3.5)
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and other.y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				other.vspeed = (-(spd / 2.0))
			else:
				other.vspeed = (-spd)
			if image_speed == 0.0:
				image_speed = 0.3
			if Scr.outside_view(self) < 0.5:
				GM.audio_stop_sound(Scr.scr_snd_spring(self))
				GM.audio_play_sound(Scr.scr_snd_spring(self), 0.0, false)


# from objects/obj_spring/Collision_obj_powerupparent.gml
func _collision_obj_powerupparent(other: GMObject) -> void:
	var spd: float
	if held < 0.5 and other.wings == 0.0:
		if other.bbox_bottom < ((bbox_top - vspeed) + 8.0) and other.vspeed > 0.0:
			if (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(other.bbox_left, (other.bbox_top - 1.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) == null):
				spd = 5.225
			else:
				spd = 0.6
			other.hspeed = 0.0
			other.vspeed = (-(spd - (1.0 * swimming)))
			if image_speed == 0.0:
				image_speed = 0.3
			if Scr.outside_view(self) < 0.5:
				GM.audio_stop_sound(Scr.scr_snd_spring(self))
				GM.audio_play_sound(Scr.scr_snd_spring(self), 0.0, false)


# from objects/obj_spring/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
