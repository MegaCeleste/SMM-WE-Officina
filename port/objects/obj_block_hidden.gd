# from objects/obj_block_hidden（第 6e 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var sprout: float = 0.0
var progresivo: float = 0.0
var wings: float = 0.0


# from objects/obj_block_hidden/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_block_hidden
		1.0:
			sprite_index = A.spr_SMB3_block_hidden
		2.0:
			sprite_index = A.spr_block_hidden
		3.0:
			sprite_index = A.spr_NSMBU_block_hidden
	image_speed = 0.0
	sprout = -1.0
	progresivo = 0.0
	wings = 0.0


# from objects/obj_block_hidden/Step_0.gml
func _step() -> void:
	var player
	player = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 2.0), A.obj_mario, false, false)
	if player != null and player.vspeed < 0.0 and player.bbox_top > ((bbox_bottom + 1.0) + player.vspeed):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_block)):
			if G.apariencia == 0.0:
				inst.sprite_index = A.spr_SMB_empty_block
			elif G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_empty_block
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_qblock_empty
			inst.ready_v = 1.0
			inst.vspeed = -2.0
			inst.alarm[0] = 4.0
			inst.wings = self.wings
			inst.sprout = self.sprout
			inst.progresivo = self.progresivo
			inst.event_user(0)
		GM.other = _o
		instance_destroy()


# from objects/obj_block_hidden/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	if other.vspeed < 0.0 and other.bbox_top > (bbox_bottom + other.vspeed):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_block)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_block_hidden
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_qblock_empty
			inst.ready_v = 1.0
			inst.vspeed = -2.0
			inst.alarm[0] = 4.0
			inst.sprout = self.sprout
			inst.event_user(0)
		GM.other = _o
		instance_destroy()


# from objects/obj_block_hidden/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if other.vspeed < 0.0 and other.bbox_top > (bbox_bottom + other.vspeed):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_block)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_block_hidden
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_qblock_empty
			inst.ready_v = 1.0
			inst.vspeed = -2.0
			inst.alarm[0] = 4.0
			inst.sprout = self.sprout
			inst.event_user(0)
		GM.other = _o
		instance_destroy()


# from objects/obj_block_hidden/Collision_obj_spinner.gml
func _collision_obj_spinner(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_block)):
		if G.apariencia == 1.0:
			inst.sprite_index = A.spr_SMB3_block_hidden
		elif G.apariencia == 2.0:
			inst.sprite_index = A.spr_qblock_empty
		inst.ready_v = 1.0
		inst.vspeed = -2.0
		inst.alarm[0] = 4.0
		inst.sprout = self.sprout
		inst.event_user(0)
	GM.other = _o
	instance_destroy()


# from objects/obj_block_hidden/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if sprout != -1.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		GM.draw_sprite(A.spr_marker_event, 0.0, x, y)
