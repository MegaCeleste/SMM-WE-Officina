# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioskid/scr_marioskid.gml
static func scr_marioskid(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_skid
				1.0:
					return A.spr_SMB_mario_big_skid
				2.0:
					return A.spr_SMB_mario_fire_skid
				-50.0:
					return A.spr_SMB_mario_superball_skid
				-77.0:
					return A.spr_SMB_mario_mega_skid
				-78.0:
					return A.spr_SMB_mario_hen_skid
				-85.0:
					return A.spr_SMB_link_skid
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_skid
				1.0:
					return A.spr_SMB_luigi_big_skid
				2.0:
					return A.spr_SMB_luigi_fire_skid
				-50.0:
					return A.spr_SMB_luigi_superball_skid
				-77.0:
					return A.spr_SMB_luigi_mega_skid
				-78.0:
					return A.spr_SMB_luigi_hen_skid
				-85.0:
					return A.spr_SMB_link_skid
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_skid
				1.0:
					return A.spr_SMB_toad_big_skid
				2.0:
					return A.spr_SMB_toad_fire_skid
				-50.0:
					return A.spr_SMB_toad_superball_skid
				-77.0:
					return A.spr_SMB_toad_mega_skid
				-78.0:
					return A.spr_SMB_toad_hen_skid
				-85.0:
					return A.spr_SMB_link_skid
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_skid
				1.0:
					return A.spr_SMB_toadette_big_skid
				2.0:
					return A.spr_SMB_toadette_fire_skid
				-50.0:
					return A.spr_SMB_toadette_superball_skid
				-77.0:
					return A.spr_SMB_toadette_mega_skid
				-78.0:
					return A.spr_SMB_toadette_hen_skid
				-85.0:
					return A.spr_SMB_link_skid
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_skid
				1.0:
					return A.spr_SMB3_mario_big_skid
				2.0:
					return A.spr_SMB3_mario_fire_skid
				-39.0:
					return A.spr_SMB3_mario_raccoon_skid
				-46.0:
					return A.spr_SMB3_mario_hammer_skid
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_skid
				1.0:
					return A.spr_SMB3_luigi_big_skid
				2.0:
					return A.spr_SMB3_luigi_fire_skid
				-39.0:
					return A.spr_SMB3_luigi_raccoon_skid
				-46.0:
					return A.spr_SMB3_mario_hammer_skid
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_skid
				1.0:
					return A.spr_SMB3_toad_big_skid
				2.0:
					return A.spr_SMB3_toad_fire_skid
				-39.0:
					return A.spr_SMB3_toad_raccoon_skid
				-46.0:
					return A.spr_SMB3_toad_hammer_skid
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_skid
				1.0:
					return A.spr_SMB3_toadette_big_skid
				2.0:
					return A.spr_SMB3_toadette_fire_skid
				-39.0:
					return A.spr_SMB3_toadette_raccoon_skid
				-46.0:
					return A.spr_SMB3_toadette_hammer_skid
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_skid
				1.0:
					return A.spr_mario_big_skid
				2.0:
					return A.spr_mario_fire_skid
				3.0:
					return A.spr_mario_big_skid
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_skid
				1.0:
					return A.spr_luigi_big_skid
				2.0:
					return A.spr_luigi_fire_skid
				3.0:
					return A.spr_luigi_big_skid
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_skid
				1.0:
					return A.spr_toad_big_skid
				2.0:
					return A.spr_toad_fire_skid
				3.0:
					return A.spr_toad_big_skid
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_skid
				1.0:
					return A.spr_toadette_big_skid
				2.0:
					return A.spr_toadette_fire_skid
				3.0:
					return A.spr_toadette_big_skid
				-82.0:
					return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
