# from objects/obj_superflower（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"


# from objects/obj_superflower/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.05


# from objects/obj_superflower/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		if gravity == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.1:
				hspeed = 0.0


# from objects/obj_superflower/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup == 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_hurtsolid2, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null):
		other.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	if G.powerup != Scr.scr_sprite_get_constant(self, sprite_index):
		if G.powerup == 0.0:
			if GM.instance_exists(A.obj_mario):
				for inst in GM.with_list(A.obj_levelmanager):
					inst.mchange = 1.0
				for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
					inst.c_powerup = 1.0
					inst.sprite_powerup = sprite_index
				GM.audio_stop_sound(A.snd_SMB_powerup_superflower)
				GM.audio_play_sound(A.snd_SMB_powerup_superflower, 0.0, false)
		elif GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.mchange = 1.0
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
				inst.c_powerup = 1.0
				inst.sprite_powerup = sprite_index
			GM.audio_stop_sound(A.snd_SMB_powerup_superflower)
			GM.audio_play_sound(A.snd_SMB_powerup_superflower, 0.0, false)
	else:
		GM.audio_stop_sound(Scr.scr_snd_powerup(self))
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	instance_destroy()
