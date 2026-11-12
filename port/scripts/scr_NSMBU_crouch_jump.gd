# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_crouch_jump/scr_NSMBU_crouch_jump.gml
static func scr_NSMBU_crouch_jump(me: GMObject):
	# global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_crouch_jump
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_crouch_jump
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_crouch_jump
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_crouch_jump
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_crouch_jump
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_crouch_jump
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_crouch_jump;
	# 	        case cs_big: return spr_NSMBU_mario_big_crouch_jump;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_crouch_jump;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_crouch_jump;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_crouch_jump;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_crouch_jump; }
	# 	}
