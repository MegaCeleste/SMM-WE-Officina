# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_shoe/scr_mario_shoe.gml
static func scr_mario_shoe(me: GMObject):
	# gml_Script_scr_mario_shoe
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_shoe
				1.0:
					return A.spr_SMB_mario_big_shoe
				2.0:
					return A.spr_SMB_mario_fire_shoe
				-50.0:
					return A.spr_SMB_mario_superball_shoe
				-77.0:
					return A.spr_SMB_mario_mega_shoe
				-78.0:
					return A.spr_SMB_mario_hen_shoe
				-85.0:
					return A.spr_SMB_link_shoe
				-80.0:
					return A.spr_SMB2_mario_big_shoe
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_shoe
				1.0:
					return A.spr_SMB_luigi_big_shoe
				2.0:
					return A.spr_SMB_luigi_fire_shoe
				-50.0:
					return A.spr_SMB_luigi_superball_shoe
				-77.0:
					return A.spr_SMB_luigi_mega_shoe
				-78.0:
					return A.spr_SMB_luigi_hen_shoe
				-85.0:
					return A.spr_SMB_link_shoe
				-80.0:
					return A.spr_SMB2_luigi_big_shoe
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_shoe
				1.0:
					return A.spr_SMB_toad_big_shoe
				2.0:
					return A.spr_SMB_toad_fire_shoe
				-50.0:
					return A.spr_SMB_toad_superball_shoe
				-77.0:
					return A.spr_SMB_toad_mega_shoe
				-78.0:
					return A.spr_SMB_toad_hen_shoe
				-85.0:
					return A.spr_SMB_link_shoe
				-80.0:
					return A.spr_SMB2_toad_big_shoe
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_shoe
				1.0:
					return A.spr_SMB_toadette_big_shoe
				2.0:
					return A.spr_SMB_toadette_fire_shoe
				-50.0:
					return A.spr_SMB_toadette_superball_shoe
				-77.0:
					return A.spr_SMB_toadette_mega_shoe
				-78.0:
					return A.spr_SMB_toadette_hen_shoe
				-85.0:
					return A.spr_SMB_link_shoe
				-80.0:
					return A.spr_SMB2_toadette_big_shoe
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_shoe
				1.0:
					return A.spr_SMB3_mario_big_shoe
				2.0:
					return A.spr_SMB3_mario_fire_shoe
				-39.0:
					return A.spr_SMB3_mario_raccoon_shoe
				-29.0:
					return A.spr_SMB3_mario_frog_shoe
				-46.0:
					return A.spr_SMB3_mario_hammer_shoe
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_shoe
				1.0:
					return A.spr_SMB3_luigi_big_shoe
				2.0:
					return A.spr_SMB3_luigi_fire_shoe
				-39.0:
					return A.spr_SMB3_luigi_raccoon_shoe
				-29.0:
					return A.spr_SMB3_mario_frog_shoe
				-46.0:
					return A.spr_SMB3_mario_hammer_shoe
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_shoe
				1.0:
					return A.spr_SMB3_toad_big_shoe
				2.0:
					return A.spr_SMB3_toad_fire_shoe
				-39.0:
					return A.spr_SMB3_toad_raccoon_shoe
				-29.0:
					return A.spr_SMB3_toad_frog_shoe
				-46.0:
					return A.spr_SMB3_toad_hammer_shoe
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_shoe
				1.0:
					return A.spr_SMB3_toadette_big_shoe
				2.0:
					return A.spr_SMB3_toadette_fire_shoe
				-39.0:
					return A.spr_SMB3_toadette_raccoon_shoe
				-29.0:
					return A.spr_SMB3_toadette_frog_shoe
				-46.0:
					return A.spr_SMB3_toadette_hammer_shoe
