# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariojumpstar/scr_mariojumpstar.gml
static func scr_mariojumpstar(me: GMObject) -> Variant:
	if G.jugador == 0.0:
		match G.powerup:
			1.0:
				return A.spr_SMB3_mario_big_jump_star
			2.0:
				return A.spr_SMB3_mario_fire_jump_star
			-39.0:
				return A.spr_SMB3_mario_raccoon_jump_star
			-46.0:
				return A.spr_SMB3_mario_hammer_jump_star
	elif G.jugador == 1.0:
		match G.powerup:
			1.0:
				return A.spr_SMB3_luigi_big_jump_star
			2.0:
				return A.spr_SMB3_luigi_fire_jump_star
			-39.0:
				return A.spr_SMB3_luigi_raccoon_jump_star
			-46.0:
				return A.spr_SMB3_mario_hammer_jump_star
	elif G.jugador == 2.0:
		match G.powerup:
			1.0:
				return A.spr_SMB3_toad_big_jump_star
			2.0:
				return A.spr_SMB3_toad_fire_jump_star
			-39.0:
				return A.spr_SMB3_toad_raccoon_jump_star
			-46.0:
				return A.spr_SMB3_toad_hammer_jump_star
	elif G.jugador == 3.0:
		match G.powerup:
			1.0:
				return A.spr_SMB3_toadette_big_jump_star
			2.0:
				return A.spr_SMB3_toadette_fire_jump_star
			-39.0:
				return A.spr_SMB3_toadette_raccoon_jump_star
			-46.0:
				return A.spr_SMB3_toadette_hammer_jump_star
	return null  # GML 走到结尾返回 undefined
