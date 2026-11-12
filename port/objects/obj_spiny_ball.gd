# from objects/obj_spiny_ball（第 6e 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，与 Godot Node 的 ready 冲突，改名 ready_v
var wings_anim: float = 0.0
var timer: float = 0.0
var go: float = 0.0


# from objects/obj_spiny_ball/Create_0.gml
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
	image_speed = 0.08
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	innave = 0.0
	ready_v = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	timer = 0.0
	go = 0.0


# from objects/obj_spiny_ball/Step_0.gml
func _step() -> void:
	var col_one_top
	if go == 1.0:
		y = (ystart + (sin((timer * 0.04375)) * 3.0))
		timer += 1.0
	hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
	if absf(hspeed) < 0.1:
		hspeed = 0.0
	vspeed = (maxf(0.0, (absf(vspeed) - 0.1)) * GM.gm_sign(vspeed))
	if absf(vspeed) < 0.1:
		vspeed = 0.0
	if go == 0.0 and speed == 0.0:
		ystart = y
		go = 1.0
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if swimming == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_spiny)):
			inst.direct = self.direct
		instance_destroy()
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o


# from objects/obj_spiny_ball/Other_24.gml
func _user_14() -> void:
	return
