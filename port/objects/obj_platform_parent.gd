extends "res://objects/obj_solidtop.gd"


# from objects/obj_platform_parent/Step_2.gml
func _step_end() -> void:
	var spd2: float
	var check
	var check_solid
	var check_phy
	var check_platform
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 原版每处都写 obj_mario.xxx（读第一个实例）；此处缓存成局部变量，读法等价
		if vspeed < 1.0:
			spd2 = 1.0
		else:
			spd2 = vspeed
		check = collision_rectangle(mario.bbox_left, (bbox_top - 5.0), mario.bbox_right, (bbox_top + spd2), A.obj_solidtop, false, true)
		check_solid = collision_rectangle(mario.bbox_left, (bbox_top - 5.0), mario.bbox_right, (bbox_top + spd2), A.obj_solid, false, false)
		check_phy = collision_rectangle(mario.bbox_left, (mario.bbox_top - 5.0), mario.bbox_right, (bbox_top + spd2), A.obj_physicssolid, false, false)
		check_platform = collision_rectangle(mario.bbox_left, (mario.bbox_top - 5.0), mario.bbox_right, (bbox_top + spd2), A.obj_platform_parent, false, false)
		if check_platform != null and check_platform != self and check_platform.vspeed < 0.0:
			return
		if collision_rectangle(bbox_left, (bbox_top - 5.0), bbox_right, ((bbox_top + 3.0) + vspeed), A.obj_mario, false, false) != null and mario.y < (bbox_top - 27.0) and mario.state < 2.0:
			if vspeed > 0.0 and check != null and check != self:
				for inst in GM.with_list(A.obj_mario):
					inst.y = (check.bbox_top - 32.0)
				return
			if vspeed > 0.0 and check_solid != null:
				for inst in GM.with_list(A.obj_mario):
					inst.y = (check_solid.bbox_top - 32.0)
				return
			if vspeed > 0.0 and check_phy != null:
				for inst in GM.with_list(A.obj_mario):
					inst.y = (check_phy.bbox_top - 32.0)
				return
			if collision_rectangle(mario.bbox_left, ((mario.bbox_top - 1.0) - vspeed), mario.bbox_right, mario.bbox_top, A.obj_solid, false, false) != null or collision_rectangle(mario.bbox_left, ((mario.bbox_top - 1.0) - vspeed), mario.bbox_right, mario.bbox_top, A.obj_physicssolid, false, false) != null or collision_rectangle(mario.bbox_left, ((mario.bbox_top - 1.0) - vspeed), mario.bbox_right, mario.bbox_top, A.obj_bullebill_base, false, false) != null or (collision_rectangle(mario.bbox_left, (mario.bbox_top - 2.0), mario.bbox_right, (mario.bbox_top + 1.0), A.obj_onewaygate_bottom, false, false) != null and vspeed < 0.0):
				for inst in GM.with_list(A.obj_mario):
					inst.vspeed = 0.0
				return
			for inst in GM.with_list(A.obj_mario):
				inst.y = ceilf((bbox_top - 31.0))
			if (hspeed > 0.0 and (collision_rectangle(((mario.bbox_right + 1.0) + hspeed), mario.bbox_top, ((mario.bbox_right + 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle(((mario.bbox_left - 1.0) + hspeed), mario.bbox_top, ((mario.bbox_left - 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle(((mario.bbox_right + 1.0) + hspeed), mario.bbox_top, ((mario.bbox_right + 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle(((mario.bbox_left - 1.0) + hspeed), mario.bbox_top, ((mario.bbox_left - 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle(((mario.bbox_right + 1.0) + hspeed), mario.bbox_top, ((mario.bbox_right + 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle(((mario.bbox_left - 1.0) + hspeed), mario.bbox_top, ((mario.bbox_left - 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle(((mario.bbox_right + 1.0) + hspeed), mario.bbox_top, ((mario.bbox_right + 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle(((mario.bbox_left - 1.0) + hspeed), mario.bbox_top, ((mario.bbox_left - 1.0) + hspeed), (mario.bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)):
				for inst in GM.with_list(A.obj_mario):
					inst.x += hspeed
