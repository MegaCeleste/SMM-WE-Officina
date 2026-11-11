extends "res://objects/obj_enemyparent_held.gd"

var key = null
var hitpoint: float = 0.0
var dead_h: float = 0.0
var apilar: float = 0.0
var show_key: float = 0.0
var imdead = null


# from objects/obj_galoomba_hold/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.15
	key = 0.0
	hitpoint = 0.0
	dead_h = 0.0
	apilar = 0.0
	shake = 0.0
	show_key = 1.0
	if object_index != A.obj_mechakoopa_held:
		alarm[2] = 540.0
		alarm[1] = 600.0


# from objects/obj_galoomba_hold/Destroy_0.gml
func _destroy() -> void:
	var i_levelmanager = GM.instance_find(A.obj_levelmanager, 0)
	super._destroy()
	if key == 1.0 and i_levelmanager.get("editor") == 0.0 and show_key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0


# from objects/obj_galoomba_hold/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(A.obj_player_warp):
		shake = 0.0
		alarm[2] = 540.0
		alarm[1] = 600.0
	else:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_galoomba)):
			inst.hspeed = (0.5 * GM.gm_sign(self.direct))
			inst.set("key", self.key)
			if self.gravity == 0.0:
				inst.vspeed = (-(1.0 + inst.get("swimming")))
		show_key = 0.0
		instance_destroy()


# from objects/obj_galoomba_hold/Alarm_2.gml
func _alarm_2() -> void:
	if held == 0.0:
		alarm[2] = 1.0
		if shake != 1.0:
			shake = 1.0
		else:
			shake = -1.0
	else:
		alarm[2] = 540.0
		alarm[1] = 600.0


# from objects/obj_galoomba_hold/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create((x + 8.0), (y + 8.0), A.obj_enemy_dead)
	imdead.set("girar", 1.0)
	imdead.set("direct", direct)
	imdead.image_index = G.apariencia
	if sprite_index == A.spr_galoomba_hold2:
		imdead.sprite_index = A.spr_galoomba2_deads
	else:
		imdead.sprite_index = A.spr_galoomba_deads
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
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


# from objects/obj_galoomba_hold/Other_11.gml
func _user_1() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if i_mario.stompstyle == 1.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(1)
		GM.other = _o
		GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_spinsmoke)
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
			key = 0.0
		instance_destroy()


# from objects/obj_galoomba_hold/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (x + shake), y, direct, 1.0, 0.0, GM.c_white, 1.0)
