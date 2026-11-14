extends RefCounted


# from scripts/scr_semisolid_platform2_sprites/scr_semisolid_platform2_sprites.gml
static func scr_semisolid_platform2_sprites(me: GMObject):
	if G.apariencia == 0.0:
		var _switch_value1 = G.bg_level
		var _switch_case2: int = -1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "ground"):
			_switch_case2 = 0
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underground"):
			_switch_case2 = 1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underwater"):
			_switch_case2 = 2
		if _switch_case2 < 0 and GM.veq(_switch_value1, "desert"):
			_switch_case2 = 3
		if _switch_case2 < 0 and GM.veq(_switch_value1, "snow"):
			_switch_case2 = 4
		if _switch_case2 < 0 and GM.veq(_switch_value1, "sky"):
			_switch_case2 = 5
		if _switch_case2 < 0 and GM.veq(_switch_value1, "forest"):
			_switch_case2 = 6
		if _switch_case2 < 0 and GM.veq(_switch_value1, "ghost"):
			_switch_case2 = 7
		if _switch_case2 < 0 and GM.veq(_switch_value1, "airship"):
			_switch_case2 = 8
		if _switch_case2 < 0 and GM.veq(_switch_value1, "castle"):
			_switch_case2 = 9
		if _switch_case2 < 0 and GM.veq(_switch_value1, "fall"):
			_switch_case2 = 10
		if _switch_case2 < 0 and GM.veq(_switch_value1, "beach"):
			_switch_case2 = 11
		if _switch_case2 < 0 and GM.veq(_switch_value1, "mountain"):
			_switch_case2 = 12
		while true:
			if _switch_case2 >= 0 and _switch_case2 <= 0:
				return A.spr_SMB_ssp2_overworld
			if _switch_case2 >= 0 and _switch_case2 <= 1:
				return A.spr_SMB_ssp2_underground
			if _switch_case2 >= 0 and _switch_case2 <= 2:
				if G.modo_noche == 1.0:
					return A.spr_SMB_ssp2_underwater_night
				else:
					return A.spr_SMB_ssp2_underwater
			if _switch_case2 >= 0 and _switch_case2 <= 3:
				return A.spr_SMB_ssp2_desert
			if _switch_case2 >= 0 and _switch_case2 <= 4:
				if G.modo_noche == 1.0:
					return A.spr_SMB_ssp2_snow_night
				else:
					return A.spr_SMB_ssp2_snow
			if _switch_case2 >= 0 and _switch_case2 <= 5:
				return A.spr_SMB_ssp2_sky
			if _switch_case2 >= 0 and _switch_case2 <= 6:
				return A.spr_SMB_ssp2_forest
			if _switch_case2 >= 0 and _switch_case2 <= 7:
				return A.spr_SMB_ssp2_ghost
			if _switch_case2 >= 0 and _switch_case2 <= 8:
				if G.modo_noche == 1.0:
					return A.spr_SMB_ssp2_airship_night
				else:
					return A.spr_SMB_ssp2_airship
			if _switch_case2 >= 0 and _switch_case2 <= 9:
				return A.spr_SMB_ssp2_castle
			if _switch_case2 >= 0 and _switch_case2 <= 10:
				return A.spr_SMB_ssp2_fall
			if _switch_case2 >= 0 and _switch_case2 <= 11:
				return A.spr_SMB_ssp2_beach
			if _switch_case2 >= 0 and _switch_case2 <= 12:
				if G.modo_noche == 1.0:
					return A.spr_SMB_ssp2_volcano
				else:
					return A.spr_SMB_ssp2_mountain
				break
			break
	elif G.apariencia == 1.0:
		var _switch_value3 = G.bg_level
		var _switch_case4: int = -1
		if _switch_case4 < 0 and GM.veq(_switch_value3, "ground"):
			_switch_case4 = 0
		if _switch_case4 < 0 and GM.veq(_switch_value3, "underground"):
			_switch_case4 = 1
		if _switch_case4 < 0 and GM.veq(_switch_value3, "underwater"):
			_switch_case4 = 2
		if _switch_case4 < 0 and GM.veq(_switch_value3, "desert"):
			_switch_case4 = 3
		if _switch_case4 < 0 and GM.veq(_switch_value3, "snow"):
			_switch_case4 = 4
		if _switch_case4 < 0 and GM.veq(_switch_value3, "sky"):
			_switch_case4 = 5
		if _switch_case4 < 0 and GM.veq(_switch_value3, "forest"):
			_switch_case4 = 6
		if _switch_case4 < 0 and GM.veq(_switch_value3, "ghost"):
			_switch_case4 = 7
		if _switch_case4 < 0 and GM.veq(_switch_value3, "airship"):
			_switch_case4 = 8
		if _switch_case4 < 0 and GM.veq(_switch_value3, "castle"):
			_switch_case4 = 9
		if _switch_case4 < 0 and GM.veq(_switch_value3, "fall"):
			_switch_case4 = 10
		if _switch_case4 < 0 and GM.veq(_switch_value3, "beach"):
			_switch_case4 = 11
		if _switch_case4 < 0 and GM.veq(_switch_value3, "mountain"):
			_switch_case4 = 12
		while true:
			if _switch_case4 >= 0 and _switch_case4 <= 0:
				return A.spr_SMB3_ssp2_overworld
			if _switch_case4 >= 0 and _switch_case4 <= 1:
				return A.spr_SMB3_ssp2_underground
			if _switch_case4 >= 0 and _switch_case4 <= 2:
				return A.spr_SMB3_ssp2_underwater
			if _switch_case4 >= 0 and _switch_case4 <= 3:
				return A.spr_SMB3_ssp2_desert
			if _switch_case4 >= 0 and _switch_case4 <= 4:
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ssp2_snow_night
				else:
					return A.spr_SMB3_ssp2_snow
			if _switch_case4 >= 0 and _switch_case4 <= 5:
				return A.spr_SMB3_ssp2_sky
			if _switch_case4 >= 0 and _switch_case4 <= 6:
				return A.spr_SMB3_ssp2_forest
			if _switch_case4 >= 0 and _switch_case4 <= 7:
				return A.spr_SMB3_ssp2_ghost
			if _switch_case4 >= 0 and _switch_case4 <= 8:
				return A.spr_SMB3_ssp2_airship
			if _switch_case4 >= 0 and _switch_case4 <= 9:
				return A.spr_SMB3_ssp2_castle
			if _switch_case4 >= 0 and _switch_case4 <= 10:
				return A.spr_SMB3_ssp2_autumn
			if _switch_case4 >= 0 and _switch_case4 <= 11:
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ssp2_beach_night
				else:
					return A.spr_SMB3_ssp2_beach
				break
			if _switch_case4 >= 0 and _switch_case4 <= 12:
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ssp2_volcano
				else:
					return A.spr_SMB3_ssp2_mountain
				break
			break
	elif G.apariencia == 2.0:
		var _switch_value5 = G.bg_level
		var _switch_case6: int = -1
		if _switch_case6 < 0 and GM.veq(_switch_value5, "ground"):
			_switch_case6 = 0
		if _switch_case6 < 0 and GM.veq(_switch_value5, "underground"):
			_switch_case6 = 1
		if _switch_case6 < 0 and GM.veq(_switch_value5, "underwater"):
			_switch_case6 = 2
		if _switch_case6 < 0 and GM.veq(_switch_value5, "desert"):
			_switch_case6 = 3
		if _switch_case6 < 0 and GM.veq(_switch_value5, "snow"):
			_switch_case6 = 4
		if _switch_case6 < 0 and GM.veq(_switch_value5, "sky"):
			_switch_case6 = 5
		if _switch_case6 < 0 and GM.veq(_switch_value5, "forest"):
			_switch_case6 = 6
		if _switch_case6 < 0 and GM.veq(_switch_value5, "ghost"):
			_switch_case6 = 7
		if _switch_case6 < 0 and GM.veq(_switch_value5, "airship"):
			_switch_case6 = 8
		if _switch_case6 < 0 and GM.veq(_switch_value5, "castle"):
			_switch_case6 = 9
		if _switch_case6 < 0 and GM.veq(_switch_value5, "fall"):
			_switch_case6 = 10
		if _switch_case6 < 0 and GM.veq(_switch_value5, "beach"):
			_switch_case6 = 11
		if _switch_case6 < 0 and GM.veq(_switch_value5, "mountain"):
			_switch_case6 = 12
		while true:
			if _switch_case6 >= 0 and _switch_case6 <= 0:
				return A.spr_ssp2_overworld
			if _switch_case6 >= 0 and _switch_case6 <= 1:
				return A.spr_ssp2_underground
			if _switch_case6 >= 0 and _switch_case6 <= 2:
				return A.spr_ssp2_underwater
			if _switch_case6 >= 0 and _switch_case6 <= 3:
				return A.spr_ssp2_desert
			if _switch_case6 >= 0 and _switch_case6 <= 4:
				if G.modo_noche == 1.0:
					return A.spr_ssp2_snow_night
				else:
					return A.spr_ssp2_snow
			if _switch_case6 >= 0 and _switch_case6 <= 5:
				return A.spr_ssp2_sky
			if _switch_case6 >= 0 and _switch_case6 <= 6:
				return A.spr_ssp2_forest
			if _switch_case6 >= 0 and _switch_case6 <= 7:
				return A.spr_ssp2_ghost
			if _switch_case6 >= 0 and _switch_case6 <= 8:
				return A.spr_ssp2_airship
			if _switch_case6 >= 0 and _switch_case6 <= 9:
				return A.spr_ssp2_castle
			if _switch_case6 >= 0 and _switch_case6 <= 10:
				return A.spr_ssp2_autumn
			if _switch_case6 >= 0 and _switch_case6 <= 11:
				return A.spr_ssp2_beach
			if _switch_case6 >= 0 and _switch_case6 <= 12:
				if G.modo_noche == 1.0:
					return A.spr_ssp2_volcano
				else:
					return A.spr_ssp2_mountain
				break
			break
	elif G.apariencia == 3.0:
		var _switch_value7 = G.bg_level
		var _switch_case8: int = -1
		if _switch_case8 < 0 and GM.veq(_switch_value7, "ground"):
			_switch_case8 = 0
		if _switch_case8 < 0 and GM.veq(_switch_value7, "underground"):
			_switch_case8 = 1
		if _switch_case8 < 0 and GM.veq(_switch_value7, "underwater"):
			_switch_case8 = 2
		if _switch_case8 < 0 and GM.veq(_switch_value7, "desert"):
			_switch_case8 = 3
		if _switch_case8 < 0 and GM.veq(_switch_value7, "snow"):
			_switch_case8 = 4
		if _switch_case8 < 0 and GM.veq(_switch_value7, "sky"):
			_switch_case8 = 5
		if _switch_case8 < 0 and GM.veq(_switch_value7, "forest"):
			_switch_case8 = 6
		if _switch_case8 < 0 and GM.veq(_switch_value7, "ghost"):
			_switch_case8 = 7
		if _switch_case8 < 0 and GM.veq(_switch_value7, "airship"):
			_switch_case8 = 8
		if _switch_case8 < 0 and GM.veq(_switch_value7, "castle"):
			_switch_case8 = 9
		if _switch_case8 < 0 and GM.veq(_switch_value7, "fall"):
			_switch_case8 = 10
		if _switch_case8 < 0 and GM.veq(_switch_value7, "beach"):
			_switch_case8 = 11
		if _switch_case8 < 0 and GM.veq(_switch_value7, "mountain"):
			_switch_case8 = 12
		while true:
			if _switch_case8 >= 0 and _switch_case8 <= 0:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_overworld_night
				else:
					return A.spr_NSMBU_ssp2_overworld
			if _switch_case8 >= 0 and _switch_case8 <= 1:
				return A.spr_NSMBU_ssp2_underground
			if _switch_case8 >= 0 and _switch_case8 <= 2:
				return A.spr_NSMBU_ssp2_underwater
			if _switch_case8 >= 0 and _switch_case8 <= 3:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_desert_night
				else:
					return A.spr_NSMBU_ssp2_desert
			if _switch_case8 >= 0 and _switch_case8 <= 4:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_snow_night
				else:
					return A.spr_NSMBU_ssp2_snow
			if _switch_case8 >= 0 and _switch_case8 <= 5:
				return A.spr_NSMBU_ssp2_sky
			if _switch_case8 >= 0 and _switch_case8 <= 6:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_forest_night
				else:
					return A.spr_NSMBU_ssp2_forest
			if _switch_case8 >= 0 and _switch_case8 <= 7:
				return A.spr_NSMBU_ssp2_ghost
			if _switch_case8 >= 0 and _switch_case8 <= 8:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_airship_night
				else:
					return A.spr_NSMBU_ssp2_airship
			if _switch_case8 >= 0 and _switch_case8 <= 9:
				return A.spr_NSMBU_ssp2_castle
			if _switch_case8 >= 0 and _switch_case8 <= 10:
				return A.spr_NSMBU_ssp2_autumn
			if _switch_case8 >= 0 and _switch_case8 <= 11:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_beach_night
				else:
					return A.spr_NSMBU_ssp2_beach
			if _switch_case8 >= 0 and _switch_case8 <= 12:
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ssp2_volcano
				else:
					return A.spr_NSMBU_ssp2_mountain
				break
			break
