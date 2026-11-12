# from objects/obj_flipblock_anim（第 5 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var flips: float = 0.0
var convertirse: float = 0.0


# from objects/obj_flipblock_anim/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	flips = 8.0
	convertirse = 1.0


# from objects/obj_flipblock_anim/Step_0.gml
func _step() -> void:
	if convertirse == 1.0:
		if GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin)):
				inst.convertirse = 0.0
			instance_destroy()
	elif convertirse == 0.0:
		if not GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_coin)):
				inst.convertirse = 1.0
			instance_destroy()


# from objects/obj_flipblock_anim/Other_7.gml
func _animation_end() -> void:
	if flips > 0.0:
		flips -= 1.0
	elif not place_meeting(x, y, A.obj_mario):
		GM.instance_create(x, y, A.obj_flipblock)
		instance_destroy()
