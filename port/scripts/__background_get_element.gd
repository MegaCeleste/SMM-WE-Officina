# from scripts/__background_get_element/__background_get_element.gml
# 第 2 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/__background_get_element/__background_get_element.gml
static func __background_get_element(me: GMObject, argument0 = null) -> Variant:
	var __slot  # 局部变量提升（GML 的 var 是函数作用域）
	var __slotchr  # 局部变量提升（GML 的 var 是函数作用域）
	var __bind = argument0
	var __result: Array = []
	GM.aset(__result, 0, -1.0)
	GM.aset(__result, 1, -1.0)
	GM.aset(__result, 2, -1.0)
	# Look at the existing layers in the room to see if we have any foregrounds or backgrounds
	var __fgstring = "Compatibility_Foreground_"
	var __bgstring = "Compatibility_Background_"
	var __fglen = GM.string_length(__fgstring)
	var __bglen = GM.string_length(__bgstring)
	var __layerlist = GM.layer_get_all()
	var __layerlistlength = GM.array_length_1d(__layerlist)
	var __i
	var __layerid = -1.0
	var __isforeground = false
	# Try and find the appropriate background in the list of layers
	__i = 0.0
	while __i < __layerlistlength:
		var __layername = GM.layer_get_name(__layerlist[__i])
		if GM.string_pos(__fgstring, __layername) > 0.0:
			__slotchr = GM.string_char_at(__layername, __fglen + 1.0)
			if __slotchr == "":
				__i += 1.0
				continue
			__slot = GM.real(__slotchr)
			if __slot == __bind:
				__layerid = __layerlist[__i]
				__isforeground = true
				break
		elif GM.string_pos(__bgstring, __layername) > 0.0:
			__slotchr = GM.string_char_at(__layername, __bglen + 1.0)
			if __slotchr == "":
				__i += 1.0
				continue
			__slot = GM.real(__slotchr)
			if __slot == __bind:
				__layerid = __layerlist[__i]
				__isforeground = false
				break
		__i += 1.0
	if __layerid != -1.0:
		# We have a winner!
		# Get id of background element on this layer
		var __els = GM.layer_get_all_elements(__layerid)
		var __elslength = GM.array_length_1d(__els)
		__i = 0.0
		while __i < __elslength:
			if GM.layer_get_element_type(__els[__i]) == GM.layerelementtype_background:
				GM.aset(__result, 0, __els[__i])
				GM.aset(__result, 1, __layerid)
				GM.aset(__result, 2, __isforeground)
			__i += 1.0
	else:
		# Need to construct a new layer with a new background
		var __newback = Scr.__background_set_element(me, __bind, false, false, -1.0, 0.0, 0.0, true, true, 1.0, 1.0, false, 0.0, 0.0, 0xFFFFFF, 1.0)
		GM.aset(__result, 0, __newback[0])
		GM.aset(__result, 1, __newback[1])
		GM.aset(__result, 2, false)
	return __result
