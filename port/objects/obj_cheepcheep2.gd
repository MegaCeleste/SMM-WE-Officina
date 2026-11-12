extends "res://objects/obj_cheepcheep.gd"


# from objects/obj_cheepcheep2/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_cheepcheep2
		1.0:
			sprite_index = A.spr_SMB3_cheepcheep2
		3.0:
			sprite_index = A.spr_NSMBU_cheepcheep2


# from objects/obj_cheepcheep2/Step_0.gml
func _step() -> void:
	if G.bg_level != "underwater" and modo_water == 0.0:
		if act_modo_vuelo == 1.0 and place_free(x, (y + 1.0)) and vspeed > 0.0:
			modo_vuelo = 1.0
			alarm[0] = 120.0
			act_modo_vuelo = 0.0
		if paracaidas == 1.0:
			gravity = 0.1
			if vspeed > 0.4:
				vspeed = 0.4
		elif modo_vuelo == 0.0:
			gravity = 0.12
			if direct == 1.0 and hspeed > 0.5:
				hspeed -= 0.08
				if hspeed <= 0.5:
					hspeed = 0.5
			elif direct == -1.0 and hspeed < -0.5:
				hspeed += 0.08
				if hspeed >= -0.5:
					hspeed = -0.5
			if vspeed > 4.0:
				vspeed = 4.0
		else:
			gravity = 0.0
			vspeed -= 0.03
			hspeed = (0.2 * direct)
			if vspeed < 0.3:
				vspeed = -0.3
		if (GM.instance_exists(A.obj_lava_water) and y >= GM.instance_find(A.obj_lava_water, 0).y) or (G.bg_level != "forest" and G.bg_level != "castle" and y >= (GM.room_height - 16.0)):
			if paracaidas == 1.0:
				GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
				paracaidas = 0.0
				hspeed = 0.0
				alarm[10] = 10.0
			if jump == 2.0:
				if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
					if wings == 1.0:
						hspeed = -1.0
					else:
						hspeed = -0.5
				elif wings == 1.0:
					hspeed = 1.0
				else:
					hspeed = 0.5
			elif direct == 1.0:
				if wings == 1.0:
					hspeed = 1.0
				else:
					hspeed = 0.5
			elif wings == 1.0:
				hspeed = -1.0
			else:
				hspeed = -0.5
			if G.bg_level == "castle":
				if lava == 0.0:
					lava = 1.0
					alarm[1] = 8.0
			elif G.bg_level == "forest" and G.modo_noche == 1.0:
				lava = 1.0
			if jump == 0.0:
				jump = 1.0
				vspeed = -3.0
			elif jump == 1.0:
				jump = 2.0
				vspeed = -3.0
			elif jump == 2.0:
				vspeed = -5.0
				if wings == 1.0:
					act_modo_vuelo = 1.0
				jump = 0.0
			if G.bg_level != "castle":
				for inst in GM.with_list(GM.instance_create((x - 13.0), (y - 6.0), A.obj_spinthump)):
					inst.sprite_index = A.spr_cheepcheep_bubble
		if paracaidas == 1.0:
			direct = -1.0
			if x > (xstart + 16.0):
				if hspeed < -0.5:
					hspeed = -0.5
				else:
					hspeed -= 0.015
			elif x < (xstart - 16.0):
				if hspeed > 0.5:
					hspeed = 0.5
				else:
					hspeed += 0.015
	if lava == 1.0:
		if G.apariencia == 3.0:
			anim += 0.5
		else:
			anim += 0.15
	if paracaidas == 0.0:
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
	if wings == 1.0:
		if modo_vuelo == 1.0:
			wings_anim += 0.25
		else:
			wings_anim += 0.12
		if G.bg_level == "underwater" or modo_water == 1.0:
			if y > (ystart + 16.0):
				if vspeed < -0.5:
					vspeed = -0.5
				else:
					vspeed -= 0.015
			elif y < (ystart - 16.0):
				if vspeed > 0.5:
					vspeed = 0.5
				else:
					vspeed += 0.015
		if GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and modo_water == 1.0:
			y = (GM.instance_find(A.obj_lava_water, 0).y + 16.0)
	if paracaidas == 1.0 and (G.bg_level == "underwater" or (G.bg_level != "forest" and G.bg_level != "castle" and y >= (GM.room_height - 16.0))):
		GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
		paracaidas = 0.0
		alarm[10] = 10.0


# from objects/obj_cheepcheep2/Alarm_2.gml
func _alarm_2() -> void:
	hspeed = (-hspeed)
	alarm[2] = 240.0


# from objects/obj_cheepcheep2/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if G.bg_level == "underwater" or modo_water == 1.0:
			if direct == 1.0:
				if wings == 1.0:
					vspeed = 0.5
				hspeed = 0.5
			else:
				if wings == 1.0:
					vspeed = 0.5
				hspeed = -0.5
			alarm[2] = 240.0
		elif paracaidas == 1.0:
			hspeed = 0.5


# from objects/obj_cheepcheep2/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = A.spr_cheepcheep2_deads
	imdead.image_index = G.apariencia
	imdead.direct = direct
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()
