# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_jump2/scr_NSMBU_jump2.gml
static func scr_NSMBU_jump2(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_jump2
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_jump2
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_jump2
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_jump2
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_jump2
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_jump2
	# }
	# 	else {
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_jump2;
	# 	        case cs_big: return spr_NSMBU_mario_big_jump2;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_jump2;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_jump2;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_jump2;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_jump2; }
	# 	}
