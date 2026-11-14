extends RefCounted


# from scripts/scr_mushroom_platform3_sprites/scr_mushroom_platform3_sprites.gml
static func scr_mushroom_platform3_sprites(me: GMObject):
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
		if _switch_case2 < 0:
			_switch_case2 = 7
		while true:
			if _switch_case2 >= 0 and _switch_case2 <= 0:
				if G.modo_noche == 1.0:
					return A.spr_SMB_mp3_snow_night
				else:
					return A.spr_SMB_mp3_snow
			if _switch_case2 >= 0 and _switch_case2 <= 1:
				return A.spr_SMB_mp3_underwater
			if _switch_case2 >= 0 and _switch_case2 <= 2:
				return A.spr_SMB_mp3_underwater
			if _switch_case2 >= 0 and _switch_case2 <= 3:
				return A.spr_SMB_mp3_airship
			if _switch_case2 >= 0 and _switch_case2 <= 4:
				return A.spr_SMB_mp3_dark
			if _switch_case2 >= 0 and _switch_case2 <= 5:
				return A.spr_SMB_mp3_dark
			if _switch_case2 >= 0 and _switch_case2 <= 6:
				return A.spr_SMB_mp3_dark
			if _switch_case2 >= 0 and _switch_case2 <= 7:
				return A.spr_SMB_mp3
			break
	elif G.apariencia == 1.0:
		if G.modo_noche == 1.0:
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
			if _switch_case4 < 0 and GM.veq(_switch_value3, "castle"):
				_switch_case4 = 4
			if _switch_case4 < 0:
				_switch_case4 = 5
			while true:
				if _switch_case4 >= 0 and _switch_case4 <= 0:
					if G.modo_noche == 1.0:
						return A.spr_SMB3_mp3_snow_night
					else:
						return A.spr_SMB3_mp3_snow
				if _switch_case4 >= 0 and _switch_case4 <= 1:
					return A.spr_SMB3_mp3_underwater
				if _switch_case4 >= 0 and _switch_case4 <= 2:
					return A.spr_SMB3_mp3_underwater
				if _switch_case4 >= 0 and _switch_case4 <= 3:
					return A.spr_SMB3_mp3_airship
				if _switch_case4 >= 0 and _switch_case4 <= 4:
					return A.spr_SMB3_mp3_dark
				if _switch_case4 >= 0 and _switch_case4 <= 5:
					return A.spr_SMB3_mp3_night
				break
		else:
			var _switch_value5 = G.bg_level
			var _switch_case6: int = -1
			if _switch_case6 < 0 and GM.veq(_switch_value5, "snow"):
				_switch_case6 = 0
			if _switch_case6 < 0 and GM.veq(_switch_value5, "underwater"):
				_switch_case6 = 1
			if _switch_case6 < 0 and GM.veq(_switch_value5, "beach"):
				_switch_case6 = 2
			if _switch_case6 < 0 and GM.veq(_switch_value5, "airship"):
				_switch_case6 = 3
			if _switch_case6 < 0 and GM.veq(_switch_value5, "castle"):
				_switch_case6 = 4
			if _switch_case6 < 0 and GM.veq(_switch_value5, "underground"):
				_switch_case6 = 5
			if _switch_case6 < 0 and GM.veq(_switch_value5, "ghost"):
				_switch_case6 = 6
			if _switch_case6 < 0:
				_switch_case6 = 7
			while true:
				if _switch_case6 >= 0 and _switch_case6 <= 0:
					if G.modo_noche == 1.0:
						return A.spr_SMB3_mp3_snow_night
					else:
						return A.spr_SMB3_mp3_snow
				if _switch_case6 >= 0 and _switch_case6 <= 1:
					return A.spr_SMB3_mp3_underwater
				if _switch_case6 >= 0 and _switch_case6 <= 2:
					return A.spr_SMB3_mp3_underwater
				if _switch_case6 >= 0 and _switch_case6 <= 3:
					return A.spr_SMB3_mp3_airship
				if _switch_case6 >= 0 and _switch_case6 <= 4:
					return A.spr_SMB3_mp3_dark
				if _switch_case6 >= 0 and _switch_case6 <= 5:
					return A.spr_SMB3_mp3_night
				if _switch_case6 >= 0 and _switch_case6 <= 6:
					return A.spr_SMB3_mp3_night
				if _switch_case6 >= 0 and _switch_case6 <= 7:
					return A.spr_SMB3_mp3
				break
	elif G.apariencia == 2.0:
		var _switch_value7 = G.bg_level
		var _switch_case8: int = -1
		if _switch_case8 < 0 and GM.veq(_switch_value7, "snow"):
			_switch_case8 = 0
		if _switch_case8 < 0 and GM.veq(_switch_value7, "underwater"):
			_switch_case8 = 1
		if _switch_case8 < 0 and GM.veq(_switch_value7, "beach"):
			_switch_case8 = 2
		if _switch_case8 < 0 and GM.veq(_switch_value7, "airship"):
			_switch_case8 = 3
		if _switch_case8 < 0:
			_switch_case8 = 4
		while true:
			if _switch_case8 >= 0 and _switch_case8 <= 0:
				if G.modo_noche == 1.0:
					return A.spr_mp3_snow_night
				else:
					return A.spr_mp3_snow
			if _switch_case8 >= 0 and _switch_case8 <= 1:
				return A.spr_mp3_underwater
			if _switch_case8 >= 0 and _switch_case8 <= 2:
				return A.spr_mp3_underwater
			if _switch_case8 >= 0 and _switch_case8 <= 3:
				return A.spr_mp3_airship
			if _switch_case8 >= 0 and _switch_case8 <= 4:
				return A.spr_mp3
			break
	elif G.apariencia == 2.0:
		var _switch_value9 = G.bg_level
		var _switch_case10: int = -1
		if _switch_case10 < 0 and GM.veq(_switch_value9, "snow"):
			_switch_case10 = 0
		if _switch_case10 < 0 and GM.veq(_switch_value9, "underwater"):
			_switch_case10 = 1
		if _switch_case10 < 0 and GM.veq(_switch_value9, "beach"):
			_switch_case10 = 2
		if _switch_case10 < 0 and GM.veq(_switch_value9, "airship"):
			_switch_case10 = 3
		if _switch_case10 < 0:
			_switch_case10 = 4
		while true:
			if _switch_case10 >= 0 and _switch_case10 <= 0:
				if G.modo_noche == 1.0:
					return A.spr_mp1_snow_night
				else:
					return A.spr_mp1_snow
			if _switch_case10 >= 0 and _switch_case10 <= 1:
				return A.spr_mp1_underwater
			if _switch_case10 >= 0 and _switch_case10 <= 2:
				return A.spr_mp1_underwater
			if _switch_case10 >= 0 and _switch_case10 <= 3:
				return A.spr_mp1_airship
			if _switch_case10 >= 0 and _switch_case10 <= 4:
				return A.spr_mp1
			break
	elif G.apariencia == 3.0:
		if G.modo_noche == 1.0:
			match G.bg_level:
				"snow":
					return A.spr_NSMBU_mp3_snow_night
				"underwater":
					return A.spr_NSMBU_mp3_underwater_night
				"beach":
					return A.spr_NSMBU_mp3_underwater_night
				"airship":
					return A.spr_NSMBU_mp3_airship_night
				"ghost":
					return A.spr_NSMBU_mp3_ghost
				"castle":
					return A.spr_NSMBU_mp3_castle
				"underground":
					return A.spr_NSMBU_mp3_underground
				_:
					return A.spr_NSMBU_mp3_overworld_night
		else:
			match G.bg_level:
				"snow":
					return A.spr_NSMBU_mp3_snow
				"underwater":
					return A.spr_NSMBU_mp3_underwater
				"beach":
					return A.spr_NSMBU_mp3_underwater
				"airship":
					return A.spr_NSMBU_mp3_airship
				"ghost":
					return A.spr_NSMBU_mp3_ghost
				"desert":
					return A.spr_NSMBU_mp3_desert
				"castle":
					return A.spr_NSMBU_mp3_castle
				"underground":
					return A.spr_NSMBU_mp3_underground
				_:
					return A.spr_NSMBU_mp3_overworld
