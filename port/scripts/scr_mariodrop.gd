# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariodrop/scr_mariodrop.gml
static func scr_mariodrop(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_jump_drop
				1.0:
					return A.spr_SMB_mario_big_jump_drop
				2.0:
					return A.spr_SMB_mario_fire_jump_drop
				-50.0:
					return A.spr_SMB_mario_superball_jump_drop
				-77.0:
					return A.spr_SMB_mario_mega_jump_drop
				-78.0:
					return A.spr_SMB_mario_hen_jump_drop
				-85.0:
					return A.spr_SMB_link_jump_drop
				-80.0:
					return A.spr_SMB2_mario_big_jump_drop
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_jump_drop
				1.0:
					return A.spr_SMB_luigi_big_jump_drop
				2.0:
					return A.spr_SMB_luigi_fire_jump_drop
				-50.0:
					return A.spr_SMB_luigi_superball_jump_drop
				-77.0:
					return A.spr_SMB_luigi_mega_jump_drop
				-78.0:
					return A.spr_SMB_luigi_hen_jump_drop
				-85.0:
					return A.spr_SMB_link_jump_drop
				-80.0:
					return A.spr_SMB2_luigi_big_jump_drop
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_jump_drop
				1.0:
					return A.spr_SMB_toad_big_jump_drop
				2.0:
					return A.spr_SMB_toad_fire_jump_drop
				-50.0:
					return A.spr_SMB_toad_superball_jump_drop
				-77.0:
					return A.spr_SMB_toad_mega_jump_drop
				-78.0:
					return A.spr_SMB_toad_hen_jump_drop
				-85.0:
					return A.spr_SMB_link_jump_drop
				-80.0:
					return A.spr_SMB2_toad_big_jump_drop
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_jump_drop
				1.0:
					return A.spr_SMB_toadette_big_jump_drop
				2.0:
					return A.spr_SMB_toadette_fire_jump_drop
				-50.0:
					return A.spr_SMB_toadette_superball_jump_drop
				-77.0:
					return A.spr_SMB_toadette_mega_jump_drop
				-78.0:
					return A.spr_SMB_toadette_hen_jump_drop
				-85.0:
					return A.spr_SMB_link_jump_drop
				-80.0:
					return A.spr_SMB2_toadette_big_jump_drop
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_jump_drop
				1.0:
					return A.spr_SMB3_mario_big_jump_drop
				2.0:
					return A.spr_SMB3_mario_fire_jump_drop
				-39.0:
					return A.spr_SMB3_mario_raccoon_jump_drop
				-29.0:
					return A.spr_SMB3_mario_frog_jump_drop
				-46.0:
					return A.spr_SMB3_mario_hammer_jump_drop
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_jump_drop
				1.0:
					return A.spr_SMB3_luigi_big_jump_drop
				2.0:
					return A.spr_SMB3_luigi_fire_jump_drop
				-39.0:
					return A.spr_SMB3_luigi_raccoon_jump_drop
				-29.0:
					return A.spr_SMB3_mario_frog_jump_drop
				-46.0:
					return A.spr_SMB3_mario_hammer_jump_drop
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_jump_drop
				1.0:
					return A.spr_SMB3_toad_big_jump_drop
				2.0:
					return A.spr_SMB3_toad_fire_jump_drop
				-39.0:
					return A.spr_SMB3_toad_raccoon_jump_drop
				-29.0:
					return A.spr_SMB3_toad_frog_jump_drop
				-46.0:
					return A.spr_SMB3_toad_hammer_jump_drop
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_jump_drop
				1.0:
					return A.spr_SMB3_toadette_big_jump_drop
				2.0:
					return A.spr_SMB3_toadette_fire_jump_drop
				-39.0:
					return A.spr_SMB3_toadette_raccoon_jump_drop
				-29.0:
					return A.spr_SMB3_toadette_frog_jump_drop
				-46.0:
					return A.spr_SMB3_toadette_hammer_jump_drop
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_fall
				1.0:
					return A.spr_mario_big_fall
				2.0:
					return A.spr_mario_fire_fall
				3.0:
					return A.spr_mario_big_fall
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_jump_drop
				1.0:
					return A.spr_luigi_big_jump_drop
				2.0:
					return A.spr_luigi_fire_jump_drop
				3.0:
					return A.spr_luigi_big_jump_drop
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_jump_drop
				1.0:
					return A.spr_toad_big_jump_drop
				2.0:
					return A.spr_toad_fire_jump_drop
				3.0:
					return A.spr_toad_big_jump_drop
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_jump_drop
				1.0:
					return A.spr_toadette_big_jump_drop
				2.0:
					return A.spr_toadette_fire_jump_drop
				3.0:
					return A.spr_toadette_big_jump_drop
				-82.0:
					return A.spr_toadette_pballon_idle
	elif G.apariencia == 4.0:
		if G.jugador == 0.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_mario_big_jump_drop
		elif G.jugador == 1.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_luigi_big_jump_drop
		elif G.jugador == 2.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_toad_big_jump_drop
		elif G.jugador == 3.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_toadette_big_jump_drop
	return null  # GML 走到结尾返回 undefined
