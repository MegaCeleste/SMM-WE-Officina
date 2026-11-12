extends "res://objects/obj_icicle.gd"


# from objects/obj_mini_icicle/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create(xstart, ystart, A.obj_mini_icicle)):
		inst.image_xscale = 0.2
		inst.image_yscale = 0.2
		inst.crecer = 1.0
	instance_destroy()


# from objects/obj_mini_icicle/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_estalactita_break)
			GM.audio_play_sound(A.snd_SMB3_estalactita_break, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_estalactita_break)
			GM.audio_play_sound(A.snd_estalactita_break, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_estalactita_break)
			GM.audio_play_sound(A.snd_NSMBU_estalactita_break, 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 4.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(30.0, 5.0)
		inst.sprite_index = A.spr_icicle_break
		inst.image_index = G.apariencia
		inst.dir = 1.0
		inst.direct = -1.0
	for inst in GM.with_list(GM.instance_create((x + 4.0), (y + 4.0), A.obj_shard)):
		inst.motion_set(150.0, 5.0)
		inst.sprite_index = A.spr_icicle_break
		inst.image_index = G.apariencia
		inst.dir = 0.0
	y = (GM.room_height + 64.0)
