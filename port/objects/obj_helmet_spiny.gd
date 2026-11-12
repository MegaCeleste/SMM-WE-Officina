# from objects/obj_helmet_spiny（第 7 批移植，已核对）
extends "res://objects/obj_helmet.gd"


# from objects/obj_helmet_spiny/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		vvelocidad = GM.instance_find(A.obj_mario, 0).vspeed


# from objects/obj_helmet_spiny/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.hardness < 2.0:
				GM.audio_play_sound(A.snd_tread_boss, 0.0, false)
				for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
					inst2.sprite_index = A.spr_spinthump
				inst.firehitpoints -= 1.0
				if inst.firehitpoints == 0.0:
					inst.hitpoints = 1.0
					inst.event_user(1)
				else:
					inst.hardness = 99.0
					inst.inv = 4.0
				# PORT: 内层 with (other.id) 的 other 是本实例；进入内层 with 时 other 变成 inst
				var _o2: GMObject = GM.other
				GM.other = inst
				for inst2 in GM.with_list(self):
					inst2.event_user(0)  # 本 object 没有 Other_10，原版就是空操作
				GM.other = _o2
		GM.other = _o


# from objects/obj_helmet_spiny/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.object_index != A.obj_egg and other.object_index != A.obj_egg_red and other.object_index != A.obj_grinder and other.visible == true and other.bbox_bottom < (bbox_top + 10.0):
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_helmet_spiny/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0 and (not GM.keyboard_check(G.lanzar_agarrar)):
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		other.hspeed = GM.lengthdir_x(1.5, GM.point_direction(x, y, other.x, other.y))
		if vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -1.5)


# from objects/obj_helmet_spiny/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_helmet_spiny/Collision_obj_physicsparent.gml
func _collision_obj_physicsparent(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0 and other.object_index != A.obj_coin_pow and other.object_index != A.obj_spring_land and other.object_index != A.obj_grinder and other.object_index != A.obj_mushroom and other.object_index != A.obj_yoshifire and other.object_index != A.obj_yoshifire_one and other.object_index != A.obj_1up and other.object_index != A.obj_fireflower and other.object_index != A.obj_cap and other.object_index != A.obj_star and other.object_index != A.obj_bowser_fire_down and other.object_index != A.obj_bullebill_base and other.object_index != A.obj_getshoe:
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		if vvelocidad >= 0.0:
			other.vspeed = -2.0
		else:
			other.vspeed = (vvelocidad + -2.0)


# from objects/obj_helmet_spiny/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	var o = other  # PORT: 按 §3.3 第 8a 条用不带类型的局部变量访问 other 的自定义变量
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 5.0) and other.vspeed >= 0.0 and (not GM.keyboard_check(G.lanzar_agarrar)) and o.inmune == 0.0:
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_helmet_spiny/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vvelocidad) + 8.0) and other.vspeed >= 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_helmet_spiny/Collision_obj_thwomp.gml
func _collision_obj_thwomp(other: GMObject) -> void:
	if other.bbox_bottom < (bbox_top + 10.0):
		GM.audio_stop_sound(A.snd_helmet_spiny)
		GM.audio_play_sound(A.snd_helmet_spiny, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_helmet_spiny/Other_16.gml
func _user_6() -> void:
	if G.powerup == -82.0:
		sprite_index = A.spr_helmet_pballoon
		image_speed = 0.0
		image_index = 1.0
		return
	if G.apariencia == 0.0:
		if G.powerup == 0.0 or G.powerup == -78.0 or G.powerup == -85.0:
			sprite_index = A.spr_SMB_helmet_spiny_small
		elif G.powerup == -77.0:
			sprite_index = A.spr_SMB_helmet_spiny_mega
		else:
			sprite_index = A.spr_SMB_helmet_spiny_big
		image_index = 0.0
	elif G.apariencia == 1.0:
		if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
			if G.powerup == 0.0:
				sprite_index = A.spr_SMB3_helmet_spiny_small_climb
				image_index = 0.0
			else:
				sprite_index = A.spr_SMB3_helmet_spiny_round
				image_index = 2.0
		elif GM.instance_exists(A.obj_spinner):
			sprite_index = A.spr_SMB3_helmet_spiny_round
			image_index = GM.instance_find(A.obj_spinner, 0).image_index
		elif G.powerup == 0.0:
			sprite_index = A.spr_SMB3_helmet_spiny_small
			image_index = 0.0
		else:
			sprite_index = A.spr_SMB3_helmet_spiny_big
			image_index = 0.0
	if G.apariencia == 2.0:
		if GM.instance_exists(A.obj_yoshi2):
			sprite_index = A.spr_helmet_spiny_yoshi
			image_index = 0.0
		elif GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
			sprite_index = A.spr_helmet_spiny
			image_index = 3.0
		elif GM.instance_exists(A.obj_mario) and (GM.instance_find(A.obj_mario, 0).stompstyle == 1.0 or GM.instance_find(A.obj_mario, 0).caped > 0.0):
			sprite_index = A.spr_helmet_spiny
			image_index = GM.instance_find(A.obj_mario, 0).image_index
		elif GM.instance_exists(A.obj_mario) and (GM.instance_find(A.obj_mario, 0).isup == 1.0 or GM.instance_find(A.obj_mario, 0).isuphold == 1.0) and GM.instance_find(A.obj_mario, 0).state == 0.0:
			sprite_index = A.spr_helmet_spiny_up
			image_index = 0.0
		else:
			sprite_index = A.spr_helmet_spiny
			image_index = 0.0
