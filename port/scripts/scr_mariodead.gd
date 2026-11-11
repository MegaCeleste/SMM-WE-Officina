# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariodead/scr_mariodead.gml
static func scr_mariodead(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		match G.jugador:
			0.0:
				return A.spr_SMB_mario_dead
			1.0:
				return A.spr_SMB_luigi_dead
			2.0:
				return A.spr_SMB_toad_dead
			3.0:
				return A.spr_SMB_toadette_dead
	elif G.apariencia == 1.0:
		match G.jugador:
			0.0:
				return A.spr_SMB3_mario_dead
			1.0:
				return A.spr_SMB3_luigi_dead
			2.0:
				return A.spr_SMB3_toad_dead
			3.0:
				return A.spr_SMB3_toadette_dead
	elif G.apariencia == 2.0:
		match G.jugador:
			0.0:
				return A.spr_mario_dead
			1.0:
				return A.spr_luigi_dead
			2.0:
				return A.spr_toad_dead
			3.0:
				return A.spr_toadette_dead
	elif G.apariencia == 3.0:
		match G.powerup:
			0.0:
				return A.spr_NSMBU_mario_small_dead1
			1.0:
				return A.spr_NSMBU_mario_big_dead1
			2.0:
				return A.spr_NSMBU_mario_fire_dead1
			-30.0:
				return A.spr_NSMBU_mario_helice_dead1
			-43.0:
				return A.spr_NSMBU_mario_arcon_dead1
			-38.0:
				return A.spr_NSMBU_mario_penguin_dead1
	if G.apariencia == 4.0:
		match G.jugador:
			0.0:
				return A.spr_SMB2_mario_dead
			1.0:
				return A.spr_SMB2_luigi_dead
			2.0:
				return A.spr_SMB2_toad_dead
			3.0:
				return A.spr_SMB2_toadette_dead
	return null  # GML 走到结尾返回 undefined
