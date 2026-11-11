# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioidle/scr_marioidle.gml
static func scr_marioidle(me: GMObject) -> Variant:
	# gml_Script_scr_marioidle
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_idle
				1.0:
					return A.spr_SMB_mario_big_idle
				2.0:
					return A.spr_SMB_mario_fire_idle
				-50.0:
					return A.spr_SMB_mario_superball_idle
				-77.0:
					return A.spr_SMB_mario_mega_idle
				-78.0:
					return A.spr_SMB_mario_hen_idle
				-80.0:
					return A.spr_SMB2_mario_big_idle
				-85.0:
					return A.spr_SMB_link_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_idle
				1.0:
					return A.spr_SMB_luigi_big_idle
				2.0:
					return A.spr_SMB_luigi_fire_idle
				-50.0:
					return A.spr_SMB_luigi_superball_idle
				-77.0:
					return A.spr_SMB_luigi_mega_idle
				-78.0:
					return A.spr_SMB_luigi_hen_idle
				-80.0:
					return A.spr_SMB2_luigi_big_idle
				-85.0:
					return A.spr_SMB_link_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_idle
				1.0:
					return A.spr_SMB_toad_big_idle
				2.0:
					return A.spr_SMB_toad_fire_idle
				-50.0:
					return A.spr_SMB_toad_superball_idle
				-77.0:
					return A.spr_SMB_toad_mega_idle
				-78.0:
					return A.spr_SMB_toad_hen_idle
				-80.0:
					return A.spr_SMB2_toad_big_idle
				-85.0:
					return A.spr_SMB_link_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_idle
				1.0:
					return A.spr_SMB_toadette_big_idle
				2.0:
					return A.spr_SMB_toadette_fire_idle
				-50.0:
					return A.spr_SMB_toadette_superball_idle
				-77.0:
					return A.spr_SMB_toadette_mega_idle
				-78.0:
					return A.spr_SMB_toadette_hen_idle
				-80.0:
					return A.spr_SMB2_toadette_big_idle
				-85.0:
					return A.spr_SMB_link_idle
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_idle
				1.0:
					return A.spr_SMB3_mario_big_idle
				2.0:
					return A.spr_SMB3_mario_fire_idle
				-39.0:
					return A.spr_SMB3_mario_raccoon_idle
				-29.0:
					return A.spr_SMB3_mario_frog_idle
				-46.0:
					return A.spr_SMB3_mario_hammer_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_idle
				1.0:
					return A.spr_SMB3_luigi_big_idle
				2.0:
					return A.spr_SMB3_luigi_fire_idle
				-39.0:
					return A.spr_SMB3_luigi_raccoom_idle
				-29.0:
					return A.spr_SMB3_mario_frog_idle
				-46.0:
					return A.spr_SMB3_mario_hammer_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_idle
				1.0:
					return A.spr_SMB3_toad_big_idle
				2.0:
					return A.spr_SMB3_toad_fire_idle
				-39.0:
					return A.spr_SMB3_toad_raccoom_idle
				-29.0:
					return A.spr_SMB3_toad_frog_idle
				-46.0:
					return A.spr_SMB3_toad_hammer_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_idle
				1.0:
					return A.spr_SMB3_toadette_big_idle
				2.0:
					return A.spr_SMB3_toadette_fire_idle
				-39.0:
					return A.spr_SMB3_toadette_raccoom_idle
				-29.0:
					return A.spr_SMB3_toadette_frog_idle
				-46.0:
					return A.spr_SMB3_toadette_hammer_idle
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_idle
				1.0:
					return A.spr_mario_big_idle
				2.0:
					return A.spr_mario_fire_idle
				3.0:
					return A.spr_mario_big_idle
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_idle
				1.0:
					return A.spr_luigi_big_idle
				2.0:
					return A.spr_luigi_fire_idle
				3.0:
					return A.spr_luigi_big_idle
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_idle
				1.0:
					return A.spr_toad_big_idle
				2.0:
					return A.spr_toad_fire_idle
				3.0:
					return A.spr_toad_big_idle
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_idle
				1.0:
					return A.spr_toadette_big_idle
				2.0:
					return A.spr_toadette_fire_idle
				3.0:
					return A.spr_toadette_big_idle
				-82.0:
					return A.spr_toadette_pballon_idle
	elif G.apariencia == 3.0:
		match G.powerup:
			0.0:
				return A.spr_NSMBU_mario_small_ground_idle
			1.0:
				return A.spr_NSMBU_mario_big_ground_idle
			2.0:
				return A.spr_NSMBU_mario_big_ground_idle
			-30.0:
				return A.spr_NSMBU_mario_helice_ground_idle
			-43.0:
				return A.spr_NSMBU_mario_arcon_idle
			-38.0:
				return A.spr_NSMBU_mario_penguin_idle
	return null  # GML 走到结尾返回 undefined
