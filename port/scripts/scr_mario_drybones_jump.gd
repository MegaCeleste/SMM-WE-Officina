# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_drybones_jump/scr_mario_drybones_jump.gml
static func scr_mario_drybones_jump(me: GMObject):
	if G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_drybones_jump
				1.0:
					return A.spr_SMB3_mario_big_drybones_jump
				2.0:
					return A.spr_SMB3_mario_fire_drybones_jump
				-39.0:
					return A.spr_SMB3_mario_raccoon_drybones_jump
				-29.0:
					return A.spr_SMB3_mario_frog_drybones_jump
				-46.0:
					return A.spr_SMB3_mario_hammer_drybones_jump
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_drybones_jump
				1.0:
					return A.spr_SMB3_luigi_big_drybones_jump
				2.0:
					return A.spr_SMB3_luigi_fire_drybones_jump
				-39.0:
					return A.spr_SMB3_luigi_raccoon_drybones_jump
				-29.0:
					return A.spr_SMB3_mario_frog_drybones_jump
				-46.0:
					return A.spr_SMB3_mario_hammer_drybones_jump
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_drybones_jump
				1.0:
					return A.spr_SMB3_toad_big_drybones_jump
				2.0:
					return A.spr_SMB3_toad_fire_drybones_jump
				-39.0:
					return A.spr_SMB3_toad_raccoon_drybones_jump
				-29.0:
					return A.spr_SMB3_toad_frog_drybones_jump
				-46.0:
					return A.spr_SMB3_toad_hammer_drybones_jump
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_drybones_jump
				1.0:
					return A.spr_SMB3_toadette_big_drybones_jump
				2.0:
					return A.spr_SMB3_toadette_fire_drybones_jump
				-39.0:
					return A.spr_SMB3_toadette_raccoon_drybones_jump
				-29.0:
					return A.spr_SMB3_toadette_frog_drybones_jump
				-46.0:
					return A.spr_SMB3_toadette_hammer_drybones_jump
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_drybones_jump
				1.0:
					return A.spr_mario_big_drybones_jump
				2.0:
					return A.spr_mario_fire_drybones_jump
				3.0:
					return A.spr_mario_big_drybones_jump
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_drybones_jump
				1.0:
					return A.spr_luigi_big_drybones_jump
				2.0:
					return A.spr_luigi_fire_drybones_jump
				3.0:
					return A.spr_luigi_big_drybones_jump
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_drybones_jump
				1.0:
					return A.spr_toad_big_drybones_jump
				2.0:
					return A.spr_toad_fire_drybones_jump
				3.0:
					return A.spr_toad_big_drybones_jump
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_drybones_jump
				1.0:
					return A.spr_toadette_big_drybones_jump
				2.0:
					return A.spr_toadette_fire_drybones_jump
				3.0:
					return A.spr_toadette_big_drybones_jump
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
