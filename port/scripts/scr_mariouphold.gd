# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mariouphold/scr_mariouphold.gml
static func scr_mariouphold(me: GMObject) -> Variant:
	if G.jugador == 0.0:
		match G.powerup:
			0.0:
				return A.spr_mario_small_up_hold
			1.0:
				return A.spr_mario_big_up_hold
			2.0:
				return A.spr_mario_fire_up_hold
			3.0:
				return A.spr_mario_big_up_hold
			-82.0:
				return A.spr_mario_pballon_idle
	elif G.jugador == 1.0:
		match G.powerup:
			0.0:
				return A.spr_luigi_small_up_hold
			1.0:
				return A.spr_luigi_big_up_hold
			2.0:
				return A.spr_luigi_fire_up_hold
			3.0:
				return A.spr_luigi_big_up_hold
			-82.0:
				return A.spr_luigi_pballon_idle
	elif G.jugador == 2.0:
		match G.powerup:
			0.0:
				return A.spr_toad_small_hold_up
			1.0:
				return A.spr_toad_big_up_hold
			2.0:
				return A.spr_toad_fire_up_hold
			3.0:
				return A.spr_toad_big_up_hold
			-82.0:
				return A.spr_toad_pballon_idle
	elif G.jugador == 3.0:
		match G.powerup:
			0.0:
				return A.spr_toadette_small_hold_up
			1.0:
				return A.spr_toadette_big_up_hold
			2.0:
				return A.spr_toadette_fire_up_hold
			3.0:
				return A.spr_toadette_big_up_hold
			-82.0:
				return A.spr_toadette_pballon_idle
	return null  # GML 走到结尾返回 undefined
