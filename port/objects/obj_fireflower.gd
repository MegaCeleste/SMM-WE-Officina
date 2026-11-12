# from objects/obj_fireflower（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var spr_SMB2_fireflower = null  # ORIG-BUG: 原版没有 spr_SMB2_fireflower 这个资源，Create_0 case 4 读它（GMS 里会报“变量未设置”）；照搬，apariencia==4 时赋 null 给 sprite_index 会运行时报错


# from objects/obj_fireflower/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_fireflower
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_fireflower
			image_speed = 0.0
		2.0:
			sprite_index = A.spr_fireflower
			image_speed = 0.15
		3.0:
			sprite_index = A.spr_NSMBU_fireflower
			image_speed = 0.25
		4.0:
			sprite_index = spr_SMB2_fireflower
			image_speed = 0.0


# from objects/obj_fireflower/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		if gravity == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.2)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.2:
				hspeed = 0.0
