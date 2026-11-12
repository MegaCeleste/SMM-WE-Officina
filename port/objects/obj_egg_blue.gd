# from objects/obj_egg_blue（第 5 批移植，已核对）
extends "res://objects/obj_egg.gd"


# from objects/obj_egg_blue/Alarm_2.gml
func _alarm_2() -> void:
	if G.apariencia == 1.0:
		anim += 1.0
		alarm[2] = 7.0
	elif G.apariencia == 2.0:
		if GM.instance_number(A.obj_yoshi_abandon) < 2 and GM.instance_number(A.obj_egg_hatch) < 2:
			for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 16.0), A.obj_egg_hatch)):
				inst.color = 2.0
				inst.sprite_index = A.spr_hatch_blue
		instance_destroy()
		instance_destroy()  # ORIG-BUG: 重复调用 instance_destroy，照搬（第二次对已销毁实例无效）


# from objects/obj_egg_blue/Draw_0.gml
func _gm_draw() -> void:
	match G.apariencia:
		0.0:
			if object_index == A.obj_egg_red:
				GM.draw_sprite_ext(A.spr_SMB_kuriboshoe2, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			else:
				GM.draw_sprite_ext(A.spr_SMB_kuriboshoe, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if ready_v > 0.5:
				GM.draw_sprite_ext(sprite_index, -1.0, x, (GM.gm_round(y) - 15.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
		1.0:
			if object_index == A.obj_egg_red:
				GM.draw_sprite_ext(A.spr_kuriboshoe2, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			else:
				GM.draw_sprite_ext(A.spr_kuriboshoe, anim, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if ready_v > 0.5:
				GM.draw_sprite_ext(sprite_index, -1.0, x, (GM.gm_round(y) - 15.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
		2.0:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			if wings == 1.0:
				GM.draw_sprite(A.spr_wings_items, wings_anim, x, y)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
		3.0:
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
			if wings == 1.0:
				GM.draw_sprite(A.spr_NSMBU_wings_items, wings_anim, x, y)
			if paracaidas == 1.0:
				GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
