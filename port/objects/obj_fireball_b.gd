# from objects/obj_fireball_b（第 5 批移植，已核对）
extends "res://objects/obj_fireball.gd"


# from objects/obj_fireball_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_firegold_ball
		1.0:
			sprite_index = A.spr_SMB3_firegold_ball
		2.0:
			sprite_index = A.spr_firegold_ball
	swimming = 0.0
	GM.audio_play_sound(Scr.scr_snd_fireball(self), 0.0, false)
	image_speed = 0.15
	if place_meeting(x, y, A.obj_solid):
		_user_0()


# from objects/obj_fireball_b/Other_10.gml
func _user_0() -> void:
	GM.audio_play_sound(A.snd_explode, 0.0, false)
	GM.instance_create(x, (y + 8.0), A.obj_gold_explosion)
	instance_destroy()
