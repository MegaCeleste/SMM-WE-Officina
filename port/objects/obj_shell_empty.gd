# from objects/obj_shell_empty（第 5 批移植，已核对）
extends "res://objects/obj_shell.gd"


# from objects/obj_shell_empty/Create_0.gml
func _create() -> void:
	var dark
	super._create()
	hardness = 100.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_shell_empty_night
			else:
				sprite_index = A.spr_SMB_shell_empty
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_shell_empty_night
			else:
				sprite_index = A.spr_SMB3_shell_empty
		2.0:
			sprite_index = A.spr_shell_buzzy_empty
		3.0:
			sprite_index = A.spr_NSMBU_shell_buzzy_empty
			direct = -1.0


# from objects/obj_shell_empty/Destroy_0.gml
func _destroy() -> void:
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
			inst.isduckhold = 0.0
		for inst in GM.with_list(A.obj_player_warp):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_doormario):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_doormario_exit):
			inst.holding = 0.0


# from objects/obj_shell_empty/Collision_obj_fireball.gml
func _collision_obj_fireball(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shell_empty/Other_17.gml
func _user_7() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_shell_empty)
	if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = -0.5
	instance_destroy()
