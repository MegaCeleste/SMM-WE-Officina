extends "res://objects/obj_lava_lift.gd"

var parent = null  # 原版 Create 里是 0，被 obj_lava_lift 的 Create 设成实例


# from objects/obj_lava_lift_part/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_lava_lift
			image_speed = 0.0
			image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_lava_lift
			image_speed = 0.15
		2.0:
			sprite_index = A.spr_lava_lift
			image_speed = 0.15
		3.0:
			sprite_index = A.spr_NSMBU_lava_lift_overworld
			image_speed = 0.0
	ready_v = 0.0
	parent = 0.0


# from objects/obj_lava_lift_part/Step_0.gml
func _step() -> void:
	var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 同 obj_lava_lift/Step_0
	if collision_rectangle(bbox_left, (bbox_top - 5.0), bbox_right, (bbox_top + 4.0), A.obj_mario, false, false) != null and mario.bbox_bottom < (yprevious + 5.0) and mario.state < 2.0 and ready_v == 0.0:
		if not GM.veq(parent, A.obj_lighting) and GM.instance_exists(parent):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(parent):
				inst.event_user(1)
			GM.other = _o
	if vspeed > 2.5:
		vspeed = 2.5
	super._step()
