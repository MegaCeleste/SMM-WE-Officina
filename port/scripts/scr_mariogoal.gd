# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mariogoal/scr_mariogoal.gml
static func scr_mariogoal(me: GMObject):
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
	elif G.jugador == 0.0:
		match G.powerup:
			0.0:
				return A.spr_mario_small_goal
			1.0:
				return A.spr_mario_big_goal
			2.0:
				return A.spr_mario_fire_goal
			3.0:
				return A.spr_mario_big_goal
			-82.0:
				return A.spr_mario_pballon_idle
	elif G.jugador == 1.0:
		match G.powerup:
			0.0:
				return A.spr_luigi_small_goal
			1.0:
				return A.spr_luigi_big_goal
			2.0:
				return A.spr_luigi_fire_goal
			3.0:
				return A.spr_luigi_big_goal
			-82.0:
				return A.spr_luigi_pballon_idle
	elif G.jugador == 2.0:
		match G.powerup:
			0.0:
				return A.spr_toad_small_goal
			1.0:
				return A.spr_toad_big_goal
			2.0:
				return A.spr_toad_fire_goal
			3.0:
				return A.spr_toad_big_goal
			-82.0:
				return A.spr_toad_pballon_idle
	elif G.jugador == 3.0:
		match G.powerup:
			0.0:
				return A.spr_toadette_small_goal
			1.0:
				return A.spr_toadette_big_goal
			2.0:
				return A.spr_toadette_fire_goal
			3.0:
				return A.spr_toadette_big_goal
			-82.0:
				return A.spr_toadette_pballon_idle
