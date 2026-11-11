# from scripts/scr_snd_bowserjr_shell/scr_snd_bowserjr_shell.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_bowserjr_shell/scr_snd_bowserjr_shell.gml
static func scr_snd_bowserjr_shell(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_bowserjr_shell
		1.0:
			return A.snd_bowserjr_shell
		2.0:
			return A.snd_bowserjr_shell
		3.0:
			return A.snd_NSMBU_bowserjr_shell
	return null
