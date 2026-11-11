# from scripts/__background_get/__background_get.gml
# 第 2 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/__background_get/__background_get.gml
static func __background_get(me: GMObject, argument0 = null, argument1 = null) -> Variant:
	var __prop: int = int(argument0)  # 枚举 e__BG（match 区分 int 和 float）
	var __bind = argument1
	var __backinfo = Scr.__background_get_element(me, __bind)
	return Scr.__background_get_internal(me, __prop, __bind, __backinfo)
