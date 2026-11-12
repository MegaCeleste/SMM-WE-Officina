# 第 7 批移植，已核对。
extends "res://objects/obj_clown.gd"

var sprite_carga: float = 0.0
var fire: float = 0.0
var anim_fire_charge: float = 0.0


# from objects/obj_clown_fire/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			s_clown = A.spr_SMB_clown_fire
			s_clown_eyes = A.spr_SMB_clown_fire_eyes
			s_clown_evil = A.spr_SMB_clown_fire_evil
			s_clown_damage = A.spr_SMB_clown_fire_damage
		1.0:
			s_clown = A.spr_SMB3_clown_fire
			s_clown_eyes = A.spr_SMB3_clown_fire_eyes
			s_clown_evil = A.spr_SMB3_clown_fire_evil
			s_clown_damage = A.spr_SMB3_clown_fire_damage
		2.0:
			s_clown = A.spr_clown_fire
			s_clown_eyes = A.spr_clown_fire_eyes
			s_clown_evil = A.spr_clown_fire_evil
			s_clown_damage = A.spr_clown_fire_damage
		3.0:
			s_clown = A.spr_NSMBU_clown_fire
			s_clown_eyes = A.spr_NSMBU_clown_fire_eyes
			s_clown_evil = A.spr_NSMBU_clown_fire_evil
			s_clown_damage = A.spr_NSMBU_clown_fire_damage
	s_clown_link = A.spr_SMB_clown_fire_link
	if G.apariencia == 3.0:
		sprite_carga = A.spr_NSMBU_clown_smoke
	else:
		sprite_carga = A.spr_clown_smoke
	s_clown_evil_bounce = 0.0
	s_clown_bounce = 0.0
	fire = 0.0
	carga = 0.0
	anim_fire_charge = 0.0
	alarm[4] = 120.0


# from objects/obj_clown_fire/Destroy_0.gml
func _destroy() -> void:
	super._destroy()
	GM.audio_stop_sound(Scr.scr_snd_clown_fire_charge(self))


# from objects/obj_clown_fire/Step_1.gml
func _step_begin() -> void:
	if carga == 1.0:
		anim_fire_charge += 0.15
	if inmario == 1.0 and carga == 0.0 and GM.keyboard_check(G.lanzar_agarrar):
		if G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_NSMBU_clown_charge_start, 0.0, false)
		else:
			GM.audio_play_sound(Scr.scr_snd_clown_fire_charge(self), 0.0, false)
		carga = 1.0
	if inmario == 1.0:
		if carga == 1.0:
			if GM.instance_exists(A.obj_mario):
				if GM.keyboard_check(G.lanzar_agarrar):
					if G.apariencia == 3.0 and (not GM.audio_is_playing(A.snd_NSMBU_clown_charge_start)) and (not GM.audio_is_playing(A.snd_NSMBU_clown_charge_end)):
						GM.audio_play_sound(A.snd_NSMBU_clown_charge_end, 1.0, true)
					if fire > 120.0:
						sprite_index = s_clown_evil
					else:
						fire += 2.0
						if x_scale < 1.2:
							x_scale += 0.002
							y_scale += 0.002
						else:
							x_scale = 1.2
							y_scale = 1.2
				else:
					carga = 0.0
					audio_charge = 0.0
					sprite_index = s_clown
					GM.audio_stop_sound(Scr.scr_snd_clown_fire_charge(self))
					GM.audio_stop_sound(A.snd_NSMBU_clown_charge_start)
					GM.audio_stop_sound(A.snd_NSMBU_clown_charge_end)
					if fire > 120.0:
						if G.powerup == 2.0:
							if GM.instance_number(A.obj_fire_clown) < 3:
								for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown)):
									inst.vspeed = -0.5
									inst.hspeed = (3.0 * self.direct)
									inst.direct = self.direct
								for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown)):
									inst.vspeed = 0.0
									inst.hspeed = (3.0 * self.direct)
									inst.direct = self.direct
								for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown)):
									inst.vspeed = 0.5
									inst.hspeed = (3.0 * self.direct)
									inst.direct = self.direct
								fire = 0.0
						elif GM.instance_number(A.obj_fire_clown) < 2:
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown)):
								inst.hspeed = (3.0 * self.direct)
								inst.direct = self.direct
								inst.vspeed = 0.0
							fire = 0.0
					elif G.powerup == 2.0:
						if GM.instance_number(A.obj_fire_clown_small) < 6:
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown_small)):
								inst.vspeed = -0.5
								inst.hspeed = (3.0 * self.direct)
								inst.gravity = 0.0
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown_small)):
								inst.vspeed = 0.0
								inst.hspeed = (3.0 * self.direct)
								inst.gravity = 0.0
							for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown_small)):
								inst.vspeed = 0.5
								inst.hspeed = (3.0 * self.direct)
								inst.gravity = 0.0
							fire = 0.0
					elif GM.instance_number(A.obj_fire_clown_small) < 2:
						for inst in GM.with_list(GM.instance_create(x, y, A.obj_fire_clown_small)):
							inst.hspeed = (3.0 * self.direct)
							inst.gravity = 0.0
							inst.vspeed = 0.0
						fire = 0.0
	if carga == 0.0:
		if x_scale > 1.0:
			x_scale -= 0.02
			y_scale -= 0.02
		else:
			x_scale = 1.0
			y_scale = 1.0


# from objects/obj_clown_fire/Alarm_4.gml
func _alarm_4() -> void:
	if inenemy == 1.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_plantfire)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_fireball
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_fireball
			inst.hspeed = (3.0 * self.direct)
			inst.gravity = 0.0
			inst.vspeed = 0.0
		alarm[4] = 120.0
	else:
		alarm[4] = 60.0


# from objects/obj_clown_fire/Draw_0.gml
func _gm_draw() -> void:
	super._gm_draw()
	if carga == 1.0:
		if G.apariencia == 3.0:
			GM.draw_sprite_ext(sprite_carga, anim_fire_charge, (x + (12.0 * direct)), (y + 9.0), direct, 1.0, 0.0, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(sprite_carga, anim_fire_charge, x, (y + 5.0), direct, 1.0, 0.0, GM.c_white, 1.0)
