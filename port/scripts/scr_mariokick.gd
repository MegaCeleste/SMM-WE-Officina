# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariokick/scr_mariokick.gml
static func scr_mariokick(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		if G.jugador == 0.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_mario_big_kick
				-85.0:
					return A.spr_SMB_link_throw
		elif G.jugador == 1.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_luigi_big_kick
				-85.0:
					return A.spr_SMB_link_throw
		elif G.jugador == 2.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_toad_big_kick
				-85.0:
					return A.spr_SMB_link_throw
		elif G.jugador == 3.0:
			match G.powerup:
				-80.0:
					return A.spr_SMB2_toadette_big_kick
				-85.0:
					return A.spr_SMB_link_throw
	elif G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_kick
				1.0:
					return A.spr_SMB3_mario_big_kick
				2.0:
					return A.spr_SMB3_mario_fire_kick
				-39.0:
					return A.spr_SMB3_mario_raccoon_kick
				-29.0:
					return A.spr_SMB3_mario_frog_kick
				-46.0:
					return A.spr_SMB3_mario_hammer_kick
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_kick
				1.0:
					return A.spr_SMB3_luigi_big_kick
				2.0:
					return A.spr_SMB3_luigi_fire_kick
				-39.0:
					return A.spr_SMB3_luigi_raccoon_kick
				-29.0:
					return A.spr_SMB3_mario_frog_kick
				-46.0:
					return A.spr_SMB3_mario_hammer_kick
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_kick
				1.0:
					return A.spr_SMB3_toad_big_kick
				2.0:
					return A.spr_SMB3_toad_fire_kick
				-39.0:
					return A.spr_SMB3_toad_raccoon_kick
				-29.0:
					return A.spr_SMB3_toad_frog_kick
				-46.0:
					return A.spr_SMB3_toad_hammer_kick
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_kick
				1.0:
					return A.spr_SMB3_toadette_big_kick
				2.0:
					return A.spr_SMB3_toadette_fire_kick
				-39.0:
					return A.spr_SMB3_toadette_raccoon_kick
				-29.0:
					return A.spr_SMB3_toadette_frog_kick
				-46.0:
					return A.spr_SMB3_toadette_hammer_kick
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_kick
				1.0:
					return A.spr_mario_big_kick
				2.0:
					return A.spr_mario_fire_kick
				3.0:
					return A.spr_mario_big_kick
				-82.0:
					return A.spr_mario_pballon_idle
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_kick
				1.0:
					return A.spr_luigi_big_kick
				2.0:
					return A.spr_luigi_fire_kick
				3.0:
					return A.spr_luigi_big_kick
				-82.0:
					return A.spr_luigi_pballon_idle
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_kick
				1.0:
					return A.spr_toad_big_kick
				2.0:
					return A.spr_toad_fire_kick
				3.0:
					return A.spr_toad_big_kick
				-82.0:
					return A.spr_toad_pballon_idle
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_kick
				1.0:
					return A.spr_toadette_big_kick
				2.0:
					return A.spr_toadette_fire_kick
				3.0:
					return A.spr_toadette_big_kick
				-82.0:
					return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
