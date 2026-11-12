# from scripts/draw_sprite_tiled_area_ext/draw_sprite_tiled_area_ext.gml
# 第 6b 批移植（obj_skewertrunk 用），已核对。GMLscripts.com 的公共脚本。
extends RefCounted


# from scripts/draw_sprite_tiled_area_ext/draw_sprite_tiled_area_ext.gml
# draw_sprite_tiled_area_ext(sprite,subimg,x,y,x1,y1,x2,y2,color,alpha)
static func draw_sprite_tiled_area_ext(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null, argument7 = null, argument8 = null, argument9 = null) -> Variant:
	var sprite: int = int(argument0)
	var subimg: float = float(argument1)
	var xx: float = float(argument2)
	var yy: float = float(argument3)
	var x1: float = float(argument4)
	var y1: float = float(argument5)
	var x2: float = float(argument6)
	var y2: float = float(argument7)

	var sw: float = GM.sprite_get_width(sprite)
	var sh: float = GM.sprite_get_height(sprite)
	var i: float
	var j: float
	var jj: float
	var left: float
	var top: float
	var width: float
	var height: float
	var X: float
	var Y: float

	i = x1 - (GM.gm_mod(x1, sw) - GM.gm_mod(xx, sw)) - sw * (1.0 if GM.gm_mod(x1, sw) < GM.gm_mod(xx, sw) else 0.0)
	j = y1 - (GM.gm_mod(y1, sh) - GM.gm_mod(yy, sh)) - sh * (1.0 if GM.gm_mod(y1, sh) < GM.gm_mod(yy, sh) else 0.0)
	jj = j

	while i <= x2:
		while j <= y2:
			if i <= x1:
				left = x1 - i
			else:
				left = 0.0
			X = i + left

			if j <= y1:
				top = y1 - j
			else:
				top = 0.0
			Y = j + top

			if x2 <= i + sw:
				width = ((sw) - (i + sw - x2) + 1.0) - left
			else:
				width = sw - left

			if y2 <= j + sh:
				height = ((sh) - (j + sh - y2) + 1.0) - top
			else:
				height = sh - top

			GM.draw_sprite_part_ext(sprite, subimg, left, top, width, height, X, Y, 1.0, 1.0, int(argument8), float(argument9))
			j += sh
		j = jj
		i += sw
	return 0.0
