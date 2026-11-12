# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_marioshoot_drybones/scr_marioshoot_drybones.gml
static func scr_marioshoot_drybones(me: GMObject):
	if G.apariencia == 0.0:
		match G.jugador:
			0.0:
				if G.powerup == -50.0:
					return A.spr_SMB_mario_superball_drybones_shoot
				else:
					return A.spr_SMB_mario_fire_drybones_shoot
			1.0:
				if G.powerup == -50.0:
					return A.spr_SMB_luigi_superball_drybones_shoot
				else:
					return A.spr_SMB_luigi_fire_drybones_shoot
			2.0:
				if G.powerup == -50.0:
					return A.spr_SMB_toad_superball_drybones_shoot
				else:
					return A.spr_SMB_toad_fire_drybones_shoot
			3.0:
				if G.powerup == -50.0:
					return A.spr_SMB_toadette_superball_drybones_shoot
				else:
					return A.spr_SMB_toadette_fire_drybones_shoot
	elif G.apariencia == 1.0:
		match G.jugador:
			0.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_mario_hammer_drybones_shoot
				else:
					return A.spr_SMB3_mario_fire_drybones_shoot
			1.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_mario_hammer_drybones_shoot
				else:
					return A.spr_SMB3_luigi_fire_drybones_shoot
			2.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_toad_hammer_drybones_shoot
				else:
					return A.spr_SMB3_toad_fire_drybones_shoot
			3.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_toad_hammer_drybones_shoot
				else:
					return A.spr_SMB3_toadette_fire_drybones_shoot
	elif G.apariencia == 2.0:
		match G.jugador:
			0.0:
				return A.spr_mario_fire_drybones_shoot
			1.0:
				return A.spr_luigi_fire_drybones_shoot
			2.0:
				return A.spr_toad_fire_drybones_shoot
			3.0:
				return A.spr_toadette_fire_drybones_shoot
	elif G.apariencia == 3.0:
		if G.powerup == -38.0:
			return A.spr_NSMBU_mario_penguin_drybones
		else:
			return A.spr_NSMBU_mario_fire_drybones
