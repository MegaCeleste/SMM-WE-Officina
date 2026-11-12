# from objects/obj_plantfire（第 5 批移植，已核对）
extends GMObject


# from objects/obj_plantfire/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_fireball
		1.0:
			sprite_index = A.spr_SMB3_fireball
		3.0:
			sprite_index = A.spr_NSMBU_fireball
	if G.apariencia == 3.0:
		image_speed = 0.25
		alarm[0] = 5.0
	else:
		image_speed = 0.15


# from objects/obj_plantfire/Step_0.gml
func _step() -> void:
	if Scr.outside_view(self) > 0.5:
		instance_destroy()


# from objects/obj_plantfire/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - (8.0 * GM.gm_sign(hspeed))), y, A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_fireparticle
	if hspeed == 1.0:
		alarm[0] = 10.0
	else:
		alarm[0] = 20.0


# from objects/obj_plantfire/Collision_obj_bullebill_base.gml
func _collision_obj_bullebill_base(other: GMObject) -> void:
	_user_0()


# from objects/obj_plantfire/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	instance_destroy()


# from objects/obj_plantfire/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	_user_0()


# from objects/obj_plantfire/Collision_obj_pinchos.gml
func _collision_obj_pinchos(other: GMObject) -> void:
	_user_0()


# from objects/obj_plantfire/Collision_obj_solid.gml
func _collision_obj_solid(other: GMObject) -> void:
	_user_0()


# from objects/obj_plantfire/Collision_obj_solidtop.gml
func _collision_obj_solidtop(other: GMObject) -> void:
	if bbox_bottom >= other.bbox_top:
		_user_0()


# from objects/obj_plantfire/Other_10.gml
func _user_0() -> void:
	GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_smoke)):
		if G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_fireball_destroy
	instance_destroy()
