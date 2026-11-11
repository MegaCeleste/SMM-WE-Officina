# from scripts/scr_insideview/scr_insideview.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_insideview/scr_insideview.gml
static func scr_insideview(me: GMObject) -> Variant:
	if GM.mouse_y > GM.camera_get_view_y(GM.view_get_camera(0)) and GM.mouse_y < ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) - 1.0) and GM.mouse_x > GM.camera_get_view_x(GM.view_get_camera(0)) and GM.mouse_x < ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 1.0):
		return 1.0
	else:
		return 0.0
	return null
