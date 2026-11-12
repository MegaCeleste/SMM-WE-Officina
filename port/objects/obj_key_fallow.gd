# from objects/obj_key_fallow（第 5 批移植，已核对）
extends GMObject

var followers: float = 0.0
var closeness: float = 0.0
var amount_previous: float = 0.0
var i: float = 0.0
var oldx: Array = []
var oldy: Array = []


# from objects/obj_key_fallow/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_key
		1.0:
			sprite_index = A.spr_SMB3_key
		2.0:
			sprite_index = A.spr_key
		3.0:
			sprite_index = A.spr_NSMBU_key
	image_speed = 0.25
	followers = 2.0
	closeness = 7.0
	amount_previous = 72.0
	i = 0.0
	while i < amount_previous:
		GM.aset(oldx, int(i), x)
		GM.aset(oldy, int(i), y)
		i += 1.0


# from objects/obj_key_fallow/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		x = (GM.instance_find(A.obj_mario, 0).x - 8.0)
		y = GM.instance_find(A.obj_mario, 0).y
		if GM.instance_find(A.obj_mario, 0).hspeed == 0.0:
			image_speed = 0.0
			image_index = 0.0
		else:
			image_speed = 0.25
		if not GM.instance_exists(A.obj_mario_transform2):
			if GM.instance_find(A.obj_mario, 0).sprite_index == Scr.scr_marioclimb(self):
				depth = (GM.instance_find(A.obj_mario, 0).depth - 1.0)
			elif GM.instance_exists(A.obj_yoshi2):
				depth = (GM.instance_find(A.obj_yoshi2, 0).depth + 1.0)
			elif GM.instance_exists(A.obj_mario_pballon):
				depth = (GM.instance_find(A.obj_mario_pballon, 0).depth + 1.0)
			else:
				depth = (GM.instance_find(A.obj_mario, 0).depth + 1.0)
		else:
			depth = -5.0
	elif GM.instance_exists(A.obj_doormario):
		x = (GM.instance_find(A.obj_doormario, 0).x - 8.0)
		y = GM.instance_find(A.obj_doormario, 0).y
		image_speed = 0.0
		image_index = 0.0
		depth = (GM.instance_find(A.obj_doormario, 0).depth + 1.0)
	elif GM.instance_exists(A.obj_doormario_exit):
		x = (GM.instance_find(A.obj_doormario_exit, 0).x - 8.0)
		y = GM.instance_find(A.obj_doormario_exit, 0).y
		image_speed = 0.0
		image_index = 0.0
		depth = (GM.instance_find(A.obj_doormario_exit, 0).depth + 1.0)
	elif GM.instance_exists(A.obj_player_goal_parent):
		x = (GM.instance_find(A.obj_player_goal_parent, 0).x - 8.0)
		y = GM.instance_find(A.obj_player_goal_parent, 0).y
		if GM.instance_find(A.obj_player_goal_parent, 0).hspeed == 0.0:
			image_speed = 0.0
			image_index = 0.0
		else:
			image_speed = 0.25
		depth = (GM.instance_find(A.obj_player_goal_parent, 0).depth + 1.0)
	elif GM.instance_exists(A.obj_player_warp):
		x = (GM.instance_find(A.obj_player_warp, 0).x - 8.0)
		y = GM.instance_find(A.obj_player_warp, 0).y
		if GM.instance_find(A.obj_player_warp, 0).hspeed == 0.0:
			image_speed = 0.0
			image_index = 0.0
		else:
			image_speed = 0.25
		depth = (GM.instance_find(A.obj_player_warp, 0).depth + 1.0)
	if G.keys > 0.0 and (not GM.instance_exists(A.obj_mario_transform2)):
		GM.aset(oldx, 0, x)
		GM.aset(oldy, 0, (y + 16.0))
		i = amount_previous
		while i > 0.0:
			GM.aset(oldx, int(i), oldx[int(i - 1.0)])
			GM.aset(oldy, int(i), oldy[int(i - 1.0)])
			i -= 1.0


# from objects/obj_key_fallow/Draw_0.gml
func _gm_draw() -> void:
	if G.keys > 0.0:
		i = 1.0
		while i < followers:
			GM.draw_sprite(sprite_index, image_index, oldx[int(i * closeness)], oldy[int(i * closeness)])
			i += 1.0
