# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_crouch_idle/scr_NSMBU_crouch_idle.gml
static func scr_NSMBU_crouch_idle(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_crouch_idle
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_crouch_idle
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_crouch_idle
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_crouch_idle
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_crouch_idle
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_crouch_idle
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_crouch_idle;
	# 	        case cs_big: return spr_NSMBU_mario_big_crouch_idle;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_crouch_idle;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_crouch_idle;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_crouch_idle;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_crouch_idle; }
	# 	}
