extends "res://objects/obj_enemyparent.gd"

var edible: float = 0.0
var wings_anim: float = 0.0
var parent = null
var prevsegment = null  # 由 obj_floruga 写入


# from objects/obj_floruga_body/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_floruga_body
		1.0:
			sprite_index = A.spr_SMB3_floruga_body
		2.0:
			sprite_index = A.spr_floruga_body
		3.0:
			sprite_index = A.spr_NSMBU_floruga_body
	hardness = 1.0
	stomp = 5.0
	edible = 2.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	modo_lava = 0.0
	dead_h = 0.0
	direct = -1.0
	innave = 0.0
	swimming = 0.0
	apilar = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.125
	parent = null


# from objects/obj_floruga_body/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		swimming = 1.0
	else:
		swimming = 0.0
	if GM.instance_exists(prevsegment):
		if direct == 1.0 and x > prevsegment.x:
			direct = -1.0
		elif direct == -1.0 and x < prevsegment.x:
			direct = 1.0
	_user_4()


# from objects/obj_floruga_body/Other_10.gml
func _user_0() -> void:
	if Scr.outside_view(self) > 0.5:
		return
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(parent):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_floruga_body/Other_11.gml
func _user_1() -> void:
	if Scr.outside_view(self) > 0.5:
		return
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(parent):
		inst.event_user(1)
	GM.other = _o


# from objects/obj_floruga_body/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
