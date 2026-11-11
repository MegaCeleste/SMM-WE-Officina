# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioswim_idle/scr_marioswim_idle.gml
static func scr_marioswim_idle(me: GMObject) -> Variant:
	match G.jugador:
		0.0:
			return A.spr_SMB3_mario_frog_swim_idle
		1.0:
			return A.spr_SMB3_mario_frog_swim_idle
		2.0:
			return A.spr_SMB3_toad_frog_swim_idle
		3.0:
			return A.spr_SMB3_toadette_frog_swim_idle
	return null  # GML 走到结尾返回 undefined
