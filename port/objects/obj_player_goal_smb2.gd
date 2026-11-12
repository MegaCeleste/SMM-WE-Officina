# 第 4 批移植，已核对。
extends "res://objects/obj_player_goal_smb3.gd"

var walk: float = 0.0


# from objects/obj_player_goal_smb2/Create_0.gml
func _create() -> void:
	# ORIG-BUG: 原版 Create 没有 event_inherited，父类 obj_player_goal_smb3 的 Create 不会执行
	# DESACTIVARCONTROL
	walk = 0.0


# from objects/obj_player_goal_smb2/Step_0.gml
func _step() -> void:
	super._step()
	if (G.bg_level == "underwater") or (GM.instance_exists(A.obj_lava_water) and ((y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0)) and ((G.bg_level == "forest") and (G.modo_noche == 0.0)))):
		swim = 1.0
	anim += 0.2
	if gravity == 0.0:
		if walk == 1.0:
			if swimming == 1.0:
				hspeed += 0.1
				if hspeed > 0.6:
					hspeed = 0.6
			else:
				hspeed += 0.08
				if hspeed > 1.6:
					hspeed = 1.6
		else:
			hspeed = 0.0
	if ready_v == 1.0:
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
	if GM.instance_exists(A.obj_hawmask):
		if (x > (GM.instance_find(A.obj_hawmask, 0).x - 16.0)) and ((x < GM.instance_find(A.obj_hawmask, 0).x) and (gravity == 0.0)):
			vspeed = -3.25
			GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
			for inst in GM.with_list(A.obj_hawmask):
				inst.image_speed = -0.15
				inst.ready_v = 1.0
