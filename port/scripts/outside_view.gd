# from scripts/outside_view/outside_view.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/outside_view/outside_view.gml
static func outside_view(me: GMObject) -> float:
	# gml_Script_outside_view
	if me.x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or me.x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or me.y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 32.0) or me.y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		return 1.0
	else:
		return 0.0
