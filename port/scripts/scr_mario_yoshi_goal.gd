# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_yoshi_goal/scr_mario_yoshi_goal.gml
static func scr_mario_yoshi_goal(me: GMObject):
	if G.jugador == 0.0:
		match G.powerup:
			0.0:
				return A.spr_mario_small_yoshi_goal
			1.0:
				return A.spr_mario_big_yoshi_goal
			2.0:
				return A.spr_mario_fire_yoshi_goal
			3.0:
				return A.spr_mario_big_yoshi_goal
	elif G.jugador == 1.0:
		match G.powerup:
			0.0:
				return A.spr_luigi_small_yoshi_goal
			1.0:
				return A.spr_luigi_big_yoshi_goal
			2.0:
				return A.spr_luigi_fire_yoshi_goal
			3.0:
				return A.spr_luigi_big_yoshi_goal
	elif G.jugador == 2.0:
		match G.powerup:
			0.0:
				return A.spr_toad_small_yoshi_goal
			1.0:
				return A.spr_toad_big_yoshi_goal
			2.0:
				return A.spr_toad_fire_yoshi_goal
			3.0:
				return A.spr_toad_big_yoshi_goal
	elif G.jugador == 3.0:
		match G.powerup:
			0.0:
				return A.spr_toadette_small_yoshi_goal
			1.0:
				return A.spr_toadette_big_yoshi_goal
			2.0:
				return A.spr_toadette_fire_yoshi_goal
			3.0:
				return A.spr_toadette_big_yoshi_goal
