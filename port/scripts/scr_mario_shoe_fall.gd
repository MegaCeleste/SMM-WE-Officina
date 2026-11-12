# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_shoe_fall/scr_mario_shoe_fall.gml
static func scr_mario_shoe_fall(me: GMObject):
	match G.jugador:
		0.0:
			return A.spr_SMB3_mario_raccoon_shoe_fall
		1.0:
			return A.spr_SMB3_luigi_raccoon_shoe_fall
		2.0:
			return A.spr_SMB3_toad_raccoon_shoe_fall
		3.0:
			return A.spr_SMB3_toadette_raccoon_shoe_fall
