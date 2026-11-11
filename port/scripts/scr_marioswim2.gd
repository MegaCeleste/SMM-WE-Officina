# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioswim2/scr_marioswim2.gml
static func scr_marioswim2(me: GMObject) -> Variant:
	match G.jugador:
		0.0:
			return A.spr_SMB3_mario_frog_swim_up
		1.0:
			return A.spr_SMB3_mario_frog_swim_up
		2.0:
			return A.spr_SMB3_toad_frog_swim_up
		3.0:
			return A.spr_SMB3_toadette_frog_swim_up
	return null  # GML 走到结尾返回 undefined
