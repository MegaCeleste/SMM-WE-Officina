extends RefCounted


# from scripts/scr_snd_editor_airship/scr_snd_editor_airship.gml
static func scr_snd_editor_airship(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_airship
		1.0:
			return A.snd_SMB3_editor_airship
		2.0:
			return A.snd_editor_airship
		3.0:
			return A.snd_NSMBU_editor_airship
