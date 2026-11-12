extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var fire: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var ready2: float = 0.0
var jump_plant: float = 0.0
var b_start: float = 0.0
var timer: float = 0.0
var inup: float = 0.0
var cankill: float = 0.0


# from objects/obj_big_pplant/Create_0.gml
func _create() -> void:
	sprite_index = A.spr_NSMBU_big_pplant
	image_speed = 0.75
	sprite_wings = A.spr_NSMBU_wings_items
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	apilar = 0.0
	imdead = 0.0
	fire = 0.0
	ready_v = 0.0
	ready2 = 0.0
	swimming = 0.0
	jump_plant = 0.0
	b_start = y
	timer = 0.0
	inup = 0.0
	cankill = 0.0
	alarm[2] = 5.0
	alarm[11] = 5.0


# from objects/obj_big_pplant/Step_0.gml
func _step() -> void:
	_user_4()
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x < x:
			direct = 1.0
		else:
			direct = -1.0


# from objects/obj_big_pplant/Alarm_2.gml
func _alarm_2() -> void:
	cankill = 1.0


# from objects/obj_big_pplant/Alarm_11.gml
func _alarm_11() -> void:
	GM.audio_stop_sound(A.snd_big_pplant_atack)
	GM.audio_play_sound(A.snd_big_pplant_atack, 0.0, false)
	alarm[11] = 40.0


# from objects/obj_big_pplant/Other_10.gml
func _user_0() -> void:
	GM.instance_create_depth(x, y, 0.0, A.obj_big_plant_dead)
	GM.audio_stop_sound(A.snd_big_pplant_dead)
	GM.audio_play_sound(A.snd_big_pplant_dead, 0.0, false)
	instance_destroy()


# from objects/obj_big_pplant/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, 1.0, 0.0, GM.c_white, 1.0)
