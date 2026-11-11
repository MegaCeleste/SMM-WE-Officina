# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioswim3/scr_marioswim3.gml
static func scr_marioswim3(me: GMObject) -> Variant:
	match G.jugador:
		0.0:
			return A.spr_SMB3_mario_frog_swim_down
		1.0:
			return A.spr_SMB3_mario_frog_swim_down
		2.0:
			return A.spr_SMB3_toad_frog_swim_down
		3.0:
			return A.spr_SMB3_toadette_frog_swim_down
	return null  # GML 走到结尾返回 undefined
