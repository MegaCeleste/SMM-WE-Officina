# from scripts/__view_get/__view_get.gml
# 第 3 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/__view_get/__view_get.gml
static func __view_get(me: GMObject, argument0 = null, argument1 = null) -> Variant:
	var __cam: int
	var __prop: int = int(argument0)  # 枚举 e__VW（match 区分 int 和 float）
	var __index: int = int(argument1)
	var __res: Variant = -1.0
	match __prop:
		Scr.e__VW.XView:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_x(__cam)
		Scr.e__VW.YView:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_y(__cam)
		Scr.e__VW.WView:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_width(__cam)
		Scr.e__VW.HView:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_height(__cam)
		Scr.e__VW.Angle:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_angle(__cam)
		Scr.e__VW.HBorder:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_border_x(__cam)
		Scr.e__VW.VBorder:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_border_y(__cam)
		Scr.e__VW.HSpeed:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_speed_x(__cam)
		Scr.e__VW.VSpeed:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_speed_y(__cam)
		Scr.e__VW.Object:
			__cam = GM.view_get_camera(__index)
			__res = GM.camera_get_view_target(__cam)
		Scr.e__VW.Visible:
			__res = GM.view_get_visible(__index)
		Scr.e__VW.XPort:
			__res = GM.view_get_xport(__index)
		Scr.e__VW.YPort:
			__res = GM.view_get_yport(__index)
		Scr.e__VW.WPort:
			__res = GM.view_get_wport(__index)
		Scr.e__VW.HPort:
			__res = GM.view_get_hport(__index)
		Scr.e__VW.Camera:
			__res = GM.view_get_camera(__index)
		Scr.e__VW.SurfaceID:
			__res = GM.call(&"view_get_surface_id", __index)  # NEED-GM: view_get_surface_id
		_:
			pass
	return __res
