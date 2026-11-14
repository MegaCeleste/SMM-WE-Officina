extends "res://objects/obj_NSMBU_bowserjr.gd"


# from objects/obj_NSMBU_bowserjr_b/Create_0.gml
func _create() -> void:
	super._create()
	s_walk = A.spr_NSMBU_bowserjr_idle
	s_fire = A.spr_NSMBU_bowserjr_fire
	s_jump = A.spr_NSMBU_bowserjr_jump
	s_groundpount = A.spr_NSMBU_bowserjr_groundpount
	s_hammer = A.spr_NSMBU_bowserjr_hammer
	sprite_wings = A.spr_NSMBU_wings_enemigos
	wings_x = 14.0
	state = 1.0
	jump = 0.0
	groundpount = 0.0
	groundpount_cont = 0.0
	groundpount_anim = 0.0
	groundpount_jump = 0.0
	fire = 0.0
	fire_anim = 0.0
	cooldown = 0.0
	swimming = 0.0
	prevhspeed = 0.0
	image_speed = 0.5
	paracaidas = 0.0
	firehitpoints = 5.0
	key = 0.0
	paracaidas = 0.0
	hitpoints = 3.0
	alarm[10] = 2.0
