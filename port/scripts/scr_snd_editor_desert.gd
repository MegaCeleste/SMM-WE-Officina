extends RefCounted


# from scripts/scr_snd_editor_desert/scr_snd_editor_desert.gml
static func scr_snd_editor_desert(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_desert
		1.0:
			return A.snd_SMB3_editor_desert
		2.0:
			return A.snd_editor_desert
		3.0:
			return A.snd_NSMBU_editor_desert
