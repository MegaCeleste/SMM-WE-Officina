# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_marioup/scr_marioup.gml
static func scr_marioup(me: GMObject) -> Variant:
	if G.jugador == 0.0:
		match G.powerup:
			0.0:
				return A.spr_mario_small_up
			1.0:
				return A.spr_mario_big_up
			2.0:
				return A.spr_mario_fire_up
			3.0:
				return A.spr_mario_big_up
			-82.0:
				return A.spr_mario_pballon_idle
	elif G.jugador == 1.0:
		match G.powerup:
			0.0:
				return A.spr_luigi_small_up
			1.0:
				return A.spr_luigi_big_up
			2.0:
				return A.spr_luigi_fire_up
			3.0:
				return A.spr_luigi_big_up
			-82.0:
				return A.spr_luigi_pballon_idle
	elif G.jugador == 2.0:
		match G.powerup:
			0.0:
				return A.spr_toad_small_up
			1.0:
				return A.spr_toad_big_up
			2.0:
				return A.spr_toad_fire_up
			3.0:
				return A.spr_toad_big_up
			-82.0:
				return A.spr_toad_pballon_idle
	elif G.jugador == 3.0:
		match G.powerup:
			0.0:
				return A.spr_toadette_small_up
			1.0:
				return A.spr_toadette_big_up
			2.0:
				return A.spr_toadette_fire_up
			3.0:
				return A.spr_toadette_big_up
			-82.0:
				return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
