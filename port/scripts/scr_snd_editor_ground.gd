extends RefCounted


# from scripts/scr_snd_editor_ground/scr_snd_editor_ground.gml
static func scr_snd_editor_ground(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor
		1.0:
			return A.snd_SMB3_editor
		2.0:
			return A.snd_editor_overworld
		3.0:
			return A.snd_NSMBU_editor_overworld
