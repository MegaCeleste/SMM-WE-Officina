extends "res://objects/obj_solid.gd"

var mysolid = null  # PORT: “没有”时存 A.obj_lighting（int，原版用 obj_lighting 当占位），有时存实例；比较用 GM.veq（port-plan 第 21 条）


# from objects/obj_pinchos/Create_0.gml
func _create() -> void:
	image_speed = 0.1
	match G.apariencia:
		0.0:
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_pinchos_ice
					else:
						sprite_index = A.spr_SMB_pinchos_snow
				"castle":
					sprite_index = A.spr_SMB_pinchos_dark
				"ghost":
					sprite_index = A.spr_SMB_pinchos_night
				"underground":
					sprite_index = A.spr_SMB_pinchos_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_pinchos_dark
					else:
						sprite_index = A.spr_SMB_pinchos
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_pinchos_night
					else:
						sprite_index = A.spr_SMB_pinchos
		1.0:
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_pinchos_ice
					else:
						sprite_index = A.spr_SMB3_pinchos
				"underwater":
					sprite_index = A.spr_SMB3_pinchos_swin
				"castle":
					sprite_index = A.spr_SMB3_pinchos_dark
				"ghost":
					sprite_index = A.spr_SMB3_pinchos_night
				"underground":
					sprite_index = A.spr_SMB3_pinchos_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_pinchos_dark
					else:
						sprite_index = A.spr_SMB3_pinchos
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_pinchos_night
					else:
						sprite_index = A.spr_SMB3_pinchos
		2.0:
			if G.bg_level == "underwater":
				sprite_index = A.spr_pinchos_swin
		3.0:
			match G.bg_level:
				"ghost":
					sprite_index = A.spr_NSMBU_pinchos_night
				"underground":
					sprite_index = A.spr_NSMBU_pinchos_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_NSMBU_pinchos
					else:
						sprite_index = A.spr_NSMBU_pinchos
						# PORT: 原版 case "mountain" 的 else 分支没有 break，贯穿进 default，这里把 default 的代码照写一份
						if G.modo_noche == 1.0:
							sprite_index = A.spr_NSMBU_pinchos_night
						else:
							sprite_index = A.spr_NSMBU_pinchos
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_NSMBU_pinchos_night
					else:
						sprite_index = A.spr_NSMBU_pinchos
	mysolid = A.obj_lighting
	alarm[0] = 15.0


# from objects/obj_pinchos/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(mysolid, A.obj_lighting) and GM.instance_exists(mysolid):
		for inst in GM.with_list(mysolid):
			inst.instance_destroy()


# from objects/obj_pinchos/Alarm_0.gml
func _alarm_0() -> void:
	if y == 0.0:
		if ((not place_meeting((x - 16.0), y, A.obj_pinchos)) and (not place_meeting((x + 16.0), y, A.obj_pinchos))) or ((not place_meeting((x - 16.0), y, A.obj_pinchos)) and place_meeting((x + 16.0), y, A.obj_pinchos)) or ((not place_meeting((x + 16.0), y, A.obj_pinchos)) and place_meeting((x - 16.0), y, A.obj_pinchos)):
			mysolid = GM.instance_create(x, (y - 192.0), A.obj_solid)
			mysolid.image_yscale = 12.0
	elif y == (GM.room_height - 16.0):
		if ((not place_meeting((x - 16.0), y, A.obj_pinchos)) and (not place_meeting((x + 16.0), y, A.obj_pinchos))) or ((not place_meeting((x - 16.0), y, A.obj_pinchos)) and place_meeting((x + 16.0), y, A.obj_pinchos)) or ((not place_meeting((x + 16.0), y, A.obj_pinchos)) and place_meeting((x - 16.0), y, A.obj_pinchos)):
			mysolid = GM.instance_create(x, (y + 16.0), A.obj_solid)
			mysolid.image_yscale = 6.0


# from objects/obj_pinchos/Draw_0.gml
func _gm_draw() -> void:
	var anim
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	anim = lm.banim3
	GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
