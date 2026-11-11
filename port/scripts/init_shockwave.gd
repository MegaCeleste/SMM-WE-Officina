# from scripts/init_shockwave/init_shockwave.gml
# 第 2 批移植，已核对。
# 写的都是调用者（obj_persistent）的实例变量，那边已声明。
extends RefCounted


# from scripts/init_shockwave/init_shockwave.gml
static func init_shockwave(me: GMObject) -> void:
	GM.draw_set_color(GM.c_white)
	me.uni_time = GM.shader_get_uniform(A.shd_shockwave, "time")
	me.var_time_var = 0.0
	me.uni_mouse_pos = GM.shader_get_uniform(A.shd_shockwave, "mouse_pos")
	me.var_mouse_pos_x = GM.mouse_x
	me.var_mouse_pos_y = GM.mouse_y
	me.uni_resolution = GM.shader_get_uniform(A.shd_shockwave, "resolution")
	me.var_resolution_x = GM.camera_get_view_width(GM.view_get_camera(0))
	me.var_resolution_y = GM.camera_get_view_height(GM.view_get_camera(0))
	me.uni_shock_amplitude = GM.shader_get_uniform(A.shd_shockwave, "shock_amplitude")
	me.var_shock_amplitude = 5.0
	me.uni_shock_refraction = GM.shader_get_uniform(A.shd_shockwave, "shock_refraction")
	me.var_shock_refraction = 0.4
	me.uni_shock_width = GM.shader_get_uniform(A.shd_shockwave, "shock_width")
	me.var_shock_width = 0.05
	me.shock_enabled = 0.0
