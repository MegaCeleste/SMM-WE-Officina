# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_lose_condition/scr_lose_condition.gml
static func scr_lose_condition(me: GMObject) -> Variant:
	if G.condiciones == 1.0 and G.condiciones_count == 0.0:
		if G.condiciones_clear == 1.0:
			G.condiciones_clear = 0.0
			for inst in GM.with_list(A.obj_alert_condicion):
				inst.instance_destroy()
			for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 98.0), A.obj_alert_condicion)):
				inst.set("lose", 1.0)
	return null
