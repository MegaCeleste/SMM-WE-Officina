extends RefCounted


# from scripts/scr_snd_editor_ghost/scr_snd_editor_ghost.gml
static func scr_snd_editor_ghost(me: GMObject):
	match float(G.apariencia):
		0.0:
			return A.snd_SMB_editor_ghost
		1.0:
			return A.snd_SMB3_editor_ghost
		2.0:
			return A.snd_editor_ghost
		3.0:
			return A.snd_NSMBU_editor_ghost
