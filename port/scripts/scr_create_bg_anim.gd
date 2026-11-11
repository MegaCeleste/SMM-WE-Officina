# from scripts/scr_create_bg_anim/scr_create_bg_anim.gml
# 第 3 批移植，已核对。原版 switch 没有 case 3 / default；case 内的 break 都在 switch 末尾前，等价于直接结束。anibg 是 obj_bganimator 的数组实例变量（需声明成 Array）。
extends RefCounted


# from scripts/scr_create_bg_anim/scr_create_bg_anim.gml
static func scr_create_bg_anim(me: GMObject) -> Variant:
	if GM.instance_exists(A.obj_bganimator):
		for inst in GM.with_list(A.obj_bganimator):
			inst.instance_destroy()
	match G.apariencia:
		0.0:
			if G.modo_noche == 1.0:
				if G.bg_level == "snow":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB_snow_night_1)
						GM.aset(inst.anibg, 1, A.bg_SMB_snow_night_2)
				elif G.bg_level == "underwater":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB_underwater_night_1)
						GM.aset(inst.anibg, 1, A.bg_SMB_underwater_night_2)
				elif G.bg_level == "mountain":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB_volcano)
						GM.aset(inst.anibg, 1, A.bg_SMB_volcano_2)
				elif (G.bg_level != "ghost") and (G.bg_level != "mountain"):
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB_night_1)
						GM.aset(inst.anibg, 1, A.bg_SMB_night_2)
		1.0:
			if G.modo_noche == 1.0:
				if G.bg_level == "snow":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB3_snow_night_1)
						GM.aset(inst.anibg, 1, A.bg_SMB3_snow_night_2)
				elif G.bg_level == "airship":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB3_sky_night_1)
						GM.aset(inst.anibg, 1, A.bg_SMB3_sky_night_2)
						GM.aset(inst.anibg, 2, A.bg_SMB3_sky_night_3)
						GM.aset(inst.anibg, 3, A.bg_SMB3_sky_night_1)
				elif G.bg_level == "mountain":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB3_volcano)
						GM.aset(inst.anibg, 1, A.bg_SMB3_volcano_2)
				elif G.bg_level != "underwater" and G.bg_level != "ghost" and G.bg_level != "mountain":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_SMB3_night_1)
						GM.aset(inst.anibg, 1, A.bg_SMB3_night_2)
		2.0:
			if G.modo_noche == 0.0:
				if G.bg_level == "underground":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_underground_1)
						GM.aset(inst.anibg, 1, A.bg_underground_2)
						GM.aset(inst.anibg, 2, A.bg_underground_3)
						GM.aset(inst.anibg, 3, A.bg_underground_4)
				elif G.bg_level == "underwater":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_underwater_1)
						GM.aset(inst.anibg, 1, A.bg_underwater_2)
						GM.aset(inst.anibg, 2, A.bg_underwater_3)
						GM.aset(inst.anibg, 3, A.bg_underwater_4)
				elif G.bg_level == "ghost":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_ghost_house_1)
						GM.aset(inst.anibg, 1, A.bg_ghost_house_2)
						GM.aset(inst.anibg, 2, A.bg_ghost_house_3)
						GM.aset(inst.anibg, 3, A.bg_ghost_house_2)
			elif G.modo_noche == 1.0:
				if G.bg_level == "airship":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_sky_night_1)
						GM.aset(inst.anibg, 1, A.bg_sky_night_2)
						GM.aset(inst.anibg, 2, A.bg_sky_night_3)
						GM.aset(inst.anibg, 3, A.bg_sky_night_2)
				elif G.bg_level == "underwater":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_underwater_night_1)
						GM.aset(inst.anibg, 1, A.bg_underwater_night_2)
						GM.aset(inst.anibg, 2, A.bg_underwater_night_3)
						GM.aset(inst.anibg, 3, A.bg_underwater_night_4)
				elif G.bg_level == "mountain":
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_volcano_1)
						GM.aset(inst.anibg, 1, A.bg_volcano_2)
						GM.aset(inst.anibg, 2, A.bg_volcano_3)
						GM.aset(inst.anibg, 3, A.bg_volcano_4)
				elif (G.bg_level != "ghost") and (G.bg_level != "mountain"):
					for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_bganimator)):
						GM.aset(inst.anibg, 0, A.bg_night_1)
						GM.aset(inst.anibg, 1, A.bg_night_2)
						GM.aset(inst.anibg, 2, A.bg_night_3)
						GM.aset(inst.anibg, 3, A.bg_night_4)
	return null
