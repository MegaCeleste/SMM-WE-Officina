# from scripts/__background_get_internal/__background_get_internal.gml
# 第 2 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/__background_get_internal/__background_get_internal.gml
static func __background_get_internal(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	var __prop: int = int(argument0)  # 枚举 e__BG（match 区分 int 和 float）
	var __bind = argument1
	var __backinfo = argument2
	if (__backinfo[0] == -1.0) or (GM.layer_sprite_exists(__backinfo[1], __backinfo[0]) == false):
		# this can happen when we change between backgrounds and foregrounds (because layers and elements get destroyed)
		# Try getting the background info again from the bind index
		__backinfo = Scr.__background_get_element(me, __bind)
		if __backinfo[0] == -1.0:
			return -1.0  # erm
	var __res = -1.0
	var __backid = __backinfo[0]
	var __layerid = __backinfo[1]
	var __isfore = __backinfo[2]
	match __prop:
		Scr.e__BG.Visible:
			__res = GM.layer_get_visible(__layerid)
		Scr.e__BG.Foreground:
			__res = __isfore
		Scr.e__BG.Index:
			__res = GM.layer_background_get_sprite(__backid)
		Scr.e__BG.X:
			__res = GM.layer_get_x(__layerid)
		Scr.e__BG.Y:
			__res = GM.layer_get_y(__layerid)
		Scr.e__BG.Width:
			__res = GM.sprite_get_width(GM.layer_background_get_index(__backid))
		Scr.e__BG.Height:
			__res = GM.sprite_get_height(GM.layer_background_get_index(__backid))
		Scr.e__BG.HTiled:
			__res = GM.layer_background_get_htiled(__backid)
		Scr.e__BG.VTiled:
			__res = GM.layer_background_get_vtiled(__backid)
		Scr.e__BG.XScale:
			__res = GM.layer_background_get_xscale(__backid)
		Scr.e__BG.YScale:
			__res = GM.layer_background_get_yscale(__backid)
		Scr.e__BG.HSpeed:
			__res = GM.layer_get_hspeed(__layerid)
		Scr.e__BG.VSpeed:
			__res = GM.layer_get_vspeed(__layerid)
		Scr.e__BG.Blend:
			__res = GM.layer_background_get_blend(__backid)
		Scr.e__BG.Alpha:
			__res = GM.layer_background_get_alpha(__backid)
		_:
			pass
	return __res
