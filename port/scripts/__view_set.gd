extends RefCounted


# from scripts/__view_set/__view_set.gml
static func __view_set(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	var __prop = argument0
	var __index = argument1
	var __val = argument2
	Scr.__view_set_internal(me, __prop, __index, __val)
	var __res = Scr.__view_get(me, __prop, __index)
	return __res
