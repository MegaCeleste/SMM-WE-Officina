extends RefCounted


# from scripts/scr_mushroom_platform1_sprites/scr_mushroom_platform1_sprites.gml
static func scr_mushroom_platform1_sprites(me: GMObject):
	if G.apariencia == 0.0:
		var _switch_value1 = G.bg_level
		var _switch_case2: int = -1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "snow"):
			_switch_case2 = 0
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underwater"):
			_switch_case2 = 1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "beach"):
			_switch_case2 = 2
		if _switch_case2 < 0 and GM.veq(_switch_value1, "airship"):
			_switch_case2 = 3
		if _switch_case2 < 0 and GM.veq(_switch_value1, "castle"):
			_switch_case2 = 4
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underground"):
			_switch_case2 = 5
		if _switch_case2 < 0 and GM.veq(_switch_value1, "ghost"):
			_switch_case2 = 6
		if _switch_case2 < 0 and GM.veq(_switch_value1, "mountain"):
			_switch_case2 = 7
		if _switch_case2 < 0:
			_switch_case2 = 8
		while true:
			if _switch_case2 >= 0 and _switch_case2 <= 0:
				if G.modo_noche == 1.0:
					return A.spr_SMB_mp1_snow_night
				else:
					return A.spr_SMB_mp1_snow
			if _switch_case2 >= 0 and _switch_case2 <= 1:
				return A.spr_SMB_mp1_underwater
			if _switch_case2 >= 0 and _switch_case2 <= 2:
				return A.spr_SMB_mp1_underwater
			if _switch_case2 >= 0 and _switch_case2 <= 3:
				return A.spr_SMB_mp1_airship
			if _switch_case2 >= 0 and _switch_case2 <= 4:
				return A.spr_SMB_mp1_dark
			if _switch_case2 >= 0 and _switch_case2 <= 5:
				return A.spr_SMB_mp1_dark
			if _switch_case2 >= 0 and _switch_case2 <= 6:
				return A.spr_SMB_mp1_dark
			if _switch_case2 >= 0 and _switch_case2 <= 7:
				if G.modo_noche == 1.0:
					return A.spr_SMB_mp1_dark
				else:
					return A.spr_SMB_mp1
			if _switch_case2 >= 0 and _switch_case2 <= 8:
				return A.spr_SMB_mp1
			break
	elif G.apariencia == 1.0:
		if G.modo_noche == 1.0:
			match G.bg_level:
				"snow":
					return A.spr_SMB3_mp1_snow_night
				"underwater":
					return A.spr_SMB3_mp1_underwater
				"beach":
					return A.spr_SMB3_mp1_underwater
				"airship":
					return A.spr_SMB3_mp1_airship
				"castle":
					return A.spr_SMB3_mp1_dark
				"mountain":
					return A.spr_SMB3_mp1_dark
				_:
					return A.spr_SMB3_mp1_night
		else:
			match G.bg_level:
				"snow":
					return A.spr_SMB3_mp1_snow
				"underwater":
					return A.spr_SMB3_mp1_underwater
				"beach":
					return A.spr_SMB3_mp1_underwater
				"airship":
					return A.spr_SMB3_mp1_airship
				"castle":
					return A.spr_SMB3_mp1_dark
				"underground":
					return A.spr_SMB3_mp1_night
				"ghost":
					return A.spr_SMB3_mp1_night
				"mountain":
					return A.spr_SMB3_mp1
				_:
					return A.spr_SMB3_mp1
	elif G.apariencia == 2.0:
		var _switch_value3 = G.bg_level
		var _switch_case4: int = -1
		if _switch_case4 < 0 and GM.veq(_switch_value3, "snow"):
			_switch_case4 = 0
		if _switch_case4 < 0 and GM.veq(_switch_value3, "underwater"):
			_switch_case4 = 1
		if _switch_case4 < 0 and GM.veq(_switch_value3, "beach"):
			_switch_case4 = 2
		if _switch_case4 < 0 and GM.veq(_switch_value3, "airship"):
			_switch_case4 = 3
		if _switch_case4 < 0 and GM.veq(_switch_value3, "mountain"):
			_switch_case4 = 4
		if _switch_case4 < 0:
			_switch_case4 = 5
		while true:
			if _switch_case4 >= 0 and _switch_case4 <= 0:
				if G.modo_noche == 1.0:
					return A.spr_mp1_snow_night
				else:
					return A.spr_mp1_snow
			if _switch_case4 >= 0 and _switch_case4 <= 1:
				return A.spr_mp1_underwater
			if _switch_case4 >= 0 and _switch_case4 <= 2:
				return A.spr_mp1_underwater
			if _switch_case4 >= 0 and _switch_case4 <= 3:
				return A.spr_mp1_airship
			if _switch_case4 >= 0 and _switch_case4 <= 4:
				return A.spr_mp1
			if _switch_case4 >= 0 and _switch_case4 <= 5:
				return A.spr_mp1
			break
	elif G.apariencia == 3.0:
		if G.modo_noche == 1.0:
			match G.bg_level:
				"snow":
					return A.spr_NSMBU_mp1_snow_night
				"underwater":
					return A.spr_NSMBU_mp1_underwater_night
				"beach":
					return A.spr_NSMBU_mp1_underwater_night
				"airship":
					return A.spr_NSMBU_mp1_airship_night
				"ghost":
					return A.spr_NSMBU_mp1_ghost
				"castle":
					return A.spr_NSMBU_mp1_castle
				"underground":
					return A.spr_NSMBU_mp1_underground
				"mountain":
					return A.spr_NSMBU_mp1_castle
				_:
					return A.spr_NSMBU_mp1_overworld_night
		else:
			match G.bg_level:
				"snow":
					return A.spr_NSMBU_mp1_snow
				"underwater":
					return A.spr_NSMBU_mp1_underwater
				"beach":
					return A.spr_NSMBU_mp1_underwater
				"airship":
					return A.spr_NSMBU_mp1_airship
				"ghost":
					return A.spr_NSMBU_mp1_ghost
				"desert":
					return A.spr_NSMBU_mp1_desert
				"castle":
					return A.spr_NSMBU_mp1_castle
				"underground":
					return A.spr_NSMBU_mp1_underground
				"mountain":
					return A.spr_NSMBU_mp1_overworld
				_:
					return A.spr_NSMBU_mp1_overworld
