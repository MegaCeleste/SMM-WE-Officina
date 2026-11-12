extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var w_wings: float = 0.0
var lava: float = 0.0


# from objects/obj_blooper/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_blooper
		1.0:
			sprite_index = A.spr_SMB3_blooper
		2.0:
			sprite_index = A.spr_blooper
		3.0:
			sprite_index = A.spr_NSMBU_blooper
	hardness = 0.0
	stomp = 0.0
	edible = 1.0
	direct = 1.0
	ready_v = 0.0
	wings = 0.0
	w_wings = 0.0
	modo_lava = 0.0
	dead_h = 0.0
	apilar = 0.0
	lava = 0.0
	paracaidas = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.0


# from objects/obj_blooper/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)
		if ready_v <= 0.5 and y > mario.y:
			ready_v = 1.0
			gravity = 0.0
			alarm[0] = 40.0
			if mario.x > x:
				motion_set(45.0, 1.5)
			else:
				motion_set(135.0, 1.5)
		elif ready_v <= 0.5 and gravity == 0.0 and y < mario.y:
			ready_v = 1.0
			gravity = 0.0
			alarm[0] = 40.0
			if mario.x > x:
				motion_set(45.0, 1.5)
			else:
				motion_set(135.0, 1.5)
	if ready_v == 0.0:
		gravity = 0.05
	if vspeed > 0.5:
		vspeed = 0.5


# from objects/obj_blooper/Step_2.gml
func _step_end() -> void:
	if vspeed < 0.0:
		if G.apariencia == 3.0:
			if sprite_index != A.spr_NSMBU_blooper_up:
				sprite_index = A.spr_NSMBU_blooper_up
				image_index = 0.0
			if image_index >= 11.5:
				image_index = 11.0
		else:
			image_index = 0.0  # PORT: 原版 image_single = 0（GM 旧内置变量：定格到第 0 帧）。用户确认 Blooper 会随上浮/下沉换帧；非 NSMBU 画风 image_speed 已是 0
	elif G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_blooper
	else:
		image_index = 1.0  # PORT: 原版 image_single = 1（定格到第 1 帧）


# from objects/obj_blooper/Alarm_0.gml
func _alarm_0() -> void:
	gravity = 0.05
	vspeed = 0.0
	hspeed = 0.0
	alarm[1] = 40.0


# from objects/obj_blooper/Alarm_1.gml
func _alarm_1() -> void:
	ready_v = 0.0


# from objects/obj_blooper/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.bg_level == "underwater":
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
		return
	else:
		super._collision_obj_mario(other)


# from objects/obj_blooper/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 16.0), A.obj_enemy_dead)
	imdead.direct = 1.0
	imdead.direct_y = -1.0
	match G.apariencia:
		3.0:
			imdead.sprite_index = A.spr_NSMBU_blooper
		_:
			imdead.sprite_index = sprite_index
	if G.apariencia == 3.0:
		imdead.image_speed = 0.2
	else:
		imdead.image_speed = 0.05
	hspeed = 0.0
	instance_destroy()


# from objects/obj_blooper/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_blooper/Other_24.gml
func _user_14() -> void:
	return


# from objects/obj_blooper/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, image_yscale, 0.0, GM.c_white, 1.0)
