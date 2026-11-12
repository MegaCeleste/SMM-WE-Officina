extends "res://objects/obj_galoomba.gd"

var big: float = 0.0


# from objects/obj_galoomba2/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_goomba2
		1.0:
			sprite_index = A.spr_SMB3_goomba2
		2.0:
			sprite_index = A.spr_galoomba2
		3.0:
			sprite_index = A.spr_NSMBU_goombrat
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


# from objects/obj_galoomba2/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		_user_6()


# from objects/obj_galoomba2/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_galoomba2_deads
	imdead.image_index = G.apariencia
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
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


# from objects/obj_galoomba2/Other_11.gml
func _user_1() -> void:
	if wings == 1.0:
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", self.direct)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", -1.0)
			for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead)):
				inst.sprite_index = A.spr_wings_dead2
				inst.set("direct", -1.0)
		hspeed = 0.0
		alarm[10] = 2.0
		wings = 0.0
	else:
		match G.apariencia:
			0.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
					inst.sprite_index = A.spr_SMB_goomba2_stomped
			1.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
					inst.sprite_index = A.spr_SMB3_goomba2_stomped
			2.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_galoomba_hold2)):
					inst.set("key", self.key)
					inst.set("direct", self.direct)
				key = 0.0
			3.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
					inst.sprite_index = A.spr_NSMBU_goombrat_stomped
					inst.set("direct", self.direct)
		if key == 1.0 and G.apariencia != 2.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
			key = 0.0
		instance_destroy()


# from objects/obj_galoomba2/Other_15.gml
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
