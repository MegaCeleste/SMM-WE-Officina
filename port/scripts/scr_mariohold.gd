# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariohold/scr_mariohold.gml
static func scr_mariohold(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_mario_big_hold
				-85.0:
					return A.spr_SMB_link_hold
		elif G.jugador == 1.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_luigi_big_hold
				-85.0:
					return A.spr_SMB_link_hold
		elif G.jugador == 2.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_toad_big_hold
				-85.0:
					return A.spr_SMB_link_hold
		elif G.jugador == 3.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_toadette_big_hold
				-85.0:
					return A.spr_SMB_link_hold
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_hold
				1.0:
					return A.spr_SMB3_mario_big_hold
				2.0:
					return A.spr_SMB3_mario_fire_hold
				-39.0:
					return A.spr_SMB3_mario_raccoon_hold
				-29.0:
					return A.spr_SMB3_mario_frog_hold
				-46.0:
					return A.spr_SMB3_mario_hammer_hold
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_hold
				1.0:
					return A.spr_SMB3_luigi_big_hold
				2.0:
					return A.spr_SMB3_luigi_fire_hold
				-39.0:
					return A.spr_SMB3_luigi_raccoon_hold
				-29.0:
					return A.spr_SMB3_mario_frog_hold
				-46.0:
					return A.spr_SMB3_mario_hammer_hold
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_hold
				1.0:
					return A.spr_SMB3_toad_big_hold
				2.0:
					return A.spr_SMB3_toad_fire_hold
				-39.0:
					return A.spr_SMB3_toad_raccoon_hold
				-29.0:
					return A.spr_SMB3_toad_frog_hold
				-46.0:
					return A.spr_SMB3_toad_hammer_hold
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_hold
				1.0:
					return A.spr_SMB3_toadette_big_hold
				2.0:
					return A.spr_SMB3_toadette_fire_hold
				-39.0:
					return A.spr_SMB3_toadette_raccoon_hold
				-29.0:
					return A.spr_SMB3_toadette_frog_hold
				-46.0:
					return A.spr_SMB3_toadette_hammer_hold
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_hold
				1.0:
					return A.spr_mario_big_hold
				2.0:
					return A.spr_mario_fire_hold
				3.0:
					return A.spr_mario_big_hold
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_hold
				1.0:
					return A.spr_luigi_big_hold
				2.0:
					return A.spr_luigi_fire_hold
				3.0:
					return A.spr_luigi_big_hold
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_hold
				1.0:
					return A.spr_toad_big_hold
				2.0:
					return A.spr_toad_fire_hold
				3.0:
					return A.spr_toad_big_hold
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_hold
				1.0:
					return A.spr_toadette_big_hold
				2.0:
					return A.spr_toadette_fire_hold
				3.0:
					return A.spr_toadette_big_hold
				-82.0:
					return A.spr_toadette_pballon_idle
	elif G.apariencia == 4.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_mario_small_hold is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_mario_big_hold
				2.0:
					return null  # ORIG-BUG: spr_SMB2_mario_fire_hold is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_luigi_small_hold is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_luigi_big_hold
				2.0:
					return null  # ORIG-BUG: spr_SMB2_luigi_fire_hold is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_toad_small_hold is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_toad_big_hold
				2.0:
					return null  # ORIG-BUG: spr_SMB2_toad_fire_hold is not a resource in the original project (undefined variable in GML)
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return null  # ORIG-BUG: spr_SMB2_toadette_small_hold is not a resource in the original project (undefined variable in GML)
				1.0:
					return A.spr_SMB2_toadette_big_hold
				2.0:
					return null  # ORIG-BUG: spr_SMB2_toadette_fire_hold is not a resource in the original project (undefined variable in GML)
	return null  # GML 走到结尾返回 undefined
