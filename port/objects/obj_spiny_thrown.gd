# from objects/obj_spiny_thrown（第 6e 批移植，已核对）
extends "res://objects/obj_spiny.gd"


# from objects/obj_spiny_thrown/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_spiny_ball
		1.0:
			sprite_index = A.spr_SMB3_spiny_ball
		2.0:
			sprite_index = A.spr_spiny_ball
		3.0:
			sprite_index = A.spr_NSMBU_spiny_ball
	image_speed = 0.1
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	innave = 0.0
	inup = 0.0
	draw_invert = 0.0
	ready_v = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	spiny = 0.0
	dead_h = 0.0


# from objects/obj_spiny_thrown/Step_0.gml
func _step() -> void:
	super._step()
	if gravity != 0.0:
		if vspeed < -2.2:
			gravity = 0.3
		else:
			gravity = 0.15
	if gravity == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_spiny)):
			inst.direct = self.direct
		instance_destroy()
