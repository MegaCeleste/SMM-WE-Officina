# from objects/obj_thwomp（第 6b 批移植，已核对）
extends "res://objects/obj_enemyparent.gd"

var s_thwomp: int = 0  ## sprite 编号
var s_thwomp_h: int = 0  ## sprite 编号
var edible: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名；obj_nube、obj_block_pow_hold、obj_bortice 等也读写它
var wings_anim: float = 0.0
var salpi: float = 0.0
var salpicadura: float = 0.0
var direct_t: float = 0.0  # scr_edit_to_play、obj_nube、obj_bortice 读写
var groundpount_cont: float = 0.0
var sprite_l: int = 0  ## sprite 编号


# from objects/obj_thwomp/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_thwomp
			s_thwomp = A.spr_SMB_thwomp
			s_thwomp_h = A.spr_SMB_thwomp_h
		1.0:
			sprite_index = A.spr_SMB3_thwomp
			s_thwomp = A.spr_SMB3_thwomp
			s_thwomp_h = A.spr_SMB3_thwomp_h
		2.0:
			sprite_index = A.spr_thwomp
			s_thwomp = A.spr_thwomp
			s_thwomp_h = A.spr_thwomp_h
		3.0:
			sprite_index = A.spr_NSMBU_thwomp
			s_thwomp = A.spr_NSMBU_thwomp
			s_thwomp_h = A.spr_NSMBU_thwomp_h
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
	groundpount_cont = 0.0
	sprite_l = A.spr_SMB3_megasplash_lava
	alarm[10] = 2.0


# from objects/obj_thwomp/Step_0.gml
func _step() -> void:
	var pow
	var ground_block
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
			if ready_v == 0.0 and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > (bbox_left - 32.0) and GM.instance_find(A.obj_mario, 0).x < (bbox_right + 32.0) and y < (GM.instance_find(A.obj_mario, 0).y + 17.0):
				if collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, (bbox_bottom + 2.0), A.obj_spring, false, false) != null:
					vspeed = -1.5
					ready_v = 1.0
				else:
					ready_v = 1.0
			elif ready_v == 1.0:
				if gravity == 0.0:
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					Scr.init_shake(self, 1.0)
					groundpount_cont = 4.0
					ready_v = 2.0
					vspeed = 0.0
					if G.apariencia == 3.0:
						for inst in GM.with_list(GM.instance_create(x, bbox_bottom, A.obj_smoke)):
							inst.sprite_index = A.spr_NSMBU_smoke_thwomp
							inst.depth = -3.0
					else:
						GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
						GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					alarm[0] = 60.0
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
		2.0:
			_user_3()
			if ready_v == 0.0 and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x < (bbox_left + 4.0) and GM.instance_find(A.obj_mario, 0).x > (bbox_left - 112.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 40.0) and GM.instance_find(A.obj_mario, 0).y < (bbox_bottom - 7.0):
				ready_v = 1.0
			elif ready_v == 1.0:
				if collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_onewaygate_right, false, false) != null:
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					Scr.init_shake(self, 1.0)
					groundpount_cont = 4.0
					ready_v = 2.0
					hspeed = 0.0
					GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					alarm[0] = 60.0
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
		3.0:
			_user_3()
			if ready_v == 0.0 and GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > (bbox_right - 4.0) and GM.instance_find(A.obj_mario, 0).x < (bbox_right + 112.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 40.0) and GM.instance_find(A.obj_mario, 0).y < (bbox_bottom - 7.0):
				ready_v = 1.0
			elif ready_v == 1.0:
				if collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_onewaygate_left, false, false) != null:
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					Scr.init_shake(self, 1.0)
					groundpount_cont = 4.0
					ready_v = 2.0
					hspeed = 0.0
					GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
					alarm[0] = 60.0
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


# from objects/obj_thwomp/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_mario):
		match direct_t:
			1.0:
				sprite_index = s_thwomp
				if ready_v == 0.0:
					if GM.instance_find(A.obj_mario, 0).x > (bbox_left - 48.0) and GM.instance_find(A.obj_mario, 0).x < (bbox_left - 32.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 1.0):
						image_index = 1.0
						direct = 1.0
					elif GM.instance_find(A.obj_mario, 0).x < (bbox_right + 48.0) and GM.instance_find(A.obj_mario, 0).x > (bbox_right + 32.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 1.0):
						image_index = 1.0
						direct = -1.0
					else:
						image_index = 0.0
						direct = 1.0
				elif ready_v == 1.0:
					image_index = 2.0
					direct = 1.0
			2.0:
				sprite_index = s_thwomp_h
				if ready_v == 0.0:
					if GM.instance_find(A.obj_mario, 0).x > (bbox_left - 150.0) and GM.instance_find(A.obj_mario, 0).x < (bbox_left + 4.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 40.0) and GM.instance_find(A.obj_mario, 0).y < (bbox_bottom - 7.0):
						image_index = 1.0
						direct = 1.0
					else:
						image_index = 0.0
						direct = 1.0
				elif ready_v == 1.0:
					image_index = 2.0
					direct = 1.0
			3.0:
				sprite_index = s_thwomp_h
				if ready_v == 0.0:
					if GM.instance_find(A.obj_mario, 0).x < (bbox_right + 150.0) and GM.instance_find(A.obj_mario, 0).x > (bbox_right - 4.0) and GM.instance_find(A.obj_mario, 0).y > (bbox_top - 40.0) and GM.instance_find(A.obj_mario, 0).y < (bbox_bottom - 7.0):
						image_index = 1.0
						direct = -1.0
					else:
						image_index = 0.0
						direct = -1.0
				elif ready_v == 1.0:
					image_index = 2.0
					direct = -1.0


# from objects/obj_thwomp/Alarm_0.gml
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


# from objects/obj_thwomp/Alarm_1.gml
func _alarm_1() -> void:
	var sprite_l
	if salpicadura == 1.0:
		if GM.instance_exists(A.obj_lava_water):
			if GM.instance_find(A.obj_lava_water, 0).vspeed != 0.0:
				if G.bg_level != "forest" and (not GM.audio_is_playing(A.snd_podoboo)):
					GM.audio_play_sound(A.snd_podoboo, 0.0, false)
				match G.bg_level:
					"castle":
						match G.apariencia:
							1.0:
								sprite_l = A.spr_SMB3_megasplash_lava
							3.0:
								sprite_l = A.spr_NSMBU_splash_lava
							_:
								sprite_l = A.spr_megasplash_lava
					"mountain":
						if G.modo_noche == 1.0:
							match G.apariencia:
								1.0:
									sprite_l = A.spr_SMB3_megasplash_lava
								3.0:
									sprite_l = A.spr_NSMBU_splash_lava
								_:
									sprite_l = A.spr_megasplash_lava
					_:
						if G.modo_noche == 1.0:
							match G.apariencia:
								1.0:
									sprite_l = A.spr_SMB3_megasplash_lava_purple
								3.0:
									sprite_l = A.spr_NSMBU_splash_posion
								_:
									sprite_l = A.spr_megasplash_lava_purple
						else:
							match G.apariencia:
								1.0:
									sprite_l = A.spr_SMB3_megasplash_water
								3.0:
									sprite_l = A.spr_NSMBU_splash_agua
								_:
									sprite_l = A.spr_megasplash_water
				# ORIG-BUG: 上面算出的是局部变量 sprite_l，下面 with 块里的 other.sprite_l 读的是实例变量 sprite_l
				# （Create 里固定为 spr_SMB3_megasplash_lava，之后没人改），所以水花永远是 SMB3 岩浆水花。照搬：读 self.sprite_l
				for inst in GM.with_list(GM.instance_create((x - 16.0), (GM.instance_find(A.obj_lava_water, 0).y - 16.0), A.obj_smoke)):
					inst.sprite_index = self.sprite_l
					inst.depth = -9.0
				for inst in GM.with_list(GM.instance_create((x + 16.0), (GM.instance_find(A.obj_lava_water, 0).y - 16.0), A.obj_smoke)):
					inst.sprite_index = self.sprite_l
					inst.depth = -9.0
				alarm[1] = 12.0
			else:
				alarm[1] = 1.0


# from objects/obj_thwomp/Alarm_10.gml
func _alarm_10() -> void:
	if direct_t != 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_thwomp_h
			1.0:
				sprite_index = A.spr_SMB3_thwomp_h
			2.0:
				sprite_index = A.spr_thwomp_h
			3.0:
				sprite_index = A.spr_NSMBU_thwomp_h


# from objects/obj_thwomp/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	if o.hardness < 99.0 and other.visible == true and (bbox_bottom - vspeed) < other.bbox_top:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_thwomp/Other_10.gml
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


# from objects/obj_thwomp/Other_13.gml
func _user_3() -> void:
	var semisolid
	var physolid
	var thwomp
	var thwomp2
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		thwomp = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_thwomp, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if thwomp != null and thwomp != self and bbox_bottom < (thwomp.yprevious + 5.0):
			y = (thwomp.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
		if y >= ystart:
			y = ystart
	thwomp2 = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_thwomp, false, false)
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)) or (thwomp2 != null and thwomp2 != self) or y == ystart:
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.025
		if vspeed > 0.5:
			vspeed = 0.5
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_thwomp/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
		if ready_v == 0.0 and y >= ystart:
			y = ystart
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)) or (ready_v == 0.0 and y == ystart):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.025
		if vspeed > 0.5:
			vspeed = 0.5
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height:
		instance_destroy()


# from objects/obj_thwomp/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
