extends "res://objects/obj_blockparent.gd"

var cointime: float = 0.0


# from objects/obj_block_multicoin/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0:
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			sprite_index = A.spr_SMB_block_ice
		elif G.bg_level == "snow":
			sprite_index = A.spr_SMB_block_snow
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB_block_dark
		elif G.bg_level == "mountain":
			sprite_index = A.spr_SMB_block
		elif G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			sprite_index = A.spr_SMB_block_night
		else:
			sprite_index = A.spr_SMB_block
	elif G.apariencia == 1.0:
		if G.bg_level == "snow" and G.modo_noche == 1.0:
			sprite_index = A.spr_SMB3_blocks_ice
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB3_block_dark
		elif G.bg_level == "mountain":
			if G.modo_noche == 0.0:
				sprite_index = A.spr_SMB3_block
			else:
				sprite_index = A.spr_SMB3_block_dark
		elif G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			sprite_index = A.spr_SMB3_block_night
		else:
			sprite_index = A.spr_SMB3_block
	elif G.apariencia == 3.0:
		if G.bg_level == "castle":
			sprite_index = A.spr_NSMBU_qblock_dark
		elif (G.bg_level == "mountain") and (G.modo_noche == 1.0):
			sprite_index = A.spr_NSMBU_qblock_dark
		elif (G.bg_level != "mountain") and (G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0):
			sprite_index = A.spr_NSMBU_qblock_night
		else:
			sprite_index = A.spr_NSMBU_qblock
	image_speed = 0.15
	ready_v = 0.0
	cointime = 0.0
	downwards = 0.0
	wings = 0.0
	wings_anim = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	expand = 0.0
	expand2 = 0.0
	expand3 = 0.0
	if G.apariencia == 0.0:
		sprite_wings = A.spr_SMB_wings_16x16
	elif G.apariencia == 1.0:
		sprite_wings = A.spr_SMB3_wings2
	else:
		sprite_wings = A.spr_wings_items
	alarm[10] = 4.0


# from objects/obj_block_multicoin/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	if cointime == 2.0:
		if G.apariencia == 0.0:
			sprite_index = A.spr_SMB_empty_block
			image_speed = 0.0
			if G.bg_level == "snow" and G.modo_noche == 1.0:
				image_index = 4.0
			elif G.bg_level == "snow":
				image_index = 3.0
			elif G.bg_level == "castle":
				image_index = 2.0
			elif G.bg_level == "mountain":
				image_index = 0.0
			elif G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
		elif G.apariencia == 1.0:
			sprite_index = A.spr_SMB3_empty_block
			image_speed = 0.0
			if G.bg_level == "snow" and G.modo_noche == 1.0:
				image_index = 3.0
			elif G.bg_level == "castle":
				image_index = 2.0
			elif G.bg_level == "mountain":
				if G.modo_noche == 1.0:
					image_index = 2.0
				else:
					image_index = 0.0
			elif G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
		elif G.apariencia == 2.0:
			sprite_index = A.spr_qblock_empty
		elif G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_qblock_empty
			image_speed = 0.0
			if G.bg_level == "castle":
				image_index = 2.0
			elif (G.bg_level != "mountain") and (G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0):
				image_index = 1.0
			elif G.bg_level == "mountain":
				if G.modo_noche == 1.0:
					image_index = 2.0
				else:
					image_index = 0.0
			else:
				image_index = 0.0
	else:
		ready_v = 0.0


# from objects/obj_block_multicoin/Alarm_4.gml
func _alarm_4() -> void:
	cointime = 2.0


# from objects/obj_block_multicoin/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_blockcoin)):
		inst.downwards = downwards
	downwards = 0.0
	if cointime == 0.0:
		cointime = 1.0
		alarm[4] = 200.0


# from objects/obj_block_multicoin/Other_11.gml
func _user_1() -> void:
	ready_v = 1.0
	vspeed = -2.0
	alarm[0] = 4.0
	_user_0()


# from objects/obj_block_multicoin/Draw_0.gml
func _gm_draw() -> void:
	var anim
	var sprited
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, x, y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
