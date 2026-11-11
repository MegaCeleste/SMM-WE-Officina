# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_canpull/scr_canpull.gml
static func scr_canpull(me: GMObject) -> Variant:
	if GM.instance_exists(A.obj_mario) and ((not GM.instance_exists(A.obj_puller)) and ((G.powerup == -80.0) and (GM.keyboard_check(G.lanzar_agarrar) and (GM.keyboard_check(G.abajo) and ((G.yoshi == 0.0) and ((GM.instance_find(A.obj_mario, 0).state < 2.0) and ((GM.instance_find(A.obj_mario, 0).holding == 0.0) and ((GM.instance_find(A.obj_mario, 0).iamkicking == 0.0) and (GM.instance_find(A.obj_mario, 0).disablecontrols == 0.0))))))))):
		return 1.0
	else:
		return 0.0
	return null  # GML 走到结尾返回 undefined
