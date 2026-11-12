# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_acrouch/scr_NSMBU_acrouch.gml
static func scr_NSMBU_acrouch(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_acrouch
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_acrouch
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_acrouch
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_acrouch
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_acrouch
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_acrouch
	# }
	# 	else {
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_acrouch;
	# 	        case cs_big: return spr_NSMBU_mario_big_acrouch;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_acrouch;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_acrouch;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_acrouch;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_acrouch; }
	# 	}
	#
