extends RefCounted


# from scripts/scr_snd_editor_underground/scr_snd_editor_underground.gml
static func scr_snd_editor_underground(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_underground
		1.0:
			return A.snd_SMB3_editor_underground
		2.0:
			return A.snd_editor_underground
		3.0:
			return A.snd_NSMBU_editor_underground
