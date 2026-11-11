extends "res://objects/obj_blockparent.gd"

var sprout: float = 0.0
var progresivo: float = 0.0
var new_index: float = 0.0


# from objects/obj_block/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			if G.bg_level == "snow" and G.modo_noche == 1.0:
				sprite_index = A.spr_SMB_block_ice
			elif G.bg_level == "snow":
				sprite_index = A.spr_SMB_block_snow
			elif G.bg_level == "castle":
				sprite_index = A.spr_SMB_block_dark
			elif (G.bg_level == "mountain") and (G.modo_noche == 1.0):
				sprite_index = A.spr_SMB_block
			elif G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				sprite_index = A.spr_SMB_block_night
			else:
				sprite_index = A.spr_SMB_block
		1.0:
			if G.bg_level == "snow" and G.modo_noche == 1.0:
				sprite_index = A.spr_SMB3_blocks_ice
			elif G.bg_level == "castle":
				sprite_index = A.spr_SMB3_block_dark
			elif (G.bg_level == "mountain") and (G.modo_noche == 1.0):
				sprite_index = A.spr_SMB3_block_dark
			elif G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				sprite_index = A.spr_SMB3_block_night
			else:
				sprite_index = A.spr_SMB3_block
		3.0:
			if G.bg_level == "castle":
				sprite_index = A.spr_NSMBU_qblock_dark
			elif (G.bg_level == "mountain") and (G.modo_noche == 1.0):
				sprite_index = A.spr_NSMBU_qblock_dark
			elif (G.bg_level != "mountain") and (G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0):
				sprite_index = A.spr_NSMBU_qblock_night
			else:
				sprite_index = A.spr_NSMBU_qblock
	if G.apariencia == 3.0:
		image_speed = 0.2
	else:
		image_speed = 0.15
	sprout = -1.0
	progresivo = 0.0
	ready_v = 0.0
	wings = 0.0
	new_index = 0.2
	wings_anim = 0.0
	downwards = 0.0
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


# from objects/obj_block/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	if sprout != -1.0:
		if progresivo == 1.0:
			if G.powerup == 0.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_powerupsprout)):
					inst.sprite_index = Scr.scr_constant_get_sprite(inst, 1.0)
					inst.downwards = downwards
					inst.wings = wings
					inst.s_sprout = 1.0
			else:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_powerupsprout)):
					inst.sprite_index = Scr.scr_constant_get_sprite(inst, sprout)
					inst.downwards = downwards
					inst.wings = wings
					inst.s_sprout = sprout
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_powerupsprout)):
				inst.sprite_index = Scr.scr_constant_get_sprite(inst, sprout)
				inst.downwards = downwards
				inst.wings = wings
				inst.s_sprout = sprout
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_empty_block
			image_speed = 0.0
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 3.0
				"castle":
					image_index = 2.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 0.0
					else:
						image_index = 0.0
					# ORIG-BUG: 原版此处 break 之后还有一条 image_index = 2（死代码），不会执行
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				_:
					if G.modo_noche == 1.0:
						image_index = 1.0
					else:
						image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_empty_block
			image_speed = 0.0
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 3.0
					else:
						image_index = 0.0
				"castle":
					image_index = 2.0
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 2.0
					else:
						image_index = 0.0
				_:
					if G.modo_noche == 1.0:
						image_index = 1.0
					else:
						image_index = 0.0
		2.0:
			sprite_index = A.spr_qblock_empty
		3.0:
			sprite_index = A.spr_NSMBU_qblock_empty
			image_speed = 0.0
			match G.bg_level:
				"castle":
					image_index = 2.0
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 2.0
					else:
						image_index = 0.0
				_:
					if G.modo_noche == 1.0:
						image_index = 1.0
					else:
						image_index = 0.0


# from objects/obj_block/Other_10.gml
func _user_0() -> void:
	if sprout == -1.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_blockcoin)):
			inst.downwards = downwards


# from objects/obj_block/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, x, y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
