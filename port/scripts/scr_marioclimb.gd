# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioclimb/scr_marioclimb.gml
static func scr_marioclimb(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_mario_small_climb
				1.0:
					return A.spr_SMB_mario_big_climb
				2.0:
					return A.spr_SMB_mario_fire_climb
				-50.0:
					return A.spr_SMB_mario_superball_climb
				-77.0:
					return A.spr_SMB_mario_mega_climb
				-78.0:
					return A.spr_SMB_mario_hen_climb
				-85.0:
					return A.spr_SMB_link_climb
				-80.0:
					return A.spr_SMB2_mario_big_climb
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_luigi_small_climb
				1.0:
					return A.spr_SMB_luigi_big_climb
				2.0:
					return A.spr_SMB_luigi_fire_climb
				-50.0:
					return A.spr_SMB_luigi_superball_climb
				-77.0:
					return A.spr_SMB_luigi_mega_climb
				-78.0:
					return A.spr_SMB_luigi_hen_climb
				-85.0:
					return A.spr_SMB_link_climb
				-80.0:
					return A.spr_SMB2_luigi_big_climb
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toad_small_climb
				1.0:
					return A.spr_SMB_toad_big_climb
				2.0:
					return A.spr_SMB_toad_fire_climb
				-50.0:
					return A.spr_SMB_toad_superball_climb
				-77.0:
					return A.spr_SMB_toad_mega_climb
				-78.0:
					return A.spr_SMB_toad_hen_climb
				-85.0:
					return A.spr_SMB_link_climb
				-80.0:
					return A.spr_SMB2_toad_big_climb
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB_toadette_small_climb
				1.0:
					return A.spr_SMB_toadette_big_climb
				2.0:
					return A.spr_SMB_toadette_fire_climb
				-50.0:
					return A.spr_SMB_toadette_superball_climb
				-77.0:
					return A.spr_SMB_toadette_mega_climb
				-78.0:
					return A.spr_SMB_toadette_hen_climb
				-85.0:
					return A.spr_SMB_link_climb
				-80.0:
					return A.spr_SMB2_toadette_big_climb
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_climb
				1.0:
					return A.spr_SMB3_mario_big_climb
				2.0:
					return A.spr_SMB3_mario_fire_climb
				-39.0:
					return A.spr_SMB3_mario_raccoon_climb
				-29.0:
					return A.spr_SMB3_mario_frog_climb
				-46.0:
					return A.spr_SMB3_mario_hammer_climb
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_climb
				1.0:
					return A.spr_SMB3_luigi_big_climb
				2.0:
					return A.spr_SMB3_luigi_fire_climb
				-39.0:
					return A.spr_SMB3_luigi_raccoon_climb
				-29.0:
					return A.spr_SMB3_mario_frog_climb
				-46.0:
					return A.spr_SMB3_mario_hammer_climb
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_climb
				1.0:
					return A.spr_SMB3_toad_big_climb
				2.0:
					return A.spr_SMB3_toad_fire_climb
				-39.0:
					return A.spr_SMB3_toad_raccoon_climb
				-29.0:
					return A.spr_SMB3_toad_frog_climb
				-46.0:
					return A.spr_SMB3_toad_hammer_climb
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_climb
				1.0:
					return A.spr_SMB3_toadette_big_climb
				2.0:
					return A.spr_SMB3_toadette_fire_climb
				-39.0:
					return A.spr_SMB3_toadette_raccoon_climb
				-29.0:
					return A.spr_SMB3_toadette_frog_climb
				-46.0:
					return A.spr_SMB3_toadette_hammer_climb
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_climb
				1.0:
					return A.spr_mario_big_climb
				2.0:
					return A.spr_mario_fire_climb
				3.0:
					return A.spr_mario_big_climb
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_climb
				1.0:
					return A.spr_luigi_big_climb
				2.0:
					return A.spr_luigi_fire_climb
				3.0:
					return A.spr_luigi_big_climb
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_climb
				1.0:
					return A.spr_toad_big_climb
				2.0:
					return A.spr_toad_fire_climb
				3.0:
					return A.spr_toad_big_climb
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_climb
				1.0:
					return A.spr_toadette_big_climb
				2.0:
					return A.spr_toadette_fire_climb
				3.0:
					return A.spr_toadette_big_climb
				-82.0:
					return A.spr_toadette_pballon_idle
	if G.apariencia == 3.0:
		match G.powerup:
			0.0:
				return A.spr_NSMBU_mario_small_climb
			1.0:
				return A.spr_NSMBU_mario_big_climb
			2.0:
				return A.spr_NSMBU_mario_fire_climb
			-30.0:
				return A.spr_NSMBU_mario_helice_climb
			-43.0:
				return A.spr_NSMBU_mario_arcon_climb
			-38.0:
				return A.spr_NSMBU_mario_penguin_climb
	elif G.apariencia == 4.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_mario_small_climb is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_mario_big_climb
				2.0:
					return null  # ORIG-BUG: spr_SMB2_mario_fire_climb is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_luigi_small_climb is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_luigi_big_climb
				2.0:
					return null  # ORIG-BUG: spr_SMB2_luigi_fire_climb is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_toad_small_climb is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_toad_big_climb
				2.0:
					return null  # ORIG-BUG: spr_SMB2_toad_fire_climb is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_toadette_small_climb is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_toadette_big_climb
				2.0:
					return null  # ORIG-BUG: spr_SMB2_toadette_fire_climb is not a resource in the original project (undefined variable in GML)
	return null  # GML 走到结尾返回 undefined
