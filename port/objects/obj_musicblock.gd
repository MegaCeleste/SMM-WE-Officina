# from objects/obj_musicblock（第 5 批移植，已核对）
extends "res://objects/obj_noteblock.gd"


# from objects/obj_musicblock/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_musicblock
			image_speed = 0.0
			sprite_wings = A.spr_SMB_wings_16x16
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 3.0
				"castle":
					image_index = 2.0
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				_:
					if G.modo_noche == 1.0:
						image_index = 1.0
					else:
						image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_musicblock
			image_speed = 0.15
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_index = A.spr_musicblock
			image_speed = 0.15
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_musicblock
			image_speed = 0.25
			sprite_wings = A.spr_NSMBU_wings_items
	sound_block = A.snd_NSMBU_noteblock
	up = 0.0
	down = 0.0
	sprout = -1.0
	ready_v = 0.0
	ready2 = 0.0
	wings = 0.0
	wings_anim = 0.0
	expand = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	disabled = 1.0
	index = A.snd_mb_mario


# from objects/obj_musicblock/Step_0.gml
func _step() -> void:
	if ready_v == 1.0:
		if vspeed < 0.0 and down == 0.0 and y <= (ystart - 8.0):
			vspeed = 2.0
			down = 1.0
		elif vspeed > 0.0 and down == 1.0 and y >= ystart:
			down = 0.0
			alarm[1] = 1.0
		if vspeed > 0.0 and up == 0.0 and y >= (ystart + 12.0):
			up = 1.0
			vspeed = -2.0
		elif vspeed < 0.0 and up == 1.0 and y <= ystart:
			up = 0.0
			alarm[1] = 1.0
	if ready_v == 0.0:
		if collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_mario, false, false) != null and GM.instance_find(A.obj_mario, 0).bbox_bottom < bbox_top and GM.instance_find(A.obj_mario, 0).vspeed >= 0.0 and ready2 == 0.0:
			ready_v = 1.0
			ready2 = 1.0
			vspeed = 2.0
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 0.0
				inst.event_user(15)
				inst.groundpount = 0.0
			GM.other = _o
	if ready2 == 1.0 and GM.instance_exists(A.obj_mario) and collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_mario, false, false) != null:
		for inst in GM.with_list(A.obj_mario):
			inst.y = ((y - 32.0) + vspeed)
		for inst in GM.with_list(A.obj_mario):
			inst.state = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = 0.0
	_user_4()


# from objects/obj_musicblock/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	if ready2 == 1.0 and GM.instance_exists(A.obj_mario) and place_meeting(x, (y - 16.0), A.obj_mario):
		ready2 = 0.0
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 16.0), A.obj_smoke)):
			inst.sprite_index = A.spr_mininotes
			inst.image_speed = 0.5
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			# with (other.id): self 变回本 musicblock，other 是 mario 实例
			GM.other = inst
			index = A.snd_mb_mario
			_user_5()
			GM.other = self
			inst.vspeed = (-(5.0 - (2.0 * inst.isswim)))
			inst.y -= 1.0
			inst.state = 2.0
			inst.helice_fly = 0.0
			if GM.keyboard_check(int(G.saltar)):
				inst.jumpnow = 1.0
			elif GM.keyboard_check(int(G.saltar_spin)) and inst.holding == 0.0 and G.apariencia > 1.0:
				if G.apariencia == 3.0:
					GM.audio_play_sound(A.snd_NSMBU_spinjump, 0.0, false)
				else:
					GM.audio_play_sound(A.snd_spin, 0.0, false)
				inst.stompstyle = 1.0
			else:
				inst.jumpnow = 2.0
		GM.other = _o
	ready2 = 0.0
	alarm[4] = 2.0
