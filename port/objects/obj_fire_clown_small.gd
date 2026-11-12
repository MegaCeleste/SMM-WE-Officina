# 第 7 批移植，已核对。
extends "res://objects/obj_fireball.gd"


# from objects/obj_fire_clown_small/Step_0.gml
func _step() -> void:
	prevhspeed = hspeed
	super._step()
	if hspeed != prevhspeed:
		_user_0()
	gravity = 0.0
	if Scr.outside_view(self) > 0.5:
		instance_destroy()
