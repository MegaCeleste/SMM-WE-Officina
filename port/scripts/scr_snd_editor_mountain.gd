extends RefCounted


# from scripts/scr_snd_editor_mountain/scr_snd_editor_mountain.gml
static func scr_snd_editor_mountain(me: GMObject):
	var _switch_value1 = G.apariencia
	var _switch_case2: int = -1
	if _switch_case2 < 0 and GM.veq(_switch_value1, 0.0):
		_switch_case2 = 0
	if _switch_case2 < 0 and GM.veq(_switch_value1, 1.0):
		_switch_case2 = 1
	if _switch_case2 < 0 and GM.veq(_switch_value1, 2.0):
		_switch_case2 = 2
	if _switch_case2 < 0 and GM.veq(_switch_value1, 3.0):
		_switch_case2 = 3
	while true:
		if _switch_case2 >= 0 and _switch_case2 <= 0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_editor_sky
			elif G.modo_noche == 1.0:
				return A.snd_SMB_editor_castle
		if _switch_case2 >= 0 and _switch_case2 <= 1:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_editor_sky
			elif G.modo_noche == 1.0:
				return A.snd_SMB3_editor_castle
		if _switch_case2 >= 0 and _switch_case2 <= 2:
			if G.modo_noche == 0.0:
				return A.snd_editor_sky
			elif G.modo_noche == 1.0:
				return A.snd_editor_volcano
		if _switch_case2 >= 0 and _switch_case2 <= 3:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_editor_sky
			elif G.modo_noche == 1.0:
				return A.snd_NSMBU_editor_volcano
		break
