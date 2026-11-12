# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_drybones/scr_mario_drybones.gml
static func scr_mario_drybones(me: GMObject):
	# gml_Script_scr_mario_drybones
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_drybones
				1.0:
					return A.spr_SMB_mario_big_drybones
				2.0:
					return A.spr_SMB_mario_fire_drybones
				-50.0:
					return A.spr_SMB_mario_superball_drybones
				-77.0:
					return A.spr_SMB_mario_mega_drybones
				-78.0:
					return A.spr_SMB_mario_hen_drybones
				-85.0:
					return A.spr_SMB_link_drybones
				-80.0:
					return A.spr_SMB2_mario_big_drybones
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_drybones
				1.0:
					return A.spr_SMB_luigi_big_drybones
				2.0:
					return A.spr_SMB_luigi_fire_drybones
				-50.0:
					return A.spr_SMB_luigi_superball_drybones
				-77.0:
					return A.spr_SMB_luigi_mega_drybones
				-78.0:
					return A.spr_SMB_luigi_hen_drybones
				-85.0:
					return A.spr_SMB_link_drybones
				-80.0:
					return A.spr_SMB2_luigi_big_drybones
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_drybones
				1.0:
					return A.spr_SMB_toad_big_drybones
				2.0:
					return A.spr_SMB_toad_fire_drybones
				-50.0:
					return A.spr_SMB_toad_superball_drybones
				-77.0:
					return A.spr_SMB_toad_mega_drybones
				-78.0:
					return A.spr_SMB_toad_hen_drybones
				-85.0:
					return A.spr_SMB_link_drybones
				-80.0:
					return A.spr_SMB2_toad_big_drybones
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_drybones
				1.0:
					return A.spr_SMB_toadette_big_drybones
				2.0:
					return A.spr_SMB_toadette_fire_drybones
				-50.0:
					return A.spr_SMB_toadette_superball_drybones
				-77.0:
					return A.spr_SMB_toadette_mega_drybones
				-78.0:
					return A.spr_SMB_toadette_hen_drybones
				-85.0:
					return A.spr_SMB_link_drybones
				-80.0:
					return A.spr_SMB2_toadette_big_drybones
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_drybones
				1.0:
					return A.spr_SMB3_mario_big_drybones
				2.0:
					return A.spr_SMB3_mario_fire_drybones
				-39.0:
					return A.spr_SMB3_mario_raccoon_drybones
				-29.0:
					return A.spr_SMB3_mario_frog_drybones
				-46.0:
					return A.spr_SMB3_mario_hammer_drybones
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_drybones
				1.0:
					return A.spr_SMB3_luigi_big_drybones
				2.0:
					return A.spr_SMB3_luigi_fire_drybones
				-39.0:
					return A.spr_SMB3_luigi_raccoon_drybones
				-29.0:
					return A.spr_SMB3_mario_frog_drybones
				-46.0:
					return A.spr_SMB3_mario_hammer_drybones
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_drybones
				1.0:
					return A.spr_SMB3_toad_big_drybones
				2.0:
					return A.spr_SMB3_toad_fire_drybones
				-39.0:
					return A.spr_SMB3_toad_raccoon_drybones
				-29.0:
					return A.spr_SMB3_toad_frog_drybones
				-46.0:
					return A.spr_SMB3_toad_hammer_drybones
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_drybones
				1.0:
					return A.spr_SMB3_toadette_big_drybones
				2.0:
					return A.spr_SMB3_toadette_fire_drybones
				-39.0:
					return A.spr_SMB3_toadette_raccoon_drybones
				-29.0:
					return A.spr_SMB3_toadette_frog_drybones
				-46.0:
					return A.spr_SMB3_toadette_hammer_drybones
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_drybones
				1.0:
					return A.spr_mario_big_drybones
				2.0:
					return A.spr_mario_fire_drybones
				3.0:
					return A.spr_mario_big_drybones
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_drybones
				1.0:
					return A.spr_luigi_big_drybones
				2.0:
					return A.spr_luigi_fire_drybones
				3.0:
					return A.spr_luigi_big_drybones
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_drybones
				1.0:
					return A.spr_toad_big_drybones
				2.0:
					return A.spr_toad_fire_drybones
				3.0:
					return A.spr_toad_big_drybones
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_drybones
				1.0:
					return A.spr_toadette_big_drybones
				2.0:
					return A.spr_toadette_fire_drybones
				3.0:
					return A.spr_toadette_big_drybones
	elif G.apariencia == 3.0:
		match G.powerup:
			0.0:
				return A.spr_NSMBU_mario_small_drybones
			1.0:
				return A.spr_NSMBU_mario_big_drybones
			2.0:
				return A.spr_NSMBU_mario_fire_drybones
			-30.0:
				return A.spr_NSMBU_mario_helice_drybones
			-38.0:
				return A.spr_NSMBU_mario_penguin_drybones
			-43.0:
				return A.spr_NSMBU_mario_arcon_drybones
