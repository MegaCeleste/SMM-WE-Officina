# from scripts/scr_canhold/scr_canhold.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_canhold/scr_canhold.gml
static func scr_canhold(me: GMObject) -> Variant:
	var mario = GM.instance_find(A.obj_mario, 0)  # obj_mario.xxx 读第一个实例（U7）；下面都在 instance_exists 之后才访问
	match G.apariencia:
		0.0:
			return 0.0
		2.0:
			if GM.instance_exists(A.obj_mario) and (GM.keyboard_check(G.lanzar_agarrar) or G.key_br == 1.0) and mario.holding == 0.0 and mario.state < 3.0 and mario.disablecontrols == 0.0:
				return 1.0
			else:
				return 0.0
		4.0:
			return 0.0
		_:
			if GM.instance_exists(A.obj_mario) and (GM.keyboard_check(G.lanzar_agarrar) or G.key_br == 1.0) and mario.holding == 0.0 and mario.isduck == 0.0 and mario.walljump != 1.0 and mario.state < 3.0 and mario.disablecontrols == 0.0:
				return 1.0
			else:
				return 0.0
	return null  # GML 走到结尾返回 undefined
