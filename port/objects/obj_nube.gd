# from objects/obj_nube（第 5 批移植，已核对）
extends "res://objects/obj_solidtop.gd"


# from objects/obj_nube/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_nube
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 5.0
		elif G.bg_level == "snow":
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost":
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_nube
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 2.0:
		sprite_index = A.spr_nube
		if G.bg_level == "underwater":
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_nube
		if G.bg_level == "ghost":
			image_index = 5.0
		elif (G.bg_level == "airship" or G.bg_level == "sky") and G.modo_noche == 0.0:
			image_index = 4.0
		elif G.bg_level == "underwater":
			image_index = 3.0
		elif G.bg_level == "castle":
			image_index = 2.0
		elif G.bg_level == "underground" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0


# from objects/obj_nube/Step_1.gml
func _step_begin() -> void:
	return


# from objects/obj_nube/Collision_obj_thwomp.gml
func _collision_obj_thwomp(other: GMObject) -> void:
	# other.ready 在移植版里是 ready_v（撞名 Node.ready，转换脚本统一改名）；obj_thwomp 未移植，需声明 ready_v / direct_t
	var lm = GM.instance_find(A.obj_levelmanager, 0)  # obj_levelmanager.editor 读：第 16 条
	if other.ready_v == 1.0 and y > other.y and other.direct_t == 1.0 and lm.editor == 0.0:
		GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
		for inst in GM.with_list(other):
			inst.vspeed = 0.0
			inst.gravity = 0.0
			inst.ready_v = 2.0
			inst.alarm[0] = 60.0
		GM.instance_create(x, y, A.obj_smoke)
		instance_destroy()
