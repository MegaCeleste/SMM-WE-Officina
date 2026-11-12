# from scripts/init_shake/init_shake.gml
# 第 5 批移植，已核对。
extends RefCounted


# from scripts/init_shake/init_shake.gml
# 原版用 argument[0]，全工程调用都只传 1 个参数
static func init_shake(me: GMObject, argument0 = null) -> void:
	if GM.instance_exists(A.obj_levelmanager):
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		if lm.shake_time == 0.0:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.shake_long = argument0
			for inst in GM.with_list(A.obj_levelmanager):
				inst.alarm[11] = 1.0
