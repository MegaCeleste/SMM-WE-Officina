# from objects/obj_snow_ball_b（第 5 批移植，已核对）
extends "res://objects/obj_snow_ball.gd"


# from objects/obj_snow_ball_b/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			imagen = A.spr_SMB_spike_ball_b
			sprite_index = A.spr_SMB_spike_ball_b
		1.0:
			imagen = A.spr_SMB3_spike_ball_b
			sprite_index = A.spr_SMB3_spike_ball_b
		2.0:
			imagen = A.spr_spike_ball_b
			sprite_index = A.spr_spike_ball_b
		3.0:
			imagen = A.spr_NSMBU_spike_ball_b
			sprite_index = A.spr_NSMBU_spike_ball_b


# from objects/obj_snow_ball_b/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if kickme == 1.0:
		if held == 0.0:
			if inmune == 0.0:
				if (other.stompstyle == 1.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0)) or (G.yoshi == 2.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0):
					if G.apariencia < 2.0:
						if GM.instance_exists(A.obj_kuribo_drybones):
							GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
						else:
							GM.audio_play_sound(A.snd_step_enemy, 0.0, false)
					else:
						GM.audio_play_sound(A.snd_kick, 0.0, false)
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(other):
						inst.event_user(1)
					GM.other = _o
					GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
					_user_0()
				elif vspeed >= 0.0 or (vspeed >= 0.0 and G.yoshi > 0.0):
					GM.audio_stop_sound(Scr.scr_snd_kick(self))
					GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
						inst.sprite_index = A.spr_spinthump
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_mario):
						if inst.holding == 0.0 and G.apariencia != 0.0 and G.apariencia != 3.0:
							inst.event_user(7)
					GM.other = _o2
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_snow_ball_held)):
						inst.alarm[0] = 5.0
						inst.fisica = 1.0
						inst.vspeed = -0.5
						inst.posy = 0.0
						inst.sprite_index = self.sprite_index
						inst.imagen = self.sprite_index
						inst.mask_index = self.sprite_index
						if GM.instance_exists(A.obj_mario):
							if (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship"):
								if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < inst.x:
									inst.hspeed = 2.5
								else:
									inst.hspeed = -2.5
							elif (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < inst.x:
								inst.hspeed = 3.5
							else:
								inst.hspeed = -3.5
						inst.inmune = 1.0
						inst.alarm[2] = 12.0
					instance_destroy()


# from objects/obj_snow_ball_b/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(imagen, 2.0, GM.gm_round(x), y, 1.0, 1.0, angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, (y - 16.0), 1.0, 1.0, image_angle, GM.c_white, 1.0)


# from objects/obj_snow_ball_b/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, (y - 16.0), A.obj_smoke)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_snow_ball_effect
			2.0:
				inst.sprite_index = A.spr_snow_ball_effect
			_:
				inst.sprite_index = A.spr_SMB3_snow_ball_effect
		inst.image_speed = 0.25
		inst.scale = 2.0
	instance_destroy()
