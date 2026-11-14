extends RefCounted


# from scripts/__view_set_internal/__view_set_internal.gml
static func __view_set_internal(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	var __cam  # 局部变量提升（GML 的 var 是函数作用域）
	var __prop: int = int(argument0)
	var __index = argument1
	var __val = argument2
	match __prop:
		Scr.e__VW.XView:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_pos(__cam, __val, GM.camera_get_view_y(__cam))
		Scr.e__VW.YView:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_pos(__cam, GM.camera_get_view_x(__cam), __val)
		Scr.e__VW.WView:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_size(__cam, __val, GM.camera_get_view_height(__cam))
		Scr.e__VW.HView:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_size(__cam, GM.camera_get_view_width(__cam), __val)
		Scr.e__VW.Angle:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_angle(__cam, __val)
		Scr.e__VW.HBorder:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_border(__cam, __val, GM.camera_get_view_border_y(__cam))
		Scr.e__VW.VBorder:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_border(__cam, GM.camera_get_view_border_x(__cam), __val)
		Scr.e__VW.HSpeed:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_speed(__cam, __val, GM.camera_get_view_speed_y(__cam))
		Scr.e__VW.VSpeed:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_speed(__cam, GM.camera_get_view_speed_x(__cam), __val)
		Scr.e__VW.Object:
			__cam = GM.view_get_camera(__index)
			GM.camera_set_view_target(__cam, __val)
		Scr.e__VW.Visible:
			GM.view_set_visible(__index, __val)
		Scr.e__VW.XPort:
			GM.view_set_xport(__index, __val)
		Scr.e__VW.YPort:
			GM.view_set_yport(__index, __val)
		Scr.e__VW.WPort:
			GM.view_set_wport(__index, __val)
		Scr.e__VW.HPort:
			GM.view_set_hport(__index, __val)
		Scr.e__VW.Camera:
			GM.view_set_camera(__index, __val)
		Scr.e__VW.SurfaceID:
			GM.view_set_surface_id(__index, __val)
		_:
			pass
	return 0.0
