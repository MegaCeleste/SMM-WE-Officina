# 第 4 批移植，已核对。
extends "res://objects/obj_yoshi_runaway.gd"


# from objects/obj_yoshi_runaway_red/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if ready_v > 0.5 and o.state == 2.0 and o.holding == 0.0 and o.visible == true and o.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		for inst in GM.with_list(A.obj_mario):
			inst.x = self.x
			inst.y = (self.y - 18.0)
			inst.direct = self.direct
			inst.holding = 3.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_yoshi_red)):
			inst.mouthholder = self.mouthholder
			inst.mouthsprite = self.mouthsprite
		GM.audio_play_sound(A.snd_yoshi, 0.0, false)
		instance_destroy()


# from objects/obj_yoshi_runaway_red/Other_11.gml
func _user_1() -> void:
	if mouthholder != null:
		sprite_index = A.spr_yoshi_fm_red
	else:
		sprite_index = A.spr_yoshi_runaway_red
