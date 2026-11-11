# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioswim/scr_marioswim.gml
static func scr_marioswim(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_swim
				1.0:
					return A.spr_SMB_mario_big_swim
				2.0:
					return A.spr_SMB_mario_fire_swim
				-50.0:
					return A.spr_SMB_mario_superball_swim
				-77.0:
					return A.spr_SMB_mario_mega_swim
				-78.0:
					return A.spr_SMB_mario_hen_swim
				-85.0:
					return A.spr_SMB_link_swim
				-80.0:
					return A.spr_SMB2_mario_big_swim
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_swim
				1.0:
					return A.spr_SMB_luigi_big_swim
				2.0:
					return A.spr_SMB_luigi_fire_swim
				-50.0:
					return A.spr_SMB_luigi_superball_swim
				-77.0:
					return A.spr_SMB_luigi_mega_swim
				-78.0:
					return A.spr_SMB_luigi_hen_swim
				-85.0:
					return A.spr_SMB_link_swim
				-80.0:
					return A.spr_SMB2_luigi_big_swim
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_swim
				1.0:
					return A.spr_SMB_toad_big_swim
				2.0:
					return A.spr_SMB_toad_fire_swim
				-50.0:
					return A.spr_SMB_toad_superball_swim
				-77.0:
					return A.spr_SMB_toad_mega_swim
				-78.0:
					return A.spr_SMB_toad_hen_swim
				-85.0:
					return A.spr_SMB_link_swim
				-80.0:
					return A.spr_SMB2_toad_big_swim
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_swim
				1.0:
					return A.spr_SMB_toadette_big_swim
				2.0:
					return A.spr_SMB_toadette_fire_swim
				-50.0:
					return A.spr_SMB_toadette_superball_swim
				-77.0:
					return A.spr_SMB_toadette_mega_swim
				-78.0:
					return A.spr_SMB_toadette_hen_swim
				-85.0:
					return A.spr_SMB_link_swim
				-80.0:
					return A.spr_SMB2_toadette_big_swim
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_swim
				1.0:
					return A.spr_SMB3_mario_big_swim
				2.0:
					return A.spr_SMB3_mario_fire_swim
				-39.0:
					return A.spr_SMB3_mario_raccoon_swim
				-29.0:
					return A.spr_SMB3_mario_frog_swim
				-46.0:
					return A.spr_SMB3_mario_hammer_swim
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_swim
				1.0:
					return A.spr_SMB3_luigi_big_swim
				2.0:
					return A.spr_SMB3_luigi_fire_swim
				-39.0:
					return A.spr_SMB3_luigi_raccoon_swim
				-29.0:
					return A.spr_SMB3_mario_frog_swim
				-46.0:
					return A.spr_SMB3_mario_hammer_swim
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_swim
				1.0:
					return A.spr_SMB3_toad_big_swim
				2.0:
					return A.spr_SMB3_toad_fire_swim
				-39.0:
					return A.spr_SMB3_toad_raccoon_swim
				-29.0:
					return A.spr_SMB3_toad_frog_swim
				-46.0:
					return A.spr_SMB3_toad_hammer_swim
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_swim
				1.0:
					return A.spr_SMB3_toadette_big_swim
				2.0:
					return A.spr_SMB3_toadette_fire_swim
				-39.0:
					return A.spr_SMB3_toadette_raccoon_swim
				-29.0:
					return A.spr_SMB3_toadette_frog_swim
				-46.0:
					return A.spr_SMB3_toadette_hammer_swim
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_swim
				1.0:
					return A.spr_mario_big_swim
				2.0:
					return A.spr_mario_fire_swim
				3.0:
					return A.spr_mario_big_swim
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_swim
				1.0:
					return A.spr_luigi_big_swim
				2.0:
					return A.spr_luigi_fire_swim
				3.0:
					return A.spr_luigi_big_swim
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_swim
				1.0:
					return A.spr_toad_big_swim
				2.0:
					return A.spr_toad_fire_swim
				3.0:
					return A.spr_toad_big_swim
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_swim
				1.0:
					return A.spr_toadette_big_swim
				2.0:
					return A.spr_toadette_fire_swim
				3.0:
					return A.spr_toadette_big_swim
				-82.0:
					return A.spr_toadette_pballon_idle
	elif G.apariencia == 4.0:
		if G.jugador == 0.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_mario_big_swim
		elif G.jugador == 1.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_luigi_big_swim
		elif G.jugador == 2.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_toad_big_swim
		elif G.jugador == 3.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_toadette_big_swim
	return null  # GML 走到结尾返回 undefined
