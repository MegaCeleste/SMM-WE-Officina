# from scripts/background_create_from_surface/background_create_from_surface.gml
# 第 2 批移植，已核对。GMS 导入旧工程时自动生成的兼容脚本，照原样翻译。
extends RefCounted


# from scripts/background_create_from_surface/background_create_from_surface.gml
static func background_create_from_surface(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null) -> Variant:
	return GM.sprite_create_from_surface(argument0, argument1, argument2, argument3, argument4, argument5, argument6, 0.0, 0.0)
