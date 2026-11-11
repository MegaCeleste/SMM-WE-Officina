# from scripts/string_add_zeros/string_add_zeros.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/string_add_zeros/string_add_zeros.gml
static func string_add_zeros(me: GMObject, argument0 = null, argument1 = null) -> Variant:
	return GM.string_replace_all(GM.string_format(argument0, argument1, 0.0), " ", "0")
