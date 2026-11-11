# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioshoot/scr_marioshoot.gml
static func scr_marioshoot(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		match G.jugador:
			0.0:
				if G.powerup == -50.0:
					return A.spr_SMB_mario_superball_shoot
				else:
					return A.spr_SMB_mario_fire_shoot
			1.0:
				if G.powerup == -50.0:
					return A.spr_SMB_luigi_superball_shoot
				else:
					return A.spr_SMB_luigi_fire_shoot
			2.0:
				if G.powerup == -50.0:
					return A.spr_SMB_toad_superball_shoot
				else:
					return A.spr_SMB_toad_fire_shoot
			3.0:
				if G.powerup == -50.0:
					return A.spr_SMB_toadette_superball_shoot
				else:
					return A.spr_SMB_toadette_fire_shoot
	elif G.apariencia == 1.0:
		match G.jugador:
			0.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_mario_hammer_shoot
				else:
					return A.spr_SMB3_mario_fire_shoot
			1.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_mario_hammer_shoot
				else:
					return A.spr_SMB3_luigi_fire_shoot
			2.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_toad_hammer_shoot
				else:
					return A.spr_SMB3_toad_fire_shoot
			3.0:
				if G.powerup == -46.0:
					return A.spr_SMB3_toadette_hammer_shoot
				else:
					return A.spr_SMB3_toadette_fire_shoot
	elif G.apariencia == 2.0:
		match G.jugador:
			0.0:
				return A.spr_mario_fire_shoot
			1.0:
				return A.spr_luigi_fire_shoot
			2.0:
				return A.spr_toad_fire_shoot
			3.0:
				return A.spr_toadette_fire_shoot
	elif G.apariencia == 3.0:
		if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).isswim == 1.0:
			if G.powerup == -38.0:
				return A.spr_NSMBU_mario_penguin_swim_shoot
			else:
				return A.spr_NSMBU_mario_fire_swim_shoot
		elif G.powerup == -38.0:
			return A.spr_NSMBU_mario_penguin_shoot
		else:
			return A.spr_NSMBU_mario_fire_shoot
	return null  # GML 走到结尾返回 undefined
