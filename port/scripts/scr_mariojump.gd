# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariojump/scr_mariojump.gml
static func scr_mariojump(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_jump
				1.0:
					return A.spr_SMB_mario_big_jump
				2.0:
					return A.spr_SMB_mario_fire_jump
				-50.0:
					return A.spr_SMB_mario_superball_jump
				-77.0:
					return A.spr_SMB_mario_mega_jump
				-78.0:
					return A.spr_SMB_mario_hen_jump
				-85.0:
					return A.spr_SMB_link_jump
				-80.0:
					return A.spr_SMB2_mario_big_jump
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_jump
				1.0:
					return A.spr_SMB_luigi_big_jump
				2.0:
					return A.spr_SMB_luigi_fire_jump
				-50.0:
					return A.spr_SMB_luigi_superball_jump
				-77.0:
					return A.spr_SMB_luigi_mega_jump
				-78.0:
					return A.spr_SMB_luigi_hen_jump
				-85.0:
					return A.spr_SMB_link_jump
				-80.0:
					return A.spr_SMB2_luigi_big_jump
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_jump
				1.0:
					return A.spr_SMB_toad_big_jump
				2.0:
					return A.spr_SMB_toad_fire_jump
				-50.0:
					return A.spr_SMB_toad_superball_jump
				-77.0:
					return A.spr_SMB_toad_mega_jump
				-78.0:
					return A.spr_SMB_toad_hen_jump
				-85.0:
					return A.spr_SMB_link_jump
				-80.0:
					return A.spr_SMB2_toad_big_jump
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_jump
				1.0:
					return A.spr_SMB_toadette_big_jump
				2.0:
					return A.spr_SMB_toadette_fire_jump
				-50.0:
					return A.spr_SMB_toadette_superball_jump
				-77.0:
					return A.spr_SMB_toadette_mega_jump
				-78.0:
					return A.spr_SMB_toadette_hen_jump
				-85.0:
					return A.spr_SMB_link_jump
				-80.0:
					return A.spr_SMB2_toadette_big_jump
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_jump
				1.0:
					return A.spr_SMB3_mario_big_jump
				2.0:
					return A.spr_SMB3_mario_fire_jump
				-39.0:
					return A.spr_SMB3_mario_raccoon_jump
				-29.0:
					return A.spr_SMB3_mario_frog_jump
				-46.0:
					return A.spr_SMB3_mario_hammer_jump
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_jump
				1.0:
					return A.spr_SMB3_luigi_big_jump
				2.0:
					return A.spr_SMB3_luigi_fire_jump
				-39.0:
					return A.spr_SMB3_luigi_raccoon_jump
				-29.0:
					return A.spr_SMB3_mario_frog_jump
				-46.0:
					return A.spr_SMB3_mario_hammer_jump
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_jump
				1.0:
					return A.spr_SMB3_toad_big_jump
				2.0:
					return A.spr_SMB3_toad_fire_jump
				-39.0:
					return A.spr_SMB3_toad_raccoon_jump
				-29.0:
					return A.spr_SMB3_toad_frog_jump
				-46.0:
					return A.spr_SMB3_toad_hammer_jump
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_jump
				1.0:
					return A.spr_SMB3_toadette_big_jump
				2.0:
					return A.spr_SMB3_toadette_fire_jump
				-39.0:
					return A.spr_SMB3_toadette_raccoon_jump
				-29.0:
					return A.spr_SMB3_toadette_frog_jump
				-46.0:
					return A.spr_SMB3_toadette_hammer_jump
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_jump
				1.0:
					return A.spr_mario_big_jump
				2.0:
					return A.spr_mario_fire_jump
				3.0:
					return A.spr_mario_big_jump
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_jump
				1.0:
					return A.spr_luigi_big_jump
				2.0:
					return A.spr_luigi_fire_jump
				3.0:
					return A.spr_luigi_big_jump
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_jump
				1.0:
					return A.spr_toad_big_jump
				2.0:
					return A.spr_toad_fire_jump
				3.0:
					return A.spr_toad_big_jump
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_jump
				1.0:
					return A.spr_toadette_big_jump
				2.0:
					return A.spr_toadette_fire_jump
				3.0:
					return A.spr_toadette_big_jump
				-82.0:
					return A.spr_toadette_pballon_idle
	elif G.apariencia == 4.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_mario_small_jump is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_mario_big_jump
				2.0:
					return null  # ORIG-BUG: spr_SMB2_mario_fire_jump is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 1.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_luigi_big_jump
		elif G.jugador == 2.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_toad_big_jump
		elif G.jugador == 3.0:
			match G.powerup:
				1.0:
					return A.spr_SMB2_toadette_big_jump
	return null  # GML 走到结尾返回 undefined
