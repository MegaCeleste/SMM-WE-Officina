# from objects/obj_spiny_empty（第 5 批移植，已核对）
extends "res://objects/obj_shell_empty.gd"


# from objects/obj_spiny_empty/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_shell_empty_spiny
		1.0:
			sprite_index = A.spr_SMB3_shell_spiny_empty
		2.0:
			sprite_index = A.spr_shell_spiny_empty
		3.0:
			sprite_index = A.spr_NSMBU_shell_spiny_empty
			direct = -1.0


# from objects/obj_spiny_empty/Other_11.gml
func _user_1() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if i_mario.stompstyle == 1.0 and G.apariencia > 1.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_o):
			inst.event_user(1)
		GM.other = _o
		GM.audio_stop_sound(Scr.scr_snd_stomp(self))
		GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
		GM.instance_create(GM.other.x, (GM.other.y + 22.0), A.obj_spinthump)
	else:
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_o2):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_spiny_empty/Other_17.gml
func _user_7() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_spiny_empty)
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
