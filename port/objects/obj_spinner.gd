# 第 4 批移植，已核对。
extends GMObject

var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）


# from objects/obj_spinner/Create_0.gml
func _create() -> void:
	if G.jugador == 1.0:
		sprite_index = A.spr_SMB3_luigi_raccoon_attack
	elif G.jugador == 2.0:
		sprite_index = A.spr_SMB3_toad_raccoon_attack
	elif G.jugador == 3.0:
		sprite_index = A.spr_SMB3_toadette_raccoon_attack
	GM.audio_play_sound(A.snd_atack_leaf, 0.0, false)
	image_speed = 0.3
	ready_v = 0.0
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false


# from objects/obj_spinner/Destroy_0.gml
func _destroy() -> void:
	if not GM.instance_exists(A.obj_mario_transform2):
		for inst in GM.with_list(A.obj_mario):
			inst.visible = true
			if inst.image_alpha != 1.0:
				inst.image_alpha = 1.0


# from objects/obj_spinner/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		if G.powerup == -39.0:
			var i_mario = GM.instance_find(A.obj_mario, 0)
			x = GM.gm_round(i_mario.x)
			y = GM.gm_round(i_mario.y)
		else:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_spinner/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if ready_v == 0.0 and other.ready_v == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index == A.obj_flipblock:
				inst.alarm[2] = 1.0
			elif inst.object_index == A.obj_noteblock:
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 7.0
				inst.event_user(0)
			else:
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 4.0
				inst.event_user(0)
				inst.event_user(1)
		GM.other = _o
		ready_v = 1.0


# from objects/obj_spinner/Collision_obj_bowser_fire.gml
func _collision_obj_bowser_fire(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_spinner/Collision_obj_bowser_fire_down.gml
func _collision_obj_bowser_fire_down(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_spinner/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.vspeed >= 0.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		if other.object_index == A.obj_koopa or other.object_index == A.obj_koopa_red or other.object_index == A.obj_buzzybeetle or other.object_index == A.obj_snow_ball_held or other.object_index == A.obj_shell_held:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
					inst2.sprite_index = A.spr_spinthump
				GM.other = inst  # 内层 with 里的 other 是外层的 inst
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), inst.y, A.obj_score)):
					inst2.event_user(0)
				GM.other = self
				inst.event_user(5)
			GM.other = _o
		elif other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create((other.x - 8.0), other.y, A.obj_bobomb_hold)):
				if GM.layer_background_get_sprite(Scr.scr_bg_underwater(inst)) > 0.5:
					inst.vspeed = -0.5
				else:
					inst.vspeed = -1.0
				if (GM.instance_find(A.obj_mario, 0).bbox_left + (inst.bbox_right / 2.0)) < (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = 1.2
					inst.direct = 1.0
				elif (GM.instance_find(A.obj_mario, 0).bbox_left + (inst.bbox_right / 2.0)) > (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = -1.2
					inst.direct = -1.0
				else:
					inst.hspeed = 1.2
					inst.direct = 1.0
			for inst in GM.with_list(other):
				inst.instance_destroy()
			GM.other = _o2
		else:
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
					inst2.sprite_index = A.spr_spinthump
				GM.other = inst
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), inst.y, A.obj_score)):
					inst2.event_user(0)
				GM.other = self
				inst.event_user(0)
			GM.other = _o3


# from objects/obj_spinner/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if other.vspeed == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(5)
		GM.other = _o


# from objects/obj_spinner/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	if other.vspeed == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(7)
		GM.other = _o


# from objects/obj_spinner/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	if other.x >= x:
		for inst in GM.with_list(other):
			inst.fisica = 1.0
			inst.vspeed = -2.0
			inst.hspeed = 1.2
	else:
		for inst in GM.with_list(other):
			inst.fisica = 1.0
			inst.vspeed = -2.0
			inst.hspeed = -1.2


# from objects/obj_spinner/Collision_obj_wrench.gml
func _collision_obj_wrench(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_spinner/Other_7.gml
func _animation_end() -> void:
	instance_destroy()


# from objects/obj_spinner/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		var i_mario = GM.instance_find(A.obj_mario, 0)
		if G.apariencia != 3.0:
			GM.draw_sprite_ext(sprite_index, image_index, i_mario.x, (i_mario.y + 1.0), i_mario.direct, 1.0, 0.0, GM.c_white, i_mario.image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, image_index, i_mario.x, (i_mario.y + 1.0), i_mario.direct, 0.5, 0.0, GM.c_white, i_mario.image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			var i_invincibility = GM.instance_find(A.obj_invincibility, 0)
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, i_mario.x, (i_mario.y + 1.0), i_mario.direct, 1.0, 0.0, i_invincibility.blend_star, i_invincibility.flashAlpha)
			GM.shader_reset()
