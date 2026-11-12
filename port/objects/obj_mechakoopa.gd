extends "res://objects/obj_deactenemyparent.gd"

var s_dry: int = 0
var edible: float = 0.0
var wings_anim: float = 0.0


# from objects/obj_mechakoopa/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_mechakoopa_green_walk
			s_dry = A.spr_SMB_mechakoopa_green_deads
		1.0:
			sprite_index = A.spr_SMB3_mechakoopa_green_walk
			s_dry = A.spr_SMB3_mechakoopa_green_deads
		2.0:
			sprite_index = A.spr_mechakoopa_green_walk
			s_dry = A.spr_mechakoopa_green_deads
		3.0:
			sprite_index = A.spr_NSMBU_mechakoopa_green_walk
			s_dry = A.spr_NSMBU_mechakoopa_green_deads
	hardness = 6.0
	stomp = 3.0
	edible = 1.0
	dead_h = 0.0
	innave = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0
	direct = -1.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[10] = 2.0


# from objects/obj_mechakoopa/Step_0.gml
func _step() -> void:
	super._step()
	_user_6()


# from objects/obj_mechakoopa/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -0.5
		else:
			hspeed = 0.5
	alarm[11] = 60.0


# from objects/obj_mechakoopa/Alarm_11.gml
func _alarm_11() -> void:
	if hspeed != 0.0 and gravity == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -0.5
		else:
			hspeed = 0.5
	alarm[11] = 60.0


# from objects/obj_mechakoopa/Other_10.gml
func _user_0() -> void:
	var i: float = 0.0
	while i < 4.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemy_dead)):
			inst.girar = 1.0
			inst.direct = self.direct
			inst.sprite_index = self.s_dry
			inst.hspeed = GM.random_range(-1.0, 1.0)
			inst.image_speed = 0.0
			inst.image_index = i
		i += 1.0
	instance_destroy()


# from objects/obj_mechakoopa/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(GM.gm_round(x), y, A.obj_mechakoopa_held)):
		inst.direct = self.direct
	instance_destroy()


# from objects/obj_mechakoopa/Other_15.gml
func _user_5() -> void:
	_user_0()


# from objects/obj_mechakoopa/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
