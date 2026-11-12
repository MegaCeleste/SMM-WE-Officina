# 第 7 批移植，已核对。
extends "res://objects/obj_solidtop.gd"


# from objects/obj_hurtsolid2/Step_0.gml
func _step() -> void:
	var player
	# PORT: with (player) event_user(0) 里 other = 本实例，按第 17 条在整个方法里维护 GM.other（方法内没有 return）
	var _o: GMObject = GM.other
	GM.other = self
	if G.yoshi == 0.0:
		if GM.instance_exists(A.obj_helmet):
			player = collision_rectangle((bbox_left - 1.0), (bbox_top - 1.0), (bbox_right + 1.0), bbox_bottom, A.obj_mario, false, false)
			if player != null:
				for inst in GM.with_list(player):
					inst.event_user(0)
		else:
			player = collision_rectangle((bbox_left - 1.0), (bbox_top - 1.0), (bbox_right + 1.0), (bbox_bottom + 12.0), A.obj_mario, false, false)
			if player != null:
				for inst in GM.with_list(player):
					inst.event_user(0)
	elif GM.instance_exists(A.obj_helmet):
		player = collision_rectangle((bbox_left - 1.0), (bbox_top + 2.0), (bbox_right + 1.0), bbox_bottom, A.obj_mario, false, false)
		if player != null:
			for inst in GM.with_list(player):
				inst.event_user(0)
	else:
		player = collision_rectangle((bbox_left - 1.0), bbox_top, (bbox_right + 1.0), (bbox_bottom + 12.0), A.obj_mario, false, false)
		if player != null and (player.y + 16.0) > (bbox_top - 11.0):
			for inst in GM.with_list(player):
				inst.event_user(0)
	GM.other = _o
