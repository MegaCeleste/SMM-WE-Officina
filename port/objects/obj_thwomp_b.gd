# from objects/obj_thwomp_b（第 6b 批移植，已核对）
extends "res://objects/obj_thwomp.gd"

var terra: float = 0.0


# from objects/obj_thwomp_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_thwomp_b
			s_thwomp = A.spr_SMB_thwomp_b
			s_thwomp_h = A.spr_SMB_thwomp_h_b
		1.0:
			sprite_index = A.spr_SMB3_thwomp_b
			s_thwomp = A.spr_SMB3_thwomp_b
			s_thwomp_h = A.spr_SMB3_thwomp_h_b
		2.0:
			sprite_index = A.spr_thwomp_b
			s_thwomp = A.spr_thwomp_b
			s_thwomp_h = A.spr_thwomp_h_b
		3.0:
			sprite_index = A.spr_NSMBU_thwomp_b
			s_thwomp = A.spr_NSMBU_thwomp_b
			s_thwomp_h = A.spr_NSMBU_thwomp_h_b
	hardness = 99.0
	stomp = 2.0
	edible = 2.0
	direct = 1.0
	swimming = 0.0
	ready_v = 0.0
	image_speed = 0.0
	image_index = 0.0
	modo_lava = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	dead_h = 1.0
	apilar = 0.0
	salpi = 0.0
	salpicadura = 0.0
	direct_t = 1.0
	direct = 1.0
	terra = 0.0
	groundpount_cont = 0.0
	sprite_l = A.spr_SMB3_megasplash_lava
	alarm[10] = 2.0


# from objects/obj_thwomp_b/Step_0.gml
func _step() -> void:
	var pow
	var ground_block
	var rock_block
	var spd: float
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if collision_rectangle(bbox_left, (bbox_top + 2.0), bbox_right, (bbox_bottom - 1.0), A.obj_lava_water, false, false) != null and G.apariencia != 0.0:
		if salpi == 0.0:
			salpicadura = 1.0
			salpi = 1.0
			alarm[1] = 1.0
	else:
		salpi = 0.0
		salpicadura = 0.0
	match direct_t:
		1.0:
			if ready_v < 2.0:
				_user_4()
			if ready_v == 0.0 and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > (bbox_left - 16.0) and GM.instance_find(A.obj_mario, 0).x < (bbox_right + 16.0) and y < (GM.instance_find(A.obj_mario, 0).y + 9.0):
				if collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_spring, false, false) != null:
					vspeed = -1.5
					ready_v = 1.0
				else:
					ready_v = 1.0
			elif ready_v == 1.0:
				if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_spring, false, false) != null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_nube, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_pow_hold, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_blockparent, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_rock, false, false) == null) and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_ice, false, false) == null):
					if gravity == 0.0:
						GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
						GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
						Scr.init_shake(self, 1.0)
						groundpount_cont = 4.0
						vspeed = 0.0
						ready_v = 2.0
						if G.apariencia == 3.0:
							for inst in GM.with_list(GM.instance_create(x, bbox_bottom, A.obj_smoke)):
								inst.sprite_index = A.spr_NSMBU_smoke_thwomp
								inst.depth = -3.0
						else:
							GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
							GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
						alarm[0] = 60.0
				else:
					if gravity == 0.0:
						GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
						GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
						groundpount_cont = 4.0
			elif ready_v == 3.0:
				if collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_solid, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, false, false) != null:
					ready_v = 0.0
					groundpount_cont = 0.0
					vspeed = 0.0
					ystart = y
					y = ystart
				elif y < (ystart + 1.0):
					ready_v = 0.0
					groundpount_cont = 0.0
					vspeed = 0.0
					y = ystart
			if groundpount_cont > 0.0:
				groundpount_cont -= 1.0
				pow = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_block_pow_hold, false, false)
				if pow != null:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(pow):
						inst.explode = 1.0
						inst.event_user(6)
					GM.other = _o
				ground_block = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_blockparent, false, false)
				rock_block = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_rockparent, false, false)
				if ground_block != null and ground_block.object_index != A.obj_noteblock and ground_block.object_index != A.obj_musicblock and ground_block.object_index != A.obj_noteblock_s and ground_block.ready_v == 0.0:
					if ground_block.object_index == A.obj_flipblock:
						for inst in GM.with_list(ground_block):
							inst.alarm[2] = 1.0
					else:
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(ground_block):
							inst.event_user(3)
						GM.other = _o
				if rock_block != null:
					for inst in GM.with_list(rock_block):
						inst.alarm[0] = 1.0
		2.0:
			_user_3()
			if ready_v == 0.0 and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x < (bbox_left + 2.0) and GM.instance_find(A.obj_mario, 0).x > (bbox_left - 56.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 20.0) and GM.instance_find(A.obj_mario, 0).y < (bbox_bottom - 4.0):
				ready_v = 1.0
			elif ready_v == 1.0:
				if (collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_onewaygate_right, false, false) != null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_rock, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_ice, false, false) == null):
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					Scr.init_shake(self, 1.0)
					groundpount_cont = 4.0
					ready_v = 2.0
					hspeed = 0.0
					GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					alarm[0] = 60.0
				elif ((collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, false, false) != null)) or ((collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_rock, false, false) != null)) or ((collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_ice, false, false) != null)):
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					groundpount_cont = 4.0
				else:
					hspeed -= 0.05
					spd = (3.0 - (1.5 * swimming))
					if hspeed < (-spd):
						hspeed = (-spd)
			elif ready_v == 3.0:
				if collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_onewaygate_left, false, false) != null:
					ready_v = 0.0
					hspeed = 0.0
					xstart = x
					x = xstart
				elif x > (xstart + 1.0):
					ready_v = 0.0
					hspeed = 0.0
					x = xstart
			if groundpount_cont > 0.0:
				groundpount_cont -= 1.0
				ground_block = collision_rectangle(((bbox_left + hspeed) - 2.0), bbox_top, bbox_left, bbox_bottom, A.obj_blockparent, false, false)
				rock_block = collision_rectangle(((bbox_left + hspeed) - 2.0), bbox_top, bbox_left, bbox_bottom, A.obj_rockparent, false, false)
				if ground_block != null and ground_block.ready_v == 0.0:
					if ground_block.object_index == A.obj_flipblock:
						for inst in GM.with_list(ground_block):
							inst.alarm[2] = 1.0
					else:
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(ground_block):
							inst.event_user(15)
						GM.other = _o
				if rock_block != null:
					for inst in GM.with_list(rock_block):
						inst.alarm[0] = 1.0
		3.0:
			_user_3()
			if ready_v == 0.0 and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > (bbox_right - 2.0) and GM.instance_find(A.obj_mario, 0).x < (bbox_right + 56.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 20.0) and GM.instance_find(A.obj_mario, 0).y < (bbox_bottom - 4.0):
				ready_v = 1.0
			elif ready_v == 1.0:
				if (collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_onewaygate_left, false, false) != null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_blockparent, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_block_rock, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_block_ice, false, false) == null):
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					Scr.init_shake(self, 1.0)
					groundpount_cont = 4.0
					ready_v = 2.0
					hspeed = 0.0
					GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					alarm[0] = 60.0
				elif ((collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_blockparent, false, false) != null)) or ((collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_block_rock, false, false) != null)) or ((collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_block_ice, false, false) != null)):
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					groundpount_cont = 4.0
				else:
					hspeed += 0.05
					spd = (3.0 - (1.5 * swimming))
					if hspeed > spd:
						hspeed = spd
			elif ready_v == 3.0:
				if collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_onewaygate_right, false, false) != null:
					ready_v = 0.0
					hspeed = 0.0
					xstart = x
					x = xstart
				elif x < (xstart - 1.0):
					ready_v = 0.0
					hspeed = 0.0
					x = xstart
			if groundpount_cont > 0.0:
				groundpount_cont -= 1.0
				ground_block = collision_rectangle(bbox_right, bbox_top, ((bbox_right + hspeed) + 2.0), bbox_bottom, A.obj_blockparent, false, false)
				rock_block = collision_rectangle(bbox_right, bbox_top, ((bbox_right + hspeed) + 2.0), bbox_bottom, A.obj_rockparent, false, false)
				if ground_block != null and ground_block.ready_v == 0.0:
					if ground_block.object_index == A.obj_flipblock:
						for inst in GM.with_list(ground_block):
							inst.alarm[2] = 1.0
					else:
						var _o: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(ground_block):
							inst.event_user(2)
						GM.other = _o
				if rock_block != null:
					for inst in GM.with_list(rock_block):
						inst.alarm[0] = 1.0


# from objects/obj_thwomp_b/Alarm_0.gml
func _alarm_0() -> void:
	if ready_v == 2.0:
		match direct_t:
			1.0:
				vspeed = -1.0
			2.0:
				hspeed = 1.0
			3.0:
				hspeed = -1.0
		ready_v = 3.0
		image_index = 0.0
		direct = 1.0
		groundpount_cont = 0.0


# from objects/obj_thwomp_b/Alarm_10.gml
func _alarm_10() -> void:
	if direct_t != 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_thwomp_h_b
			1.0:
				sprite_index = A.spr_SMB3_thwomp_h_b
			2.0:
				sprite_index = A.spr_thwomp_h_b
			3.0:
				sprite_index = A.spr_NSMBU_thwomp_h_b


# from objects/obj_thwomp_b/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬（同 obj_koopa）
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()
