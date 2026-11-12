extends GMObject

var direct: float = 0.0
var decender: float = 0.0


# from objects/obj_bowser_fire/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_fire_clown
		1.0:
			sprite_index = A.spr_SMB3_fire_clown_big
		2.0:
			sprite_index = A.spr_fire_clown_big
		3.0:
			sprite_index = A.spr_fire_clown_big
	image_speed = 0.25
	direct = -1.0
	decender = 0.0
	gravity = 0.0


# from objects/obj_bowser_fire/Step_0.gml
func _step() -> void:
	var valor: float = 0.0  # PORT: 原版 var valor 未赋初值（apariencia 为 0-3 时必被赋值）
	if hspeed > 0.0:
		direct = 1.0
	else:
		direct = -1.0
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -7.0
	if decender == 1.0:
		vspeed += 0.05
		match G.apariencia:
			0.0:
				valor = 10.0
			1.0:
				valor = 16.0
			2.0:
				valor = 10.0
			3.0:
				valor = 10.0
		if y >= (ystart + valor):
			decender = 0.0
			vspeed = 0.0
	elif decender == 2.0:
		vspeed -= 0.05
		match G.apariencia:
			0.0:
				valor = 10.0
			1.0:
				valor = 16.0
			2.0:
				valor = 10.0
			3.0:
				valor = 10.0
		if y <= (ystart - valor):
			decender = 0.0
			vspeed = 0.0


# from objects/obj_bowser_fire/Collision_obj_helmet.gml
func _collision_obj_helmet(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
	_user_0()


# from objects/obj_bowser_fire/Collision_obj_invincibility.gml
func _collision_obj_invincibility(other: GMObject) -> void:
	_user_0()


# from objects/obj_bowser_fire/Collision_obj_kuribo_drybones.gml
func _collision_obj_kuribo_drybones(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
	_user_0()


# from objects/obj_bowser_fire/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_bowser_fire/Collision_obj_shield_left.gml
func _collision_obj_shield_left(other: GMObject) -> void:
	if hspeed > 0.0:
		GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		_user_0()


# from objects/obj_bowser_fire/Collision_obj_shield_right.gml
func _collision_obj_shield_right(other: GMObject) -> void:
	if hspeed < 0.0:
		GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		_user_0()


# from objects/obj_bowser_fire/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_smokespin
	instance_destroy()


# from objects/obj_bowser_fire/Other_40.gml
func _outside_view_0() -> void:
	if object_index != A.obj_bowserfire_up:
		instance_destroy()


# from objects/obj_bowser_fire/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
