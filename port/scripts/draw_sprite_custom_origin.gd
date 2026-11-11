# from scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml
static func draw_sprite_custom_origin(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null, argument7 = null, argument8 = null, argument9 = null, argument10 = null) -> void:
	# If not necessary to build the matrix, draw normally
	if argument8 == 0.0 and argument6 == 1.0 and argument7 == 1.0:
		GM.draw_sprite_ext(int(argument0), float(argument1), float(argument2), float(argument3), float(argument6), float(argument7), float(argument8), int(argument9), float(argument10))
	# Otherwise, draw from the given axis
	else:
		# NEED-GM: matrix_set / matrix_world / matrix_build / matrix_build_identity
		# UNSURE: 兼容层没有矩阵函数。原版先 matrix_set(matrix_build(x - xoffset + axis_x, y - yoffset + axis_y, 0, 0, 0, rot * xscale, xscale, yscale, 1))，
		# 再把 sprite 画在 (xoffset - axis_x, yoffset - axis_y)（xoffset/yoffset 是调用者自己 sprite_index 的，不是参数 sprite 的）。
		# 这里用等价的 draw_sprite_ext 代替：世界位置 = pivot + R * S * (xoffset - axis_x, yoffset - axis_y)。旋转方向假定与 draw_sprite_ext 的 rot 一致。
		var xo: float = GM.sprite_get_xoffset(me.sprite_index)
		var yo: float = GM.sprite_get_yoffset(me.sprite_index)
		var pivot: Vector2 = Vector2(float(argument2) - xo + float(argument4), float(argument3) - yo + float(argument5))
		var rot: float = float(argument8) * float(argument6)
		var sxy: Vector2 = Vector2(float(argument6), float(argument7))
		var local: Vector2 = Vector2(xo - float(argument4), yo - float(argument5))
		var p: Vector2 = pivot + (local * sxy).rotated(-deg_to_rad(rot))
		GM.draw_sprite_ext(int(argument0), float(argument1), p.x, p.y, sxy.x, sxy.y, rot, int(argument9), float(argument10))
