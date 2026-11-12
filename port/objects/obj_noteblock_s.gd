# from objects/obj_noteblock_s（第 5 批移植，已核对）
extends "res://objects/obj_noteblock.gd"


# from objects/obj_noteblock_s/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	match G.apariencia:
		2.0:
			sound_block = A.snd_spring
		3.0:
			sound_block = A.snd_NSMBU_noteblock
		_:
			sound_block = A.snd_SMB3_spring
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
	sprite_wings = A.spr_SMB_wings_16x16


# from objects/obj_noteblock_s/Step_0.gml
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
		if collision_rectangle(bbox_left, (bbox_top - 3.0), bbox_right, bbox_top, A.obj_mario, false, false) != null and GM.instance_find(A.obj_mario, 0).bbox_bottom < bbox_top and GM.instance_find(A.obj_mario, 0).vspeed >= 0.0 and ready2 == 0.0:
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


# from objects/obj_noteblock_s/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	if ready2 == 1.0 and GM.instance_exists(A.obj_mario) and place_meeting(x, (y - 16.0), A.obj_mario):
		ready2 = 0.0
		for inst in GM.with_list(A.obj_mario):
			GM.audio_stop_sound(int(sound_block))
			GM.audio_play_sound(int(sound_block), 0.0, false)
			if inst.isswim == 1.0:
				inst.vspeed = -3.0
			else:
				inst.vspeed = -5.0
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
	if G.apariencia == 3.0:
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_smoke_foo
	else:
		GM.instance_create(x, y, A.obj_smoke)
	instance_destroy()
