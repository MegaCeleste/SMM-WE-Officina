# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariorunjump/scr_mariorunjump.gml
static func scr_mariorunjump(me: GMObject) -> Variant:
	if G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_runjump
				1.0:
					return A.spr_SMB3_mario_big_runjump
				2.0:
					return A.spr_SMB3_mario_fire_runjump
				-39.0:
					return A.spr_SMB3_mario_raccoon_runjump
				-46.0:
					return A.spr_SMB3_mario_hammer_runjump
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_runjump
				1.0:
					return A.spr_SMB3_luigi_big_runjump
				2.0:
					return A.spr_SMB3_luigi_fire_runjump
				-39.0:
					return A.spr_SMB3_luigi_raccoon_runjump
				-46.0:
					return A.spr_SMB3_mario_hammer_runjump
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_runjump
				1.0:
					return A.spr_SMB3_toad_big_runjump
				2.0:
					return A.spr_SMB3_toad_fire_runjump
				-39.0:
					return A.spr_SMB3_toad_raccoon_runjump
				-46.0:
					return A.spr_SMB3_toad_hammer_runjump
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_runjump
				1.0:
					return A.spr_SMB3_toadette_big_runjump
				2.0:
					return A.spr_SMB3_toadette_fire_runjump
				-39.0:
					return A.spr_SMB3_toadette_raccoon_runjump
				-46.0:
					return A.spr_SMB3_toadette_hammer_runjump
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_runjump
				1.0:
					return A.spr_mario_big_runjump
				2.0:
					return A.spr_mario_fire_runjump
				3.0:
					return A.spr_mario_big_runjump
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_runjump
				1.0:
					return A.spr_luigi_big_runjump
				2.0:
					return A.spr_luigi_fire_runjump
				3.0:
					return A.spr_luigi_big_runjump
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_runjump
				1.0:
					return A.spr_toad_big_runjump
				2.0:
					return A.spr_toad_fire_runjump
				3.0:
					return A.spr_toad_big_runjump
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_runjump
				1.0:
					return A.spr_toadette_big_runjump
				2.0:
					return A.spr_toadette_fire_runjump
				3.0:
					return A.spr_toadette_big_runjump
				-82.0:
					return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
