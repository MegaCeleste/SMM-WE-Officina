extends "res://objects/obj_platform_parent.gd"


var s_donut: int = 0  ## sprite 编号
var s_donut_fall: int = 0  ## sprite 编号
var shake: float = 0.0
var delito: float = 0.0
var crecer: float = 0.0
var return_wings: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var wings: float = 0.0
var wings_anim: float = 0.0
var sprite_wings: int = 0  ## sprite 编号


# from objects/obj_donut/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_donut
		s_donut = A.spr_SMB_donut
		s_donut_fall = A.spr_SMB_donut_fall
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 5.0
		elif G.bg_level == "snow":
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_donut
		s_donut = A.spr_SMB3_donut
		s_donut_fall = A.spr_SMB3_donut_fall
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 3.0
		elif G.bg_level == "castle":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 2.0:
		s_donut = A.spr_donut
		s_donut_fall = A.spr_donut_fall
		image_index = 0.0
	elif G.apariencia == 3.0:
		s_donut = A.spr_NSMBU_donut
		s_donut_fall = A.spr_NSMBU_donut_fall
		image_index = 0.0
	image_speed = 0.0
	shake = 0.0
	delito = 0.0
	crecer = 0.0
	return_wings = 0.0
	ready_v = 0.0
	wings = 0.0
	wings_anim = 0.0
	if G.apariencia == 0.0:
		sprite_wings = A.spr_SMB_wings_16x16
	elif G.apariencia == 1.0:
		sprite_wings = A.spr_SMB3_wings2
	else:
		sprite_wings = A.spr_wings_items
	alarm[10] = 4.0


# from objects/obj_donut/Step_2.gml
func _step_end() -> void:
	if wings == 1.0:
		depth = -7.0
		wings_anim += 0.12
		if y > (ystart + 14.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.085
		elif y < (ystart - 14.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.085
		if x < (xstart - 40.0):
			if hspeed > 0.5:
				hspeed = 0.5
			else:
				hspeed += 0.085
		elif x > (xstart + 40.0):
			if hspeed < -0.5:
				hspeed = -0.5
			else:
				hspeed -= 0.085
	var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 原版写 obj_mario.xxx（第一个实例）
	if collision_rectangle((bbox_left - 1.0), (bbox_top - 5.0), (bbox_right + 1.0), (bbox_top + 4.0), A.obj_mario, false, false) != null and mario.bbox_bottom < (yprevious + 5.0) and mario.state < 2.0:
		if vspeed == 0.0 or wings == 1.0:
			if shake == 0.0:
				alarm[2] = 1.0
				alarm[0] = 30.0
				shake = 1.0
			sprite_index = s_donut_fall
		elif vspeed != 0.0 and wings == 0.0:
			alarm[2] = -1.0
			alarm[3] = -1.0
			shake = 0.0
			x = xstart
			sprite_index = s_donut_fall
	elif vspeed == 0.0 or wings == 1.0:
		alarm[2] = -1.0
		alarm[3] = -1.0
		shake = 0.0
		x = xstart
		sprite_index = s_donut
		_user_0()
		alarm[0] = -1.0
	elif vspeed != 0.0 and wings == 0.0:
		alarm[2] = -1.0
		alarm[3] = -1.0
		shake = 0.0
		x = xstart
		sprite_index = s_donut_fall
	if crecer == 1.0:
		if image_xscale < 1.0:
			image_xscale += 0.05
			image_yscale += 0.05
		else:
			image_xscale = 1.0
			image_yscale = 1.0
			crecer = 0.0
	if vspeed > 2.5:
		vspeed = 2.5
	if bbox_top > (GM.room_height + 64.0) and delito == 0.0:
		delito = 1.0
		vspeed = 0.0
		shake = 0.0
		gravity = 0.0
		alarm[1] = 180.0
	super._step_end()


# from objects/obj_donut/Alarm_0.gml
func _alarm_0() -> void:
	gravity = 0.1
	hspeed = 0.0
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if wings == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0
		wings = 0.0
		return_wings = 1.0


# from objects/obj_donut/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create(xstart, ystart, A.obj_donut)):
		inst.image_xscale = 0.2
		inst.image_yscale = 0.2
		inst.crecer = 1.0
		if self.return_wings == 1.0:
			inst.wings = 1.0
	instance_destroy()


# from objects/obj_donut/Alarm_2.gml
func _alarm_2() -> void:
	x -= 2.0
	alarm[3] = 4.0


# from objects/obj_donut/Alarm_3.gml
func _alarm_3() -> void:
	x += 2.0
	alarm[2] = 4.0


# from objects/obj_donut/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0:
		hspeed = -0.5
		vspeed = -0.5
		depth = -7.0


# from objects/obj_donut/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 0.0:
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 5.0
		elif G.bg_level == "snow":
			image_index = 4.0
		elif G.bg_level == "castle":
			image_index = 3.0
		elif G.bg_level == "underwater":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	elif G.apariencia == 1.0:
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			image_index = 3.0
		elif G.bg_level == "castle":
			image_index = 2.0
		elif G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	else:
		image_index = 0.0


# from objects/obj_donut/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if wings == 1.0:
		if G.apariencia == 2.0:
			GM.draw_sprite(sprite_wings, wings_anim, (x - 8.0), y)
		else:
			GM.draw_sprite(sprite_wings, wings_anim, x, y)
