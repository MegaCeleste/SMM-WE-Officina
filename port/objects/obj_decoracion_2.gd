# from objects/obj_decoracion_2（第 7 批移植，已核对）
extends "res://objects/obj_decoracion_parent.gd"


# from objects/obj_decoracion_2/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "beach" and G.apariencia == 3.0:
			if G.modo_noche == 1.0:
				sprite_index = A.spr_NSMBU_decoracion_beach_night
			else:
				sprite_index = A.spr_NSMBU_decoracion_beach
			image_index = 1.0
		elif G.bg_level == "mountain" and G.apariencia == 3.0 and G.modo_noche == 0.0:
			sprite_index = A.spr_NSMBU_decoracion_mountain_2
			image_index = 0.0
		elif G.bg_level == "mountain" and G.apariencia == 3.0 and G.modo_noche == 1.0:
			sprite_index = A.spr_NSMBU_decoracion_2_night
			image_index = 12.0
		else:
			match G.apariencia:
				0.0:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_decoracion_2_night
					else:
						sprite_index = A.spr_SMB_decoracion_2
				1.0:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_decoracion_2_night
					else:
						sprite_index = A.spr_SMB3_decoracion_2
				2.0:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_decoracion_2_night
					else:
						sprite_index = A.spr_decoracion_2
				3.0:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_NSMBU_decoracion_2_night
					else:
						sprite_index = A.spr_NSMBU_decoracion_2
				4.0:
					# ORIG-BUG: 工程里没有 spr_SMB2_decoracion_2(_night) 这两个资源，原版 apariencia==4 时会因未声明变量崩溃；移植里整段注释掉（TODO-PORT: 资源缺失）
					# if G.modo_noche == 1.0: sprite_index = spr_SMB2_decoracion_2_night
					# else: sprite_index = spr_SMB2_decoracion_2
					pass
			match G.bg_level:
				"ground":
					image_index = 0.0
				"underground":
					image_index = 1.0
				"underwater":
					image_index = 2.0
				"desert":
					image_index = 3.0
				"snow":
					image_index = 4.0
				"sky":
					image_index = 5.0
				"forest":
					image_index = 6.0
				"ghost":
					image_index = 7.0
				"airship":
					image_index = 8.0
				"castle":
					image_index = 9.0
				"fall":
					image_index = 10.0
				"beach":
					image_index = 11.0
				"mountain":
					image_index = 12.0


# from objects/obj_decoracion_2/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_modelbgo_dec)):
		inst.sprite_index = self.sprite_index
		inst.image_index = self.image_index
		inst.image_speed = 0.0
