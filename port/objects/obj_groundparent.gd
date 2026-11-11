extends "res://objects/obj_solid.gd"

var pos_cal: float = 0.0


# from objects/obj_groundparent/Alarm_2.gml
func _alarm_2() -> void:
	pos_cal = 0.0


# from objects/obj_groundparent/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if pos_cal == 1.0:
		# with (other.id) 内部调用了 event_user：GM.other 设为外层 self（§3.3 第 17 条）
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index == A.obj_slopes:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res and inst.object_index != A.obj_door_res and inst.object_index != A.obj_door_exit_res and inst.object_index != A.obj_door_switch_res and inst.object_index != A.obj_door_switch_exit_res and inst.object_index != A.obj_door_lock_res and inst.object_index != A.obj_door_lock_exit_res:
				inst.instance_destroy()
		GM.other = _o
