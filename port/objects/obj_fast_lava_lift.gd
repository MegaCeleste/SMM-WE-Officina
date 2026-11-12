extends "res://objects/obj_lava_lift.gd"


# from objects/obj_fast_lava_lift/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_lava_lift
			image_speed = 0.0
			image_index = 1.0
		1.0:
			sprite_index = A.spr_SMB3_fast_lava_lift
			image_speed = 0.15
		2.0:
			sprite_index = A.spr_fast_lava_lift
			image_speed = 0.15
		3.0:
			sprite_index = A.spr_NSMBU_fast_lava_lift_overworld
			image_speed = 0.0
	ready_v = 0.0
	primero = GM.instance_create((x - 16.0), y, A.obj_lava_lift_part)
	segundo = GM.instance_create((x - 32.0), y, A.obj_lava_lift_part)
	tercero = GM.instance_create((x - 48.0), y, A.obj_lava_lift_part)
	primero.parent = self
	primero.sprite_index = sprite_index
	primero.image_index = image_index
	segundo.parent = self
	segundo.sprite_index = sprite_index
	segundo.image_index = image_index
	tercero.parent = self
	tercero.sprite_index = sprite_index
	tercero.image_index = image_index


# from objects/obj_fast_lava_lift/Other_11.gml
func _user_1() -> void:
	hspeed = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.2
	if GM.instance_exists(primero):
		for inst in GM.with_list(primero):
			if G.apariencia == 3.0:
				inst.image_speed = 0.2
			inst.hspeed = 2.0
			inst.ready_v = 1.0
	if GM.instance_exists(segundo):
		for inst in GM.with_list(segundo):
			if G.apariencia == 3.0:
				inst.image_speed = 0.2
			inst.hspeed = 2.0
			inst.ready_v = 1.0
	if GM.instance_exists(tercero):
		for inst in GM.with_list(tercero):
			if G.apariencia == 3.0:
				inst.image_speed = 0.2
			inst.hspeed = 2.0
			inst.ready_v = 1.0
	ready_v = 1.0
