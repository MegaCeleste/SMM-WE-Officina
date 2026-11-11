# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioduckhold/scr_marioduckhold.gml
static func scr_marioduckhold(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_mario_big_duck_hold
		elif G.jugador == 1.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_luigi_big_duck_hold
		elif G.jugador == 2.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_toad_big_duck_hold
		elif G.jugador == 3.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_toadette_big_duck_hold
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_duck_hold
				1.0:
					return A.spr_mario_big_duck_hold
				2.0:
					return A.spr_mario_fire_duck_hold
				3.0:
					return A.spr_mario_big_duck_hold
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_duck_hold
				1.0:
					return A.spr_luigi_big_duck_hold
				2.0:
					return A.spr_luigi_fire_duck_hold
				3.0:
					return A.spr_luigi_big_duck_hold
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_duck_hold
				1.0:
					return A.spr_toad_big_duck_hold
				2.0:
					return A.spr_toad_fire_duck_hold
				3.0:
					return A.spr_toad_big_duck_hold
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_duck_hold
				1.0:
					return A.spr_toadette_big_duck_hold
				2.0:
					return A.spr_toadette_fire_duck_hold
				3.0:
					return A.spr_toadette_big_duck_hold
				-82.0:
					return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
