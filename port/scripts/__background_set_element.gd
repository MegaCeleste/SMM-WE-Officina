# from scripts/__background_set_element/__background_set_element.gml
# 第 2 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/__background_set_element/__background_set_element.gml
static func __background_set_element(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null, argument7 = null, argument8 = null, argument9 = null, argument10 = null, argument11 = null, argument12 = null, argument13 = null, argument14 = null) -> Variant:
	var __layername  # 局部变量提升（GML 的 var 是函数作用域）
	var __slot  # 局部变量提升（GML 的 var 是函数作用域）
	var __slotchr  # 局部变量提升（GML 的 var 是函数作用域）
	# NOTE: this script will only work properly if you're using the standard depth range (-16000 to 16000)
	var __bind = argument0
	var __vis = argument1
	var __fore = argument2
	var __back = argument3
	var __x = argument4
	var __y = argument5
	var __htiled = argument6
	var __vtiled = argument7
	var __xscale = argument8
	var __yscale = argument9
	var __stretch = argument10
	var __hspeed = argument11
	var __vspeed = argument12
	var __blend = argument13
	var __alpha = argument14
	# var __nearestdepth = -15000;
	# var __farthestdepth = 15999;
	var __nearestdepth = 1000000000.0
	var __farthestdepth = -1000000000.0
	var __depthinc = 100.0
	var __result: Array = []
	GM.aset(__result, 0, -1.0)
	GM.aset(__result, 1, -1.0)
	# Now look at the existing layers in the room to see if we have any foregrounds or backgrounds
	var __fgstring = "Compatibility_Foreground_"
	var __bgstring = "Compatibility_Background_"
	var __colstring = "Compatibility_Colour"
	var __fglen = GM.string_length(__fgstring)
	var __bglen = GM.string_length(__bgstring)
	var __layerlist = GM.layer_get_all()
	var __layerlistlength = GM.array_length_1d(__layerlist)
	var __collayer = -1.0
	var __slots: Array = []
	var __isforeground: Array = []
	var __i
	__i = 0.0
	while __i < 8.0:
		GM.aset(__slots, __i, -1.0)
		GM.aset(__isforeground, __i, false)
		__i += 1.0
	__i = 0.0
	while __i < __layerlistlength:
		__layername = GM.layer_get_name(__layerlist[__i])
		if GM.string_pos(__fgstring, __layername) > 0.0:
			__slotchr = GM.string_char_at(__layername, __fglen + 1.0)
			if __slotchr == "":
				__i += 1.0
				continue
			__slot = GM.real(__slotchr)
			GM.aset(__slots, __slot, __layerlist[__i])
			GM.aset(__isforeground, __slot, true)
			# Could check the contents of this layer to see if it has a single background element on it but that's probably overkill
		elif GM.string_pos(__bgstring, __layername) > 0.0:
			__slotchr = GM.string_char_at(__layername, __bglen + 1.0)
			if __slotchr == "":
				__i += 1.0
				continue
			__slot = GM.real(__slotchr)
			GM.aset(__slots, __slot, __layerlist[__i])
			GM.aset(__isforeground, __slot, false)
			# Could check the contents of this layer to see if it has a single background element on it but that's probably overkill
		elif GM.string_pos(__colstring, __layername) > 0.0:
			# Make sure colour is as deep as it can be
			__collayer = __layerlist[__i]
			GM.layer_depth(__layerlist[__i], __farthestdepth)
		else:
			var __currdepth = GM.layer_get_depth(__layerlist[__i])
			if __currdepth < __nearestdepth:
				__nearestdepth = __currdepth
			if __currdepth > __farthestdepth:
				__farthestdepth = __currdepth
		__i += 1.0
	# Reassign depths
	__farthestdepth += __depthinc + 1000.0  # add some margin for the background layers
	__nearestdepth -= __depthinc
	# __farthestdepth = max(__farthestdepth, 15999);
	# __nearestdepth = min(__nearestdepth, -15000);
	__farthestdepth = maxf(__farthestdepth, 2147483600.0)
	__nearestdepth = minf(__nearestdepth, -2147482000.0)
	__i = 0.0
	while __i < 8.0:
		if __slots[__i] != -1.0:
			var __depth = 0.0
			if __isforeground[__i] == true:
				__depth = __nearestdepth - (__i * __depthinc)
			else:
				__depth = (__farthestdepth - __depthinc) - (__slot * __depthinc)  # ORIG-BUG: 这里应是 __i（GMS 生成的脚本原样如此）
			GM.layer_depth(__slots[__i], __depth)
		__i += 1.0
	if __collayer != -1.0:
		GM.layer_depth(__collayer, __farthestdepth)
	# Construct our layer name and depth
	pass  # GML: var __layername
	var __layerdepth
	if __bind == -1.0:
		# This is the background colour layer
		__layername = __colstring
		__layerdepth = __farthestdepth
	else:
		if __fore == true:
			__layername = __fgstring + GM.string(__bind)
			__layerdepth = __nearestdepth - (__bind * __depthinc)
		else:
			__layername = __bgstring + GM.string(__bind)
			__layerdepth = (__farthestdepth - __depthinc) - (__bind * __depthinc)  # reserve 16000 for imported colour
	# If we already have a background in this slot, nuke it
	var __layerid
	if __bind == -1.0:
		__layerid = __collayer
	else:
		__layerid = __slots[__bind]
	if __layerid != -1.0:
		GM.layer_destroy(__layerid)
	__layerid = GM.layer_create(__layerdepth, __layername)
	# Set our layer properties
	GM.layer_x(__layerid, __x)
	GM.layer_y(__layerid, __y)
	GM.layer_hspeed(__layerid, __hspeed)
	GM.layer_vspeed(__layerid, __vspeed)
	# Construct our new background element
	var __backel = GM.layer_background_create(__layerid, __back)
	GM.layer_background_visible(__backel, __vis)
	GM.layer_background_htiled(__backel, __htiled)
	GM.layer_background_vtiled(__backel, __vtiled)
	GM.layer_background_xscale(__backel, __xscale)
	GM.layer_background_yscale(__backel, __yscale)
	GM.layer_background_stretch(__backel, __stretch)
	GM.layer_background_blend(__backel, __blend)
	GM.layer_background_alpha(__backel, __alpha)
	GM.aset(__result, 0, __backel)
	GM.aset(__result, 1, __layerid)
	return __result
