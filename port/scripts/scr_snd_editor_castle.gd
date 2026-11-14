extends RefCounted


# from scripts/scr_snd_editor_castle/scr_snd_editor_castle.gml
static func scr_snd_editor_castle(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_castle
		1.0:
			return A.snd_SMB3_editor_castle
		2.0:
			return A.snd_editor_castle
		3.0:
			return A.snd_NSMBU_editor_castle
