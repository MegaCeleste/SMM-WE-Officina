extends "res://objects/obj_banzaibill.gd"

var lastdir: float = 0.0
var homing: float = 0.0


# from objects/obj_billbanzai_red/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	direct_t = 1.0
	anim = 0.0
	hardness = 99.0
	stomp = 0.0
	edible = 2.0
	direct = 1.0
	rotacion = 0.0
	dead_h = 0.0
	wings = 0.0
	w_wings = 0.0
	apilar = 0.0
	swimming = 0.0
	lastdir = direction
	anim = 0.0
	homing = 0.0
	alarm[2] = 10.0
	alarm[3] = 600.0
	alarm[10] = 1.0


# from objects/obj_billbanzai_red/Step_0.gml
func _step() -> void:
	var new_dir: float
	var diff: float
	if homing == 1.0:
		if GM.instance_exists(A.obj_mario):
			var _m: GMObject = GM.instance_find(A.obj_mario, 0)
			new_dir = GM.point_direction(x, y, _m.x, (_m.y + 16.0))
			diff = GM.angle_difference(direction, new_dir)
			direction -= minf((1.0 * GM.gm_sign(diff)), absf(diff))
			lastdir = direction
		else:
			direction = lastdir
	elif homing == 2.0:
		direction = lastdir
	if G.apariencia == 3.0 and (not GM.instance_exists(A.obj_deadmario)):
		anim += 0.3


# from objects/obj_billbanzai_red/Alarm_2.gml
func _alarm_2() -> void:
	homing = 1.0


# from objects/obj_billbanzai_red/Alarm_3.gml
func _alarm_3() -> void:
	homing = 2.0


# from objects/obj_billbanzai_red/Other_11.gml
func _user_1() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = image_index
	imdead.image_angle = direction
	imdead.hspeed = 0.6
	imdead.vspeed = 0.1
	imdead.alarm[0] = -1.0
	instance_destroy()


# from objects/obj_billbanzai_red/Draw_0.gml
func _gm_draw() -> void:
	if G.apariencia == 3.0:
		GM.draw_sprite_ext(A.spr_NSMBU_smoke_bz, anim, x, y, -1.0, 1.0, direction, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, direction, GM.c_white, 1.0)
