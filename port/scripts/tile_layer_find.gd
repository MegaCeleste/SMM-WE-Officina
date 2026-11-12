# from scripts/tile_layer_find/tile_layer_find.gml
# 第 6e 批移植。兼容层的图层没有图块（tile）元素（layer_get_element_type 不会返回 layerelementtype_tile），
# 所以图块分支走不到；兼容层也没有 layer_tile_get_*，该分支写成 PORT 占位，永远返回 -1。
extends RefCounted


# from scripts/tile_layer_find/tile_layer_find.gml
static func tile_layer_find(me: GMObject, argument0: float, argument1: float, argument2: float) -> Variant:
	var __depth: float = argument0
	var __x: float = argument1
	var __y: float = argument2
	var __layers: Array = GM.layer_get_all()
	var __numlayers: int = __layers.size()
	for __i in range(__numlayers):
		if GM.layer_get_depth(__layers[__i]) != __depth:
			continue
		var __els: Array = GM.layer_get_all_elements(__layers[__i])
		var __numels: int = __els.size()
		for __j in range(__numels):
			var __eltype: int = GM.layer_get_element_type(__els[__j])
			if __eltype == GM.layerelementtype_tile:
				# PORT: 兼容层没有 layer_tile_get_x/y/xscale/yscale/region，也不会产生图块元素；原版此处按图块矩形判断并返回元素
				continue
	return -1.0
