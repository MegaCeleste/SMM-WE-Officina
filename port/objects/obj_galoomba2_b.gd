extends "res://objects/obj_galoomba_b.gd"

var big: float = 0.0


# from objects/obj_galoomba2_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_goomba2_b
			goomba_stomped = A.snd_goomba_stomped
		1.0:
			sprite_index = A.spr_SMB3_goomba2_b
			goomba_stomped = A.snd_goomba_stomped
		2.0:
			sprite_index = A.spr_galoomba2_b
			goomba_stomped = A.snd_goomba_stomped
		3.0:
			sprite_index = A.spr_NSMBU_goombrat_b
			goomba_stomped = A.snd_goomba_stomped
	search_mario = 0.0
	hardness = 0.0
	stomp = 0.0
	direct = -1.0
	edible = 1.0
	wings = 0.0
	paracaidas = 0.0
	para_rot = 0.0
	key = 0.0
	jumping = 0.0
	anim = 0.0
	big = 0.0
	innave = 0.0
	dead_h = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	cambio_gombaya = 0.0
	startTime = GM.current_time
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	alarm[10] = 2.0
	alarm[0] = 120.0


# from objects/obj_galoomba2_b/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		_user_6()


# from objects/obj_galoomba2_b/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_galoomba2_deads_b
	imdead.image_index = G.apariencia
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 16.0), (y - 16.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_galoomba2_b/Other_11.gml
func _user_1() -> void:
	if wings == 1.0:
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", self.direct)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", -1.0 * 2.0)
			for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead)):
				inst.sprite_index = A.spr_wings_dead2
				inst.set("direct", -1.0 * 2.0)
		hspeed = 0.0
		alarm[10] = 2.0
		wings = 0.0
	else:
		if G.apariencia == 2.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_galoomba_hold2_b)):
				inst.set("key", self.key)
				inst.set("direct", self.direct)
			key = 0.0
			if key == 1.0 and G.apariencia != 2.0:
				for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
					inst.vspeed = -4.0
				key = 0.0
			instance_destroy()
		elif G.apariencia != 2.0:
			for inst in GM.with_list(GM.instance_create_depth(x - 32.0, y - 32.0, -2.0, A.obj_smoke_goomba)):
				if G.apariencia != 3.0:
					inst.direct = inst.direct * 2.0
					inst.image_xscale = 2.0
					inst.image_yscale = 2.0
				else:
					inst.direct = inst.direct * 2.0
					inst.image_xscale = 2.0
					inst.image_yscale = 2.0
			GM.audio_stop_sound(goomba_stomped)
			GM.audio_play_sound(goomba_stomped, 0.0, false)
			for inst in GM.with_list(GM.instance_create_depth(x + 24.0, y, 0.0, A.obj_galoomba2)):
				inst.vspeed = -3.0
				inst.hspeed = 0.5
			for inst in GM.with_list(GM.instance_create_depth(x - 24.0, y, 0.0, A.obj_galoomba2)):
				inst.vspeed = -3.0
				inst.hspeed = -0.5
		instance_destroy()


# from objects/obj_galoomba2_b/Other_15.gml
func _user_5() -> void:
	var imheld
	if G.apariencia < 2.0 or G.apariencia == 3.0:
		_user_0()
	elif G.apariencia == 2.0:
		imheld = GM.instance_create(x, (y - 2.0), A.obj_galoomba_hold2)
		if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
			if swimming == 1.0:
				imheld.vspeed = -1.8
			else:
				imheld.vspeed = -3.0
		imheld.set("direct", direct)
	instance_destroy()
