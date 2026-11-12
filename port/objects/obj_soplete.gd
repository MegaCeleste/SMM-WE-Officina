extends "res://objects/obj_deactivation.gd"

var soplete: Array = []
var direct_t: float = 0.0
var rotacion: float = 0.0
var invisible: float = 0.0
var mysolid = null


# from objects/obj_soplete/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			GM.aset(soplete, 0, A.spr_SMB_soplete_start)
			GM.aset(soplete, 1, A.spr_SMB_soplete)
		1.0:
			GM.aset(soplete, 0, A.spr_SMB3_soplete_start)
			GM.aset(soplete, 1, A.spr_SMB3_soplete)
		2.0:
			GM.aset(soplete, 0, A.spr_soplete_start)
			GM.aset(soplete, 1, A.spr_soplete)
		3.0:
			GM.aset(soplete, 0, A.spr_NSMBU_soplete_start)
			GM.aset(soplete, 1, A.spr_NSMBU_soplete)
	direct_t = 0.0
	rotacion = 0.0
	invisible = 1.0
	mysolid = GM.instance_create((x - 8.0), (y - 8.0), A.obj_solid)
	if not GM.instance_exists(A.obj_soplete_global):
		GM.instance_create(0.0, 0.0, A.obj_soplete_global)
	alarm[0] = 2.0


# from objects/obj_soplete/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(mysolid):
		for inst in GM.with_list(mysolid):
			inst.instance_destroy()


# from objects/obj_soplete/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_soplete_global):
		var g = GM.instance_find(A.obj_soplete_global, 0)
		sprite_index = soplete[int(g.soplete_num)]
		image_index = g.image_index
		invisible = g.invisible


# from objects/obj_soplete/Alarm_0.gml
func _alarm_0() -> void:
	match direct_t:
		0.0:
			mask_index = A.spr_soplete_mask_up
		1.0:
			mask_index = A.spr_soplete_mask_right
		2.0:
			mask_index = A.spr_soplete_mask_down
		3.0:
			mask_index = A.spr_soplete_mask_left


# from objects/obj_soplete/Collision_obj_bobomb.gml
func _collision_obj_bobomb(other: GMObject) -> void:
	var bobomb
	if invisible == 0.0 and sprite_index == soplete[0] and other.object_index != A.obj_bobomb_ready:
		for inst in GM.with_list(other):
			bobomb = GM.instance_create(inst.x, inst.y, A.obj_bobomb_ready)
			bobomb.direct = inst.direct
			bobomb.wings = inst.wings
			bobomb.paracaidas = inst.paracaidas
			for inst2 in GM.with_list(bobomb):
				inst2.alarm[10] = 1.0
			inst.can_wings_deads = 0.0
			inst.instance_destroy()


# from objects/obj_soplete/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if sprite_index == soplete[1]:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_soplete/Draw_0.gml
func _gm_draw() -> void:
	if invisible == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, image_alpha)
	GM.draw_sprite_ext(A.spr_soplete_base, G.apariencia, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
