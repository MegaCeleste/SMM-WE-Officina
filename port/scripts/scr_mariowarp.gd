# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariowarp/scr_mariowarp.gml
static func scr_mariowarp(me: GMObject) -> Variant:
	if G.apariencia == 1.0:
		match G.jugador:
			0.0:
				return A.spr_SMB3_mario_raccoon_attack
			1.0:
				return A.spr_SMB3_luigi_raccoon_attack
			2.0:
				return A.spr_SMB3_mario_raccoon_attack
			3.0:
				return A.spr_SMB3_mario_raccoon_attack
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_spinjump
				1.0:
					return A.spr_mario_big_spinjump
				2.0:
					return A.spr_mario_fire_spinjump
				3.0:
					return A.spr_mario_big_spinjump
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_warp
				1.0:
					return A.spr_luigi_big_warp
				2.0:
					return A.spr_luigi_fire_warp
				3.0:
					return A.spr_luigi_big_warp
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_warp
				1.0:
					return A.spr_toad_big_warp
				2.0:
					return A.spr_toad_fire_warp
				3.0:
					return A.spr_toad_big_warp
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_warp
				1.0:
					return A.spr_toadette_big_warp
				2.0:
					return A.spr_toadette_fire_warp
				3.0:
					return A.spr_toadette_big_warp
				-82.0:
					return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
