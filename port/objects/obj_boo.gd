extends "res://objects/obj_deactenemyparent.gd"

var sprite: float = 0.0
var sprite_hidden: float = 0.0
var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var velocity: float = 0.0
var inup: float = 0.0
var stretch: float = 0.0
var cankill: float = 0.0
var movenow: float = 0.0
var move_sound: float = 0.0
var movenowprev: float = 0.0


# from objects/obj_boo/Create_0.gml
func _create() -> void:
	sprite = A.spr_NSMBU_boo_overworld
	sprite_hidden = A.spr_NSMBU_boo_overworld_hidden
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_boo
			sprite_wings = A.spr_SMB_wings
		1.0:
			sprite_index = A.spr_SMB3_boo
			sprite_wings = A.spr_SMB3_wings
		2.0:
			sprite_index = A.spr_boo
			sprite_wings = A.spr_wings
		3.0:
			if G.bg_level == "ghost":
				sprite_index = A.spr_NSMBU_boo_ghost
				sprite = A.spr_NSMBU_boo_ghost
				sprite_hidden = A.spr_NSMBU_boo_ghost_hidden
			else:
				sprite_index = A.spr_NSMBU_boo_overworld
				sprite = A.spr_NSMBU_boo_overworld
				sprite_hidden = A.spr_NSMBU_boo_overworld_hidden
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 100.0
	stomp = 2.0
	edible = 2.0
	dead_h = 0.0
	modo_lava = 0.0
	wings = 0.0
	wings_anim = 0.0
	direct = -1.0
	swimming = 0.0
	velocity = 0.025
	apilar = 0.0
	inup = 0.0
	stretch = 0.0
	cankill = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.0
	movenow = 1.0
	move_sound = 1.0
	movenowprev = 1.0
	boo_huida = 0.0
	alarm[10] = 1.0
	alarm[2] = 5.0


# from objects/obj_boo/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = 1.0
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = -1.0


# from objects/obj_boo/Step_1.gml
func _step_begin() -> void:
	return


# from objects/obj_boo/Step_0.gml
func _step() -> void:
	match inup:
		1.0:
			if (hspeed < 0.0 and (not position_meeting(bbox_left, (y - 12.0), A.obj_solid))) or (hspeed > 0.0 and (not position_meeting(bbox_right, (y - 12.0), A.obj_solid))):
				hspeed = (-hspeed)
			if cankill == 1.0 and (not place_meeting(x, (y - 12.0), A.obj_solid)) and (not place_meeting(x, (y - 12.0), A.obj_physicssolid)):
				_user_0()
		2.0:
			_user_6()
			if cankill == 1.0 and (not place_meeting(x, (y + 12.0), A.obj_solidtop)) and (not place_meeting(x, (y + 12.0), A.obj_physicssolid)):
				_user_0()
		_:
			if boo_huida == 1.0:
				vspeed = -2.0
				hspeed = GM.choose(2.0, -2.0)
				boo_huida = 0.0
			else:
				_user_8()
				if wings == 0.0:
					velocity = 0.015
					if speed > 0.4:
						speed = 0.4
				else:
					if G.apariencia == 3.0:
						wings_anim += 1.0
					else:
						wings_anim += 0.12
					velocity = 0.1
					if speed > 0.8:
						speed = 0.8


# from objects/obj_boo/Step_2.gml
func _step_end() -> void:
	if stretch == 2.0:
		if image_index < 1.0:
			if G.apariencia == 3.0:
				sprite_index = A.spr_NSMBU_boo_stretch
				image_speed = 0.5
				GM.audio_stop_sound(A.snd_NSMBU_boo)
				GM.audio_play_sound(A.snd_NSMBU_boo, 0.0, false)
			else:
				sprite_index = A.spr_boo_stretch
				image_speed = 0.0
				image_index = G.apariencia
			stomp = 2.0
			stretch = 0.0
			hspeed = (1.0 * direct)
			alarm[0] = 180.0
	if inup > 0.0 and stretch == 0.0:
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
		_user_3()


# from objects/obj_boo/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_boo_stretch_d
		1.0:
			sprite_index = A.spr_SMB3_boo_stretch_d
		2.0:
			sprite_index = A.spr_boo_stretch_d
		3.0:
			sprite_index = A.spr_NSMBU_boo_stretch_hide
	image_index = 0.0
	if G.apariencia == 3.0:
		image_index = 0.3
	else:
		image_speed = 0.15
	hspeed = 0.0
	stretch = 1.0
	stomp = -1.0


# from objects/obj_boo/Alarm_1.gml
func _alarm_1() -> void:
	if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid) or place_meeting(x, y, A.obj_bullebill_base) or place_meeting(x, y, A.obj_modelbgo):
		alarm[1] = 2.0
		return
	else:
		if G.apariencia == 3.0:
			image_speed = -0.3
		else:
			image_speed = -0.15
		hspeed = 0.0
		visible = true
		stretch = 2.0


# from objects/obj_boo/Alarm_2.gml
func _alarm_2() -> void:
	cankill = 1.0


# from objects/obj_boo/Alarm_10.gml
func _alarm_10() -> void:
	if inup > 0.0:
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_boo_stretch
		else:
			sprite_index = A.spr_boo_stretch
			image_index = G.apariencia
		hspeed = (1.0 * direct)
		alarm[0] = 180.0


# from objects/obj_boo/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if inup > 0.0 and other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0) and vspeed >= 0.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		_user_0()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_boo/Other_7.gml
func _animation_end() -> void:
	if stretch == 1.0:
		image_speed = 0.0
		image_index = 3.9
		visible = false
		hspeed = (1.0 * direct)
		alarm[1] = GM.choose(90.0, 60.0)


# from objects/obj_boo/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	imdead.direct = direct
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_boo_dead)
		GM.audio_play_sound(A.snd_NSMBU_boo_dead, 0.0, false)
	if dead_h == 0.0:
		# ORIG-BUG: other.bbox_left + (bbox_right / 2) 把 other 与 self 的包围盒混用，照搬
		if GM.other.hspeed == 0.0:
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


# from objects/obj_boo/Other_15.gml
func _user_5() -> void:
	return


# from objects/obj_boo/Other_16.gml
func _user_6() -> void:
	if gravity == 0.0:
		if hspeed < 0.0:
			if ((collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null)) or collision_rectangle((bbox_left - 3.0), (bbox_bottom - 1.0), (bbox_left - 3.0), (bbox_bottom + 4.0), A.obj_platform_parent, false, false) != null:
				hspeed = (-hspeed)
		elif hspeed > 0.0:
			if ((collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null)) or collision_rectangle((bbox_right + 3.0), (bbox_bottom - 1.0), (bbox_right + 3.0), (bbox_bottom + 4.0), A.obj_platform_parent, false, false) != null:
				hspeed = (-hspeed)


# from objects/obj_boo/Other_18.gml
func _user_8() -> void:
	if GM.instance_exists(A.obj_mario) and movenow == 0.0:
		if GM.instance_find(A.obj_mario, 0).x > (x + 8.0):
			hspeed += velocity
			direct = 1.0
		elif GM.instance_find(A.obj_mario, 0).x < (x - 8.0):
			hspeed -= velocity
			direct = -1.0
		if (GM.instance_find(A.obj_mario, 0).y + 20.0) > y:
			vspeed += velocity
		elif (GM.instance_find(A.obj_mario, 0).y + 16.0) < y:
			vspeed -= velocity
	else:
		speed = (maxf(0.0, (absf(speed) - 0.025)) * GM.gm_sign(speed))
		if speed < velocity:
			speed = 0.0
	movenowprev = movenow
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x > (x + 4.0):
			if GM.instance_find(A.obj_mario, 0).direct == 1.0:
				movenow = 0.0
				if G.apariencia == 3.0 and move_sound == 1.0:
					GM.audio_stop_sound(A.snd_NSMBU_boo)
					GM.audio_stop_sound(A.snd_NSMBU_boo_stop)
					if GM.choose(0.0, 1.0, 0.0, 1.0, 0.0, 1.0) == 1.0 and (Scr.outside_view(self) <= 0.5):
						GM.audio_play_sound(A.snd_NSMBU_boo, 0.0, false)
					move_sound = 0.0
			else:
				movenow = 1.0
				if G.apariencia == 3.0 and move_sound == 0.0:
					GM.audio_stop_sound(A.snd_NSMBU_boo)
					GM.audio_stop_sound(A.snd_NSMBU_boo_stop)
					if Scr.outside_view(self) <= 0.5:
						GM.audio_play_sound(A.snd_NSMBU_boo_stop, 0.0, false)
					move_sound = 1.0
		elif GM.instance_find(A.obj_mario, 0).x < (x - 4.0):
			if GM.instance_find(A.obj_mario, 0).direct == -1.0:
				movenow = 0.0
				if G.apariencia == 3.0 and move_sound == 1.0:
					GM.audio_stop_sound(A.snd_NSMBU_boo)
					GM.audio_stop_sound(A.snd_NSMBU_boo_stop)
					if GM.choose(0.0, 1.0, 0.0, 1.0, 0.0, 1.0) == 1.0 and (Scr.outside_view(self) <= 0.5):
						GM.audio_play_sound(A.snd_NSMBU_boo, 0.0, false)
					move_sound = 0.0
			else:
				movenow = 1.0
				if G.apariencia == 3.0 and move_sound == 0.0:
					GM.audio_stop_sound(A.snd_NSMBU_boo)
					GM.audio_stop_sound(A.snd_NSMBU_boo_stop)
					if Scr.outside_view(self) <= 0.5:
						GM.audio_play_sound(A.snd_NSMBU_boo_stop, 0.0, false)
					move_sound = 1.0
		else:
			movenow = 1.0
			if G.apariencia == 3.0 and move_sound == 0.0:
				GM.audio_stop_sound(A.snd_NSMBU_boo)
				GM.audio_stop_sound(A.snd_NSMBU_boo_stop)
				if Scr.outside_view(self) <= 0.5:
					GM.audio_play_sound(A.snd_NSMBU_boo_stop, 0.0, false)
				move_sound = 1.0
	else:
		movenow = 1.0
		if G.apariencia == 3.0 and move_sound == 0.0:
			GM.audio_stop_sound(A.snd_NSMBU_boo)
			GM.audio_stop_sound(A.snd_NSMBU_boo_stop)
			if Scr.outside_view(self) <= 0.5:
				GM.audio_play_sound(A.snd_NSMBU_boo_stop, 0.0, false)
			move_sound = 1.0
	if G.apariencia == 3.0:
		if movenow == 0.0:
			sprite_index = sprite
			image_speed = 0.3
		else:
			sprite_index = sprite_hidden
			if image_index > 2.7:
				image_speed = 0.0
				image_index = 2.0
			else:
				image_speed = 0.3


# from objects/obj_boo/Draw_0.gml
func _gm_draw() -> void:
	match inup:
		1.0:
			GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, -1.0, 0.0, GM.c_white, 1.0)
		2.0:
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
		_:
			if G.apariencia == 3.0:
				if G.bg_level == "ghost":
					GM.draw_sprite(A.spr_NSMBU_boo_light, 0.0, GM.gm_round(x), y)
				GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
			else:
				GM.draw_sprite_ext(sprite_index, movenow, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
			if wings == 1.0:
				GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, 0.0, GM.c_white, 1.0)
