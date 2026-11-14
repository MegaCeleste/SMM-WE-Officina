extends GMObject


# from objects/obj_arrow_lock/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and place_meeting(x, y, A.obj_parent_resource) and (not (place_meeting(x, y, self) and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).move == 1.0)):
		visible = true
	else:
		visible = false
	if GM.instance_exists(A.obj_ground2):
		x = GM.instance_find(A.obj_ground2, 0).x
		y = (GM.instance_find(A.obj_ground2, 0).y - 48.0)


# from objects/obj_arrow_lock/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	if GM.instance_exists(A.obj_ground2) and GM.instance_find(A.obj_ground2, 0).pos_cal == 1.0:
		var _with_target2 = other
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			if inst.object_index == A.obj_ground:
				inst.event_user(2)
				GM.instance_create(inst.x, inst.y, A.obj_tile_trigger)
			elif inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res and inst.object_index != A.obj_door_res and inst.object_index != A.obj_door_exit_res and inst.object_index != A.obj_door_switch_res and inst.object_index != A.obj_door_switch_exit_res and inst.object_index != A.obj_door_lock_res and inst.object_index != A.obj_door_lock_exit_res:
				inst.instance_destroy()
		GM.other = _other1
