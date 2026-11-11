# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariojumphold/scr_mariojumphold.gml
static func scr_mariojumphold(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		match G.jugador:
			0.0:
				return A.spr_SMB2_mario_big_jumphold
			1.0:
				return A.spr_SMB2_luigi_big_jumphold
			2.0:
				return A.spr_SMB2_toad_big_jumphold
			3.0:
				return A.spr_SMB2_toadette_big_jumphold
	elif G.apariencia == 1.0:
		match G.jugador:
			0.0:
				return A.spr_SMB3_mario_raccoon_hold_jump
			1.0:
				return A.spr_SMB3_luigi_raccoon_hold_jump
			2.0:
				return A.spr_SMB3_toad_raccoon_hold_jump
			3.0:
				return A.spr_SMB3_toadette_raccoon_hold_jump
	return null  # GML 走到结尾返回 undefined
