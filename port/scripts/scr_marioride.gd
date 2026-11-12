# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_marioride/scr_marioride.gml
static func scr_marioride(me: GMObject):
	if G.jugador == 0.0:
		match G.powerup:
			0.0:
				return A.spr_mario_small_yoshi
			1.0:
				return A.spr_mario_big_yoshi
			2.0:
				return A.spr_mario_fire_yoshi
			3.0:
				return A.spr_mario_big_yoshi
			-82.0:
				return A.spr_mario_pballon_idle
	elif G.jugador == 1.0:
		match G.powerup:
			0.0:
				return A.spr_luigi_small_yoshi
			1.0:
				return A.spr_luigi_big_yoshi
			2.0:
				return A.spr_luigi_fire_yoshi
			3.0:
				return A.spr_luigi_big_yoshi
			-82.0:
				return A.spr_luigi_pballon_idle
	elif G.jugador == 2.0:
		match G.powerup:
			0.0:
				return A.spr_toad_small_yoshi
			1.0:
				return A.spr_toad_big_yoshi
			2.0:
				return A.spr_toad_fire_yoshi
			3.0:
				return A.spr_toad_big_yoshi
			-82.0:
				return A.spr_toad_pballon_idle
	elif G.jugador == 3.0:
		match G.powerup:
			0.0:
				return A.spr_toadette_small_yoshi
			1.0:
				return A.spr_toadette_big_yoshi
			2.0:
				return A.spr_toadette_fire_yoshi
			3.0:
				return A.spr_toadette_big_yoshi
			-82.0:
				return A.spr_toadette_pballon_idle
