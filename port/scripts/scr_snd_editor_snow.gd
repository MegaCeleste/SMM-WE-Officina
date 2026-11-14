extends RefCounted


# from scripts/scr_snd_editor_snow/scr_snd_editor_snow.gml
static func scr_snd_editor_snow(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_snow
		1.0:
			return A.snd_SMB3_editor_snow
		2.0:
			return A.snd_editor_snow
		3.0:
			return A.snd_NSMBU_editor_snow
