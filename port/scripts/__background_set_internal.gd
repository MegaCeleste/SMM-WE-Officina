# from scripts/__background_set_internal/__background_set_internal.gml
# 第 2 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/__background_set_internal/__background_set_internal.gml
static func __background_set_internal(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null) -> Variant:
	var __prop: int = int(argument0)  # 枚举 e__BG（match 区分 int 和 float）
	var __bind = argument1
	var __val = argument2
	var __backinfo = argument3
	if __backinfo[0] == -1.0:
		return -1.0  # erm
	var __backid = __backinfo[0]
	var __layerid = __backinfo[1]
	var __isfore = __backinfo[2]
	if __prop == Scr.e__BG.Foreground:
		# This requires quite a bit of extra logic (we need to modify our layer list)
		if GM.gm_round(__val) != GM.gm_round(__isfore):
			# okay, we have a mismatch
			# Get all properties, then set the background again and copy the properties
			var __visible = GM.layer_get_visible(__layerid)
			var __index = GM.layer_background_get_sprite(__backid)
			var __htiled = GM.layer_background_get_htiled(__backid)
			var __vtiled = GM.layer_background_get_vtiled(__backid)
			var __stretch = GM.layer_background_get_stretch(__backid)
			var __blend = GM.layer_background_get_blend(__backid)
			var __alpha = GM.layer_background_get_alpha(__backid)
			var __xscale = GM.layer_background_get_xscale(__backid)
			var __yscale = GM.layer_background_get_yscale(__backid)
			var __x = GM.layer_get_x(__layerid)
			var __y = GM.layer_get_y(__layerid)
			var __hspeed = GM.layer_get_hspeed(__layerid)
			var __vspeed = GM.layer_get_vspeed(__layerid)
			Scr.__background_set_element(me, __bind, __visible, __val, __index, __x, __y, __htiled, __vtiled, __xscale, __yscale, __stretch, __hspeed, __vspeed, __blend, __alpha)
	else:
		match __prop:
			Scr.e__BG.Visible:
				GM.layer_set_visible(__layerid, __val)
				GM.layer_background_visible(__backid, __val)
			Scr.e__BG.Index:
				GM.layer_background_change(__backid, __val)
				# RK :: if we are setting a sprite then set the background colour to white so it is blending correctly
				if GM.sprite_exists(__val):
					GM.layer_background_blend(__backid, GM.c_white)
					GM.layer_background_alpha(__backid, 1.0)
				# end if
			Scr.e__BG.X:
				GM.layer_x(__layerid, __val)
			Scr.e__BG.Y:
				GM.layer_y(__layerid, __val)
			Scr.e__BG.HTiled:
				GM.layer_background_htiled(__backid, __val)
			Scr.e__BG.VTiled:
				GM.layer_background_vtiled(__backid, __val)
			Scr.e__BG.XScale:
				GM.layer_background_xscale(__backid, __val)
			Scr.e__BG.YScale:
				GM.layer_background_yscale(__backid, __val)
			Scr.e__BG.HSpeed:
				GM.layer_hspeed(__layerid, __val)
			Scr.e__BG.VSpeed:
				GM.layer_vspeed(__layerid, __val)
			Scr.e__BG.Blend:
				GM.layer_background_blend(__backid, __val)
			Scr.e__BG.Alpha:
				GM.layer_background_alpha(__backid, __val)
			_:
				pass
	return -1.0
