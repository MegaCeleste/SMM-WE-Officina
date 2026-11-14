extends RefCounted


# from scripts/scr_snd_editor_underwater/scr_snd_editor_underwater.gml
static func scr_snd_editor_underwater(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_underwater
		1.0:
			return A.snd_SMB3_editor_underwater
		2.0:
			return A.snd_editor_underwater
		3.0:
			return A.snd_NSMBU_editor_underwater
