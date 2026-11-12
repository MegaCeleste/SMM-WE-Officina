extends "res://objects/obj_big_pplant.gd"


# from objects/obj_big_pplant_b/Create_0.gml
func _create() -> void:
	sprite_index = A.spr_NSMBU_big_pplant_b
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


# from objects/obj_big_pplant_b/Other_10.gml
func _user_0() -> void:
	GM.instance_create_depth(x, y, 0.0, A.obj_big_plant_b_dead)
	GM.audio_stop_sound(A.snd_big_pplant_dead)
	GM.audio_play_sound(A.snd_big_pplant_dead, 0.0, false)
	instance_destroy()
