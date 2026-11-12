# from objects/obj_galoomba_hold2（第 5 批移植，已核对）
extends "res://objects/obj_galoomba_hold.gd"


# from objects/obj_galoomba_hold2/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(A.obj_player_warp):
		shake = 0.0
		alarm[2] = 540.0
		alarm[1] = 600.0
	else:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_galoomba2)):
			inst.hspeed = (0.5 * GM.gm_sign(self.direct))
			inst.key = self.key
			if self.gravity == 0.0:
				inst.vspeed = (-(1.0 + inst.swimming))
		show_key = 0.0
		instance_destroy()
