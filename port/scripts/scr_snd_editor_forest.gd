extends RefCounted


# from scripts/scr_snd_editor_forest/scr_snd_editor_forest.gml
static func scr_snd_editor_forest(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_forest
		1.0:
			return A.snd_SMB3_editor_forest
		2.0:
			return A.snd_editor_forest
		3.0:
			return A.snd_NSMBU_editor_forest
